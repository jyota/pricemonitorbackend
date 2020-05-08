module PriceMonitorBackend.Models


[<CLIMutable>]
type MonitorRequestAction =
    {
        Id : int64
        Action : string
        ActionTrigger : string
        ActionTriggerThreshold : string
        ThresholdType : string
        TargetText : string
    }



[<CLIMutable>]
type MonitorRequest =
    {
        Id : int64
        Url : string
        TargetText : string
        MonitorRequestActions : array<MonitorRequestAction>
    }
