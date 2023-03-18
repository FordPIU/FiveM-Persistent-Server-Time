ClientFunctions = {};

function SetClientTime()
    local GlobalTime = GlobalState.TimeAndDate;

    if(GlobalTime ~= nil) then
        NetworkOverrideClockTime(GlobalTime.Hour, GlobalTime.Minute, GlobalTime.Second);
        SetClockDate(GlobalTime.Year, GlobalTime.Month, GlobalTime.Day);
    end
end

SharedFunctions.TickBasedThreading.Append(1, SetClientTime);