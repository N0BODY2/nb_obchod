Citizen.CreateThread(function()
        RequestModel(Config.Ped)
        while not HasModelLoaded(Config.Ped) do
            Wait(10)
        end
        ped = CreatePed(4, Config.Ped, Config.ObchodNPC, 213.01, false, true)
		FreezeEntityPosition(ped, true)
end)

function KupovaciMenu()
	inmenu = true
	local player = PlayerPedId()
	local elements = {}
			
	for k,v in pairs(Config.ItemsInPawnShop) do
		if v.BuyInPawnShop == true then
			table.insert(elements,
            {
                label = v.label .. " | "..('<span style="color:green;">%s</span>'):format("$"..v.BuyPrice..""), 
                itemName = v.itemName, 
                BuyInPawnShop = v.BuyInPawnShop, 
                BuyPrice = v.BuyPrice,
                value = 1, type = 'slider', min = 1, max = 100,
            })
		end
	end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), "obchod_kupovaci_menu",
			{
				title    = "What do you want to buy?",
				align    = "top-left",
				elements = elements
			},
		function(data, menu)
			print(data.current.value)
            TriggerServerEvent('nb_obchudek:server:mainevent', "buy", data.current.itemName, data.current.BuyPrice, data.current.value)
		end, function(data, menu)
			menu.close()
			inmenu = false
		end, function(data, menu)
	end)
end

function ProdejniMenu()
	inmenu = true
	local player = PlayerPedId()
	local elements = {}

    for k,v in pairs(Config.ItemsInPawnShop) do
		if v.SellInPawnShop == true then
			table.insert(elements,
            {
                label = v.label .. " | "..('<span style="color:green;">%s</span>'):format("$"..v.SellPrice..""), 
                itemName = v.itemName, 
                SellInPawnShop = v.SellInPawnShop,
                SellPrice = v.SellPrice,
                value = 1, type = 'slider', min = 1, max = 100,
            })
		end
	end
		
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "esx_PawnShop_sell_menu",
		{
			title    = "What do you want to sell?",
			align    = "top-left",
			elements = elements
		},
	function(data, menu)

			if data.current.itemName == data.current.itemName then
                TriggerServerEvent('nb_obchudek:server:mainevent', "sell", data.current.itemName, data.current.SellPrice , data.current.value)
			end	
            
        end, function(data, menu)
            menu.close()
			inmenu = false
        end, function(data, menu)
	end)
end

function DrawText3D(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)

	SetTextScale(0.25, 0.25)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 350
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
