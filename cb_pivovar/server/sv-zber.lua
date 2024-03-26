ESX = nil

ESX = exports["es_extended"]:getSharedObject()

local ox_inventory = exports.ox_inventory
lib.locale()


RegisterNetEvent('pivovar:server:harvest')
AddEventHandler('pivovar:server:harvest', function (item)
    for _,v in pairs(Config.Harvesting) do
        local item = v.item
         end
   local count = math.random(4,8)
   local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.canCarryItem(item, count) then
        math.randomseed(GetGameTimer())
        xPlayer.addInventoryItem(item , count)
    else
        TriggerClientEvent('ox_lib:notify', xPlayer.source, {type = 'error', description = TranslateCap('inv_full')}) 
    end
end)