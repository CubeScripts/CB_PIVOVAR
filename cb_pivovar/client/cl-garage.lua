
local ox_target = exports.ox_target

ESX = exports["es_extended"]:getSharedObject()


CreateThread(function()
	-- body
	local model = GetHashKey(Config.GaragePed)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
	for _, item  in pairs(Config.GarageCoords) do
		npc = CreatePed(1, model, item.x, item.y, item.z,item.h, false, true)

		FreezeEntityPosition(npc, true)
        SetEntityHeading(npc, item.h)
        SetEntityInvincible(npc, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        ox_target:addLocalEntity(npc, {
            {
                name = 'Garage',
                event = 'garage:menu',
                icon = 'fa-sharp fa-solid fa-wine-bottle',
                label = "Jit do garage",
                distance = 2,
		        groups = "pivar",
            }
        })    
    end
end)

RegisterNetEvent('garage:menu', function()
    lib.registerContext({
        id = 'GarageMenu',
        title = "Garage",
        options = {
            {
                title = 'Van',
                event = 'garage:van'
            },
            {
                title = 'Pick-UP',
                event = 'garage:pickup'
            },
	    {
                title = 'Return car',
                event = 'garage:returnVehicle'
            }
        },
    })
    	lib.showContext('GarageMenu')
end)

RegisterNetEvent('garage:van')
AddEventHandler('garage:van',function()
    ESX.Game.SpawnVehicle(Config.InGarage.model,vec3(2479.5256, 4951.8052, 45.0017), 257.0, function(vehicle)
    end)
end)

RegisterNetEvent('garage:pickup')
AddEventHandler('garage:pickup',function()
    ESX.Game.SpawnVehicle(Config.InGarage.modeltwo, vec3(2479.5256, 4951.8052, 45.0017), 257.0, function(vehicle)
    end)
end)

RegisterNetEvent('garage:returnVehicle')
AddEventHandler('garage:returnVehicle', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if DoesEntityExist(vehicle) then
        ESX.Game.DeleteVehicle(vehicle)
        lib.notify({title="Pivovar",description="uspesne jsi vratil vozidlo", type="error"})
        -- uspesne jsi vratil vozidlo
    else
         lib.notify({title="pivovar",description="Tohle neni auto co jsi mel odevzat", type="error"})
        -- Tohle neni auto co jsi mel odevzat
    end
end)
