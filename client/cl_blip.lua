if Config.EnableBlip then
    Citizen.CreateThread(function()
        local blip = AddBlipForCoord(Config.Obchod)
        SetBlipSprite(blip, Config.BlipSprite)
        SetBlipDisplay(blip, Config.BlipDisplay)
        SetBlipScale  (blip, Config.BlipScale)
        SetBlipColour (blip, Config.BlipColour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.BlipName)
        EndTextCommandSetBlipName(blip)
    end)
end