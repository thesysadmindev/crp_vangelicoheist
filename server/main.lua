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
		print('test 1')
		TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
		print('test 2')
		TriggerClientEvent('crp_vangelicoheist:killblip', xPlayers[i])
	end

	if(robbers[source])then
		print('test 3')
		TriggerClientEvent('crp_vangelicoheist:toofarlocal', source)
		robbers[source] = nil
		print('test 4')
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
		print('test 5')
		TriggerClientEvent('esx:showNotification', xPlayers[i], _U('end'))
		print('test 6')
		TriggerClientEvent('crp_vangelicoheist:killblip', xPlayers[i])
	end

	if(robbers[source])then
		print('test 7')
		TriggerClientEvent('crp_vangelicoheist:robberycomplete', source)
		robbers[source] = nil
		print('test 8')
		TriggerClientEvent('esx:showNotification', source, _U('robbery_has_ended') .. Stores[robb].nameofstore)
	end
end)

RegisterServerEvent('crp_vangelicoheist:rob')
AddEventHandler('crp_vangelicoheist:rob', function(robb)
	print('test 1')

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetExtendedPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then

			print('test 9')
            TriggerClientEvent('crp_vangelicoheist:togliblip', source)
			print('test 10')
			TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (Config.SecBetwNextRob - (os.time() - store.lastrobbed)) .. _U('seconds'))
			return
		end

		if rob == false then

			print(, , )

			local xPlayer = ESX.GetPlayerFromId(source)
			local xPlayers = ESX.GetExtendedPlayers()
			rob = true
			TriggerEvent(
				"core_dispatch:addCall",
				"10-71",
				"Vangelico Robbery",
				{{icon = "fa-venus-mars", info = "male"}},
				{Stores["jewelry"].position.x, Stores["jewelry"].position.y, Stores["jewelry"].position.z},
				"police",
				5000,
				156,
				1
			)

			print('test 13')
			TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
			print('test 14')
			TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
			print('test 15')
			TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
			print('test 16')
			TriggerClientEvent('crp_vangelicoheist:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
		else
			print('test 17')
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

