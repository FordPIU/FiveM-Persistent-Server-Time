local ResourceName = nil;
local Time = nil;

function ServerFunctions.VerifyTime()
    if(ResourceName == nil) then ResourceName = GetCurrentResourceName() end;

    if(ServerFunctions.FileManager.DoesFileExist(ResourceName, "_Data/TimePersistency.json")) then
        Time = ServerFunctions.FileManager.LoadFile(ResourceName, "_Data/TimePersistency.json");
    else
        Time = {
            Year = math.random(2020, 2022),
            Month = math.random(1, 11),
            Day = math.random(1, 30),
            Hour = math.random(1, 23),
            Minute = math.random(1, 59),
            Second = math.random(1, 59)
        };

        ServerFunctions.FileManager.SaveFile(ResourceName, "_Data/TimePersistency.json", Time);
    end
end

function ServerFunctions.TickTime()
    Time.Second = Time.Second + 1;

    if(Time.Second == 60) then
        Time.Second = 0;
        Time.Minute = Time.Minute + 1;

        if(Time.Minute == 60) then
            Time.Minute = 0;
            Time.Hour = Time.Hour + 1;

            if(Time.Hour == 24) then
                Time.Hour = 0;
                Time.Day = Time.Day + 1;

                if(Time.Day == 32) then
                    Time.Day = 1;
                    Time.Month = Time.Month + 1;

                    if(Time.Month == 13) then
                        Time.Month = 1;
                        Time.Year = Time.Year + 1;
                    end
                end
            end
        end
    end

    GlobalState.TimeAndDate = Time;
end

function ServerFunctions.UpdateTimeFile()
    ServerFunctions.FileManager.SaveFile(ResourceName, "_Data/TimePersistency.json", Time);
end

ServerFunctions.VerifyTime();

SharedFunctions.TickBasedThreading.Append(1000, ServerFunctions.TickTime);
SharedFunctions.TickBasedThreading.Append(10000, ServerFunctions.UpdateTimeFile);