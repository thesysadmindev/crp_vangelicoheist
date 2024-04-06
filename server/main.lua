local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

function CountCops()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetExtendedPlayers()
	CopsConnected = 0

	for _, xPlayer in pairs(xPlayers) do
		CopsConnected = CopsConnected + 1
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('crp_vangelicoheist:toofar')
AddEventHandler('crp_vangelicoheist:toofar', function(robb)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetExtendedPlayers()
	rob = false
	for _, xPlayer in pairs(xPlayers) do
		TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
		TriggerClientEvent('crp_vangelicoheist:killblip', xPlayers[i])
	end

	if(robbers[source])then
		TriggerClientEvent('crp_vangelicoheist:toofarlocal', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('crp_vangelicoheist:endrob')
AddEventHandler('crp_vangelicoheist:endrob', function(robb)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetExtendedPlayers()
	rob = false
	for _, xPlayer in pairs(xPlayers) do
		TriggerClientEvent('esx:showNotification', xPlayers[i], _U('end'))
		TriggerClientEvent('crp_vangelicoheist:killblip', xPlayers[i])
	end

	if(robbers[source])then
		TriggerClientEvent('crp_vangelicoheist:robberycomplete', source)
		robbers[source] = nil
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_ended') .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('crp_vangelicoheist:rob')
AddEventHandler('crp_vangelicoheist:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetExtendedPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then

            TriggerClientEvent('crp_vangelicoheist:togliblip', source)
			TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (Config.SecBetwNextRob - (os.time() - store.lastrobbed)) .. _U('seconds'))
			return
		end

		if rob == false then

			rob = true
			for _, xPlayer in pairs(xPlayers) do
				TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. store.nameofstore)
				TriggerClientEvent('crp_vangelicoheist:setblip', xPlayers[i], Stores[robb].position)
			end

			TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
			TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
			TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
			TriggerClientEvent('crp_vangelicoheist:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
		else
			TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
		end
	end
end)

RegisterServerEvent('crp_vangelicoheist:gioielli')
AddEventHandler('crp_vangelicoheist:gioielli', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem('diamond', math.random(Config.MinJewels, Config.MaxJewels))
end)

RegisterServerEvent('lester:vendita')
AddEventHandler('lester:vendita', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local reward = math.floor(Config.PriceForOneJewel * Config.MaxJewelsSell)

	xPlayer.removeInventoryItem('diamond', Config.MaxJewelsSell)
	xPlayer.addMoney(reward)
end)

ESX.RegisterServerCallback('crp_vangelicoheist:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

