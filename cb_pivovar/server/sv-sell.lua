ESX = exports["es_extended"]:getSharedObject()

-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
--     PlayerData = xPlayer  
    
-- end)

-- RegisterNetEvent('esx:setJob')
-- AddEventHandler('esx:setJob', function(job)
--     PlayerData.job = job
-- end)

--TriggerEvent('esx_society:registerSociety', 'pivar', 'Pivovar', 'society_pivar', 'society_pivar', 'society_pivar', {type = 'private'})

RegisterNetEvent('pivovar:server:sellStuff')
AddEventHandler('pivovar:server:sellStuff', function(item, item_count_item)
local xPlayer  = ESX.GetPlayerFromId(source)
  if xPlayer.job.name == "pivar" then
  local societyAccount = nil

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_pivar', function(account)
    societyAccount = account
  end)

  local money = math.random()
  if xPlayer.getInventoryItem("beer2").count > 0 then
    xPlayer.removeInventoryItem("beer2", item_count_item)
    if societyAccount ~= nil then
      societyAccount.addMoney(money)
  elseif xPlayer.getInventoryItem("beer2").count < 0 then
    TriggerClientEvent('ox_lib:notify', xPlayer.source, {type = 'error', description = TranslateCap('white_need')})
  end
end
end
end)