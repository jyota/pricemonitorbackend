module PriceMonitorBackend.Models

[<CLIMutable>]
type MonitorRequest =
    {
        Id : int64
        Url : string
        TargetText : string
    }
