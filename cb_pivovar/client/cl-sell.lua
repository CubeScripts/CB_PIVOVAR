lib.locale()
local target = exports.ox_target
local inventory = exports.ox_inventory
local item = exports.ox_inventory:Items()

target:addSphereZone({ 
    coords = vector3(-458.19, 264.41, 83.15), 
    radius = 3,  
    options = {  
        {
            name = 'sphere',
            icon = 'fa-solid fa-hand-holding-dollar',
            label =  "Prodat zboží",
            groups = 'pivar',
            onSelect = function()
                local options = {}
                local new_option 
                local item_count_item = inventory:Search('count',item)
                for _, v in pairs(Config.Process) do 
                  local item = v.item
                local message 
                if item_count_item == 0 then
                  message  = "Tady to vypadá, že u sebe nic nemáš.."
                  disejbld = true
                else
                  message = "Jedna se prodava za 250$"
                  disejbld = false
                end
                new_option = {
                    title = "Plzen",
                    description = message,
                    disabled = disejbld,
                    onSelect = function ()
                      local input = lib.inputDialog('Zadejte počet k prodeji', {'Počet'})
                      if not input then return end
                      if input and tonumber(input[1]) >=  0 then
                          if lib.progressCircle({
                            duration = 10000,
                            position = 'bottom',
                            label = 'Dojednáváš podmínky',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                                move = true,
                            },
                            anim = {
                                dict = 'missheistdockssetup1ig_5@base',
                                clip = 'workers_talking_base_dockworker1'
                            },
                        }) then 
                            TriggerServerEvent("pivovar:server:sellStuff", v.item, input[1])
                        end
                      end
                    end
                }
                table.insert(options, new_option)
                end
                lib.registerContext({
                  id = 'pivovar_selling_menu',
                  title = "Pivovar - Prodej alkoholu",
                  options = options
                })
                lib.showContext('pivovar_selling_menu')
            end,
        }
    },
  })
  
