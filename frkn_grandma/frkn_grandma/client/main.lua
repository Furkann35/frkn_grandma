
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

local doktor = {
    {x = 992.97,y = 6436.2,z = 32.08}
}

frkn_grandmanpc = false

Citizen.CreateThread(function()
        Citizen.Wait(8000)
    while true do
        Citizen.Wait(0)
        local sleep = true
        for k in pairs(doktor) do
            local ped = PlayerPedId()
            local plyCoords = GetEntityCoords(ped, false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, doktor[k].x, doktor[k].y, doktor[k].z)
            if dist <= 2 then
            DrawText3Ds(992.97, 6436.2,32.08, "[E] - Grandma Tedavi ol")
            sleep = false
            if IsControlJustPressed(0, Keys['E']) then
            local closestPlayerPed = GetPlayerPed(closestPlayer)
            if IsPedDeadOrDying(closestPlayerPed, 1) then
                frkntedavi = true
                local finished = exports["frkn-taskbar"]:taskBar(15000,"Grandma tarafında tedavi ediliyorsun")
            TriggerEvent("frkn-tedaviet")
            TriggerServerEvent("parakes")
        else
            TriggerEvent("notification"," Tedavi olman için yaralı olman gerekiyor",2)
           end
         end
      end
    end
      if sleep then
        Citizen.Wait(200)
    end
  end
end)


RegisterNetEvent("frkn-tedaviet")
AddEventHandler("frkn-tedaviet", function() 
    TriggerEvent('esx_ambulancejob:revive')
    TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
    TriggerServerEvent('reload_death:revive', GetPlayerServerId(closestPlayer))
    TriggerServerEvent('reload_death:setDead', false)
if Config.NpInv then
    TriggerEvent("inventory:removeItem",Config.Item1, Config.ItemAmount1)  
    TriggerEvent("inventory:removeItem",Config.Item2, Config.ItemAmoun2) 
end   
if Config.Disc then
   TriggerServerEvent('disc:sil', Config.DiscItem1, Config.DiscItemAmount1)
   TriggerServerEvent('disc:sil', Config.DiscItem2, Config.DiscItemAmount2)
end
end)

Citizen.CreateThread(function()
        Citizen.Wait(8000)
    local frkn_grandmanpcped = GetHashKey("cs_mrs_thornhill")
    if not HasModelLoaded(frkn_grandmanpcped) then
        RequestModel(frkn_grandmanpcped)
        Citizen.Wait(3500)
    end
    while not HasModelLoaded(frkn_grandmanpcped) do
        Citizen.Wait(3500)
    end
    if not frkn_grandmanpc then
        local frkn_grandmaa = CreatePed(6, frkn_grandmanpcped, Config.NPCShop.x, Config.NPCShop.y, Config.NPCShop.z, Config.NPCShop.h, true, false)
        SetBlockingOfNonTemporaryEvents(frkn_grandmaa, true)
        SetPedDiesWhenInjured(frkn_grandmaa, false)
        SetPedCanPlayAmbientAnims(frkn_grandmaa, true)
        SetPedCanRagdollFromPlayerImpact(frkn_grandmaa, false)
        SetEntityInvincible(frkn_grandmaa, true)
        FreezeEntityPosition(frkn_grandmaa, true)
        loadAnimDict('amb@world_human_hang_out_street@Female_arm_side@idle_a')
        if not IsEntityPlayingAnim(frkn_grandmaa, "amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", 3) then
            TaskPlayAnim(frkn_grandmaa, "amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
        end
        Citizen.CreateThread(function()
            while true do 
                Citizen.Wait(0)
                if frkntedavi then 
                    Citizen.Wait(100)
                    ClearPedTasksImmediately(frkn_grandmaa)
                    loadAnimDict("mini@strip_club@private_dance@part3")
                    if not IsEntityPlayingAnim(frkn_grandmaa, "mini@strip_club@private_dance@part3", "priv_dance_p3", 3) then
                        TaskPlayAnim(frkn_grandmaa, "mini@strip_club@private_dance@part3", "priv_dance_p3", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
                    end 
                    Citizen.Wait(Config.PedAnimation) 
                    ClearPedTasksImmediately(frkn_grandmaa)
                    Citizen.Wait(50)
                    loadAnimDict('amb@world_human_hang_out_street@Female_arm_side@idle_a')
                    if not IsEntityPlayingAnim(frkn_grandmaa, "amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", 3) then
                        TaskPlayAnim(frkn_grandmaa, "amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
                    end
                    frkntedavi = false
                end
            end
        end)
    end
end)


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function loadAnimDict(dict)  
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(500)
    end
end
