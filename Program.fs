module PriceMonitorBackend.App

open System
open System.IO
open Microsoft.AspNetCore.Builder
open Microsoft.AspNetCore.Cors.Infrastructure
open Microsoft.AspNetCore.Hosting
open Microsoft.AspNetCore.Http
open Microsoft.Extensions.Logging
open Microsoft.Extensions.DependencyInjection
open Giraffe
open FSharp.Data.Npgsql
open Microsoft.Extensions.Hosting


// Database
[<Literal>]
let pricingmonitordb = "Host=127.0.0.1;Port=5433;Username=sa;Password=data1;Database=pricing_monitor_www"
type PricingMonitorDb = NpgsqlConnection<pricingmonitordb>


// ---------------------------------
// Web app
// ---------------------------------

let showUsers = 
    fun (next : HttpFunc) (ctx : HttpContext) ->
        use cmd = PricingMonitorDb.CreateCommand<"SELECT * FROM public.users">(pricingmonitordb)
        let result = cmd.Execute() in
            json (result |> Seq.map (fun row -> dict["first_name", row.first_name.Value; "email", row.email.Value])) next ctx

let webApp =
    choose [
        GET >=>
            choose [
                route "/users" >=> showUsers
            ]
        setStatusCode 404 >=> text "Not Found" ]

// ---------------------------------
// Error handler
// ---------------------------------

let errorHandler (ex : Exception) (logger : ILogger) =
    logger.LogError(ex, "An unhandled exception has occurred while executing the request.")
    clearResponse >=> setStatusCode 500 >=> text ex.Message

// ---------------------------------
// Config and Main
// ---------------------------------

let configureCors (builder : CorsPolicyBuilder) =
    builder.WithOrigins("http://localhost:5000")
           .AllowAnyMethod()
           .AllowAnyHeader()
           |> ignore

let configureApp (app : IApplicationBuilder) =
    let env = app.ApplicationServices.GetService<IWebHostEnvironment>()
    (match env.IsDevelopment() with
    | true  -> app.UseDeveloperExceptionPage()
    | false -> app.UseGiraffeErrorHandler errorHandler)
        .UseCors(configureCors)
        .UseStaticFiles()
        .UseGiraffe(webApp)

let configureServices (services : IServiceCollection) =
    services.AddCors()    |> ignore
    services.AddGiraffe() |> ignore

let configureLogging (builder : ILoggingBuilder) =
    builder.AddFilter(fun l -> l.Equals LogLevel.Error)
           .AddConsole()
           .AddDebug() |> ignore

[<EntryPoint>]
let main _ =
    WebHostBuilder()
        .UseKestrel()
        .Configure(Action<IApplicationBuilder> configureApp)
        .ConfigureServices(configureServices)
        .ConfigureLogging(configureLogging)
        .Build()
        .Run()
    0
