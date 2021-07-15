ESX = nil
inmenu = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local coords = GetEntityCoords(PlayerPedId())
		local distance = #(coords - Config.Obchod)
		local sleep = true
		if distance < 10 and not inmenu then 
			DrawText3D(Config.ObchodNPC.x, Config.ObchodNPC.y, Config.ObchodNPC.z+2, '[E] SHOP')
			sleep = false
			if distance < 1 and IsControlJustPressed(0, 38) then 
				OpenObchodMenu()
			end			
		end
		if sleep then 
			Citizen.Wait(1500)
		end
	end
end)

function OpenObchodMenu()
	inmenu = true
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'obchod_hlavni_menu', {
        title    = 'How can i help you today?',
        align    = 'top-left',
        elements = {
			{ label = "<span style='color:green;'>Buy</span>", value = "koupit" },
			{ label = "<span style='color:red;'>Sell</span>", value = "prodat" },
        }
    }, function(data, menu)
        local action = data.current.value
        local player = PlayerPedId()
        
		if action == "koupit" then
			KupovaciMenu()
		elseif action == "prodat" then
			ProdejniMenu()
		end	

    end, function(data, menu)
        menu.close()
		inmenu = false
    end)
end
