local ox_inventory = exports.ox_inventory

RegisterNetEvent('pivovar:server:process')
AddEventHandler('pivovar:server:process', function(item, item_count )
  -- body
 for _, v in pairs(Config.Process) do 
        local item = "beer2"
        local itemprocess = "zpracovany_chmel"
        local flasky = "cisty_lahve"
        local total = 3 * item_count
        local item_count_s = item_count-1
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.canCarryItem(item,item_count) then
            math.randomseed(GetGameTimer())
              xPlayer.addInventoryItem(item, item_count)
            if xPlayer.canCarryItem(item,item_count) then
                math.randomseed(GetGameTimer())
            --xPlayer.addInventoryItem(item, item_count)
              if xPlayer.getInventoryItem(flasky).count > 0 then
             xPlayer.removeInventoryItem(flasky, item_count)

              if xPlayer.getInventoryItem(itemprocess).count > 0 then
             xPlayer.removeInventoryItem(itemprocess, total)
        else
            TriggerClientEvent('ox_lib:notify', xPlayer.source, {type = 'error', description = "CS"})
          end
        end
      end
    end
  end
end)

local ox_inventory = exports.ox_inventory

RegisterNetEvent('pivovar:server:processtwo')
AddEventHandler('pivovar:server:processtwo', function(item, item_count )
  -- body
 for _, v in pairs(Config.ProcessTwo) do 
        local items = "zpracovany_chmel"
        local itemprocesss = "raisin"
        local totals = 3 * item_count
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.canCarryItem(items, count) then
            math.randomseed(GetGameTimer())
            xPlayer.addInventoryItem(item , item_count)

              if xPlayer.getInventoryItem(itemprocesss).count > 0 then
             xPlayer.removeInventoryItem(itemprocesss, totals)
        else
          TriggerClientEvent('ox_lib:notify', xPlayer.source, {type = 'error', description = TranslateCap('inv_full')}) 
           end
        end
    end
end)