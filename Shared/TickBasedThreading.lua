SharedFunctions = {};
SharedFunctions.TickBasedThreading = {};

local Threads = {};

function SharedFunctions.TickBasedThreading.CreateNewThread(Milisecond)
    Citizen.CreateThread(function()
        local ms = Milisecond;
        local tf = Threads[ms];

        while true do
            Wait(ms)
            
            if(tf ~= nil and #tf > 0) then
                for _,v in pairs(tf) do
                    Citizen.CreateThread(v);
                end
            end
        end
    end)
end

function SharedFunctions.TickBasedThreading.Append(Milisecond, AppendedFunction)
    if(Threads[Milisecond] == nil) then
        Threads[Milisecond] = {};

        SharedFunctions.TickBasedThreading.CreateNewThread(Milisecond);
    end

    table.insert(Threads[Milisecond], AppendedFunction);
end