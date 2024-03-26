
local ox_target = exports.ox_target
ESX = exports["es_extended"]:getSharedObject()
ESX.PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function (xPlayer)
    ESX.Player_Loaded = true
    ESX.PlayerData = xPlayer
    blipsCreate()
    blipsCivialCreate()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function (job)
    ESX.PlayerData.job = job 
    blipsCreate()
end)



-- boss menu 
CreateThread(function()
  for k,v in pairs(Config.bossmenu) do
   ox_target:addBoxZone({
    coords = v,
    size = vec3(2, 2, 2),
    rotation = 45,
    debug = false,
    options = {
        {
            name = 'bossmenu',
            event = "bossmenu:open",
            icon = "fa-sharp fa-solid fa-wine-bottle",
            label = "bossmenu",
            distance = 2,
            groups = {['pivar'] = 3},
        }
    }
})
end
end)
  
RegisterNetEvent('bossmenu:open', function()
    if zone == 'BossActions' and PlayerData.job.grade_name == 'majitel' then
        CurrentAction     = 'menu_boss_actions'
        CurrentActionData = {}
      end
    TriggerEvent('esx_society:openBossMenu', 'pivar', function(data, menu)
        
        menu.close()
        CurrentAction = 'menu_boss_actions'
        CurrentActionData = {}
        end,options)
end)

  -- Create blips
local blips = {
  { title = "<FONT FACE='Fire Sans'>Pivovar - Sběr chmelu", colour = 31, id = 85, x = 273.6366, y = 6648.6626, z = 29.8267 },
  { title = "<FONT FACE='Fire Sans'>Pivovar - Prodej zboží", colour = 31, id = 85, x = -458.43, y = 264.08, z = 83.14 },
  { title = "<FONT FACE='Fire Sans'>Pivovar - Koupit Spinavé lahve", colour = 31, id = 85, x = 1395.91, y =3622.96, z = 35.01 },
  { title = "<FONT FACE='Fire Sans'>Pivovar - Vycistit lahve", colour = 31, id = 85, x = 2439.6155, y = 4977.6450, z =  46.8106 },
  { title = "<FONT FACE='Fire Sans'>Pivovar - Udelat piva", colour = 31, id = 85, x = 2438.0720, y =  4966.5273, z =  42.3479 },
  { title = "<FONT FACE='Fire Sans'>Pivovar - Sběr kukurice", colour = 31, id = 85, x = 362.6172, y =  6456.8647, z =  30.3597 },
}

function blipsCreate()
    
  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'pivar' then

      for _, info in pairs(blips) do
        local blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(blip, info.id)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, info.colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(blip)
    end
    end
end

local blipCivial = {
  { title = "<FONT FACE='Fire Sans'>Pivovar", colour = 31, id = 85, x = 2439.6155, y = 4977.6450, z =  46.8106 },

}

function blipsCivialCreate()
  -- creating blip
      for _, info in pairs(blipCivial) do
        local blipsCivial = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(blipsCivial, info.id)
        SetBlipDisplay(blipsCivial, 4)
        SetBlipScale(blipsCivial, 0.8)
        SetBlipColour(blipsCivial, info.colour)
        SetBlipAsShortRange(blipsCivial, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(blipsCivial)
      end
end