local ox_inventory = exports.ox_inventory

RegisterNetEvent('pivovar:server:koupitlahve')
AddEventHandler('pivovar:server:koupitlahve', function (item, item_count)
   for _, v in pairs(Config.BuyBottlesItem) do 
        local item = v.item

        local money = "money"
        local total = 25 * item_count
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.canCarryItem(item,item_count) then
            math.randomseed(GetGameTimer())

            if xPlayer.getInventoryItem(money).count > 24 then
             xPlayer.removeInventoryItem(money, total)
               xPlayer.addInventoryItem(item, item_count)
          end
         end
      end
end)

-- >> Wash  << --
RegisterNetEvent('pivovar:server:umytlahve')
AddEventHandler('pivovar:server:umytlahve', function (item, item_count)
     for _, v in pairs(Config.WashBottlesItem) do 
        local item = v.item

        local dirty = "dirty_bottle"
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.canCarryItem(item,item_count) then
            math.randomseed(GetGameTimer())

            if xPlayer.getInventoryItem(dirty).count > 0 then
             xPlayer.removeInventoryItem(dirty, item_count)
               xPlayer.addInventoryItem(item, item_count)
          end
         end
    end
end)


