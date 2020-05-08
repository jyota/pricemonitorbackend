module PriceMonitorBackend.Models


[<CLIMutable>]
type MonitorRequestAction =
    {
        Id : int64
        ActionId : int
        ActionTriggerId : int
        ActionTriggerThreshold : decimal
        ThresholdTypeId : int
        ActionTargetText : string
    }



[<CLIMutable>]
type MonitorRequest =
    {
        Id : int64
        Url : string
        TargetPrice : decimal
        RequestingUserId : int64
        MonitorRequestActions : array<MonitorRequestAction>
    }
