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
open PriceMonitorBackend.Models

// Database
[<Literal>]
let PricingMonitorDbConnectionString = "Host=127.0.0.1;Port=5433;Username=sa;Password=data1;Database=pricing_monitor_db"
type PricingMonitorDb = NpgsqlConnection<PricingMonitorDbConnectionString>


// ---------------------------------
// Web app
// ---------------------------------
let handleMonitorRequest (monitorRequest : MonitorRequest) =
    use conn = new Npgsql.NpgsqlConnection(PricingMonitorDbConnectionString)
    conn.Open()
    use tx = conn.BeginTransaction()
    use cmd = new NpgsqlCommand<"
        INSERT INTO intake.url_target (url, target_price, requesting_user_id)
        VALUES(@url, @target_price, @requesting_user_id)
        RETURNING id", PricingMonitorDbConnectionString>(conn, tx)
    let t = cmd.Execute(url = monitorRequest.Url, target_price = monitorRequest.TargetPrice, requesting_user_id = monitorRequest.RequestingUserId)
    tx.Commit()
    let result = {Id = t.Head; Url = monitorRequest.Url; TargetPrice = monitorRequest.TargetPrice; RequestingUserId = monitorRequest.RequestingUserId; MonitorRequestActions = [||]}
    printfn "%s" (result.ToString())
    Successful.OK result


let webApp =
    choose [
        POST >=>
            choose [
                route "/api/pricing/v1/monitors" >=> bindJson<MonitorRequest> handleMonitorRequest
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
