local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("nb_obchudek:server:mainevent")
AddEventHandler("nb_obchudek:server:mainevent", function(input, jmeno, kupnicena, mnozstvi)
	print(input)
	local xPlayer = ESX.GetPlayerFromId(source)
	local cena = (kupnicena * mnozstvi)
	if input == 'buy' then
		if xPlayer.getMoney() >= cena then
			xPlayer.removeMoney(cena)
			xPlayer.addInventoryItem(jmeno, mnozstvi)
		else
			xPlayer.showNotification('~r~Not Enough Money')
		end
	elseif input == 'sell' then
		if xPlayer.getInventoryItem(jmeno).count >= mnozstvi then
			xPlayer.addMoney(cena)
			xPlayer.removeInventoryItem(jmeno, mnozstvi)
		else
			xPlayer.showNotification('Not enough items')
		end
	end
end)
