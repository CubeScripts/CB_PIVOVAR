local ox_target = exports.ox_target
local ox_inventory = exports.ox_inventory
local items = exports.ox_inventory:Items()

ESX = exports["es_extended"]:getSharedObject()
ESX.PlayerData = {}

lib.locale()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerLoaded = true
  ESX.PlayerData = xPlayer
  blipsCreate()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
  blipsCreate()
end)

local box = lib.zones.box({
  coords = vec3(266.1059, 6653.5005, 29.8811),
  size = vec3(40, 25, 5),
  rotation = 165,
  debug = false,
  onEnter = function()
    for _, harvestPoint in pairs(Config.Harvesting) do
      if harvestPoint.spawnProp then
          CreateThread(function()
              RequestModel(harvestPoint.model)
              local request = 1
              while not HasModelLoaded(harvestPoint.model) and request < 5 do
                  Wait(500)
                  request = request + 1
              end
              if HasModelLoaded(harvestPoint.model) then
                  local created_object = CreateObjectNoOffset(harvestPoint.model, harvestPoint.coords.x, harvestPoint.coords.y, harvestPoint.coords.z, 1, 0, 1)
                  PlaceObjectOnGroundProperly(created_object)
                  FreezeEntityPosition(created_object, true)
                  SetModelAsNoLongerNeeded(harvestPoint.model)
              else
                  SetModelAsNoLongerNeeded(harvestPoint.model)
              end
          end)
      end
  end
  end,
  onExit = function()
    for _, harvestPoint in pairs(Config.Harvesting) do
      if harvestPoint.spawnProp then
        local prop = GetClosestObjectOfType(harvestPoint.coords.x, harvestPoint.coords.y, harvestPoint.coords.z, 5.0, GetHashKey(harvestPoint.model), false, false, false)
        if DoesEntityExist(prop) then
          DetachEntity(prop, false, false)
          DeleteEntity(prop)
        end
      end
    end
  end
})

CreateThread(function()
 for _, v in pairs(Config.Harvesting) do 
  ox_target:addSphereZone({ 
      coords = v.coords, 
      radius = 1.7,
      debug = false,
      options = {  
          {
              name = 'sphere',
              icon = 'fa-solid fa-scissors',
              label =  v.label,
              groups = 'pivar',
              onSelect = function(data) 
                if v.status > 5 then
                  if v.minigame then
                    -- S minihrou
                    --ox_target:disableTargeting(true)
                    Wait(500)
                    local success = lib.skillCheck({'easy', 'easy'})

                      if success then

                        if lib.progressCircle({
                          duration = v.progresstime,
                          position = 'bottom',
                          label = 'Sbíráš '..v.progresslabel,
                          useWhileDead = false,
                          canCancel = true,
                          disable = {
                              car = true,
                              move = true,
                          },
                          anim = {
                              dict = 'mp_ped_interaction',
                              clip = 'hugs_guy_b'
                          },
                          prop = {
                              model = `v_ret_gc_scissors`,
                              pos = vec3(0.03, 0.03, 0.02),
                              rot = vec3(0.0, 0.0, -1.5)
                          },
                      }) then 
                        
                            TriggerSecureEvent("pivar:server:harvestItem", v.item)
                            v.status = v.status-10
                            ox_target:disableTargeting(false)
                        else 
                          ox_target:disableTargeting(false)
                        end
                        ox_target:disableTargeting(false)
                      else
                        ox_target:disableTargeting(false)
                    end
                  else
                    -- Bez minihry
                    --ox_target:disableTargeting(true)
                    if lib.progressCircle({
                        duration = v.progresstime,
                        position = 'bottom',
                        label = 'Sbíráš '..v.progresslabel,
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true,
                            move = true,
                        },
                        anim = {
                            dict = 'mp_ped_interaction',
                            clip = 'hugs_guy_b'
                        },
                        prop = {
                            model = `v_ret_gc_scissors`,
                            pos = vec3(0.03, 0.03, 0.02),
                            rot = vec3(0.0, 0.0, -1.5)
                        },
                    }) then 
                    
                        TriggerServerEvent("pivovar:server:harvest", v.item)
                        v.status = v.status-10
                        ox_target:disableTargeting(false)
                    else 
                    end
                  end
                else 
                  lib.notify({title="Pivovar",description="Zde si už sbíral dlouho.. Počkej až doroste..", type="error"})
                end
              end,
          }
      },
  })
end
end)

