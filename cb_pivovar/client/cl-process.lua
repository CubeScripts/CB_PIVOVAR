local ox_inventory = exports.ox_inventory
local ox_target = exports.ox_target
local item = exports.ox_inventory:Items()


 ox_target:addSphereZone({
    coords = vector3(2431.5518, 4971.0449, 42.3476), 
    radius = 3,
    options = {
        {
            name = 'sphere',
            icon = 'fa-solid fa-dice',
            label =  "Udělat pivo",
            groups = 'pivar',
            onSelect = function()
                local options = {}
                local new_option 
                local item_count_beer
                for _, v in pairs(Config.Process) do 
                item_count_beer = ox_inventory:Search('count',v.itempro)
                new_option = {
                    title = "Plzen",
                    description = "3x chmel, 1x lahev",
                    disabled = disejbld,
                    onSelect = function ()
                      local input = lib.inputDialog('Zadejte počet ke zpracování', {'Počet'})
                      if not input then return end
                      if input and tonumber(input[1]) >=  0 then
                          if lib.progressCircle({
                            duration = 18000,
                            position = 'bottom',
                            label = 'dělas pivo',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                                move = true,
                            },
                            anim = {
                                dict = 'mini@repair',
                                clip = 'fixing_a_ped'
                            },
                        }) then 
                            TriggerServerEvent("pivovar:server:process", v.item, input[1])
                        end
                      end
                    end
                }
                table.insert(options, new_option)
                end
                lib.registerContext({
                  id = 'pivovar_process_menu',
                  title = "Pivovar - Udelaní piva",
                  options = options
                })
                lib.showContext('pivovar_process_menu')
            end,
        }
    },
})

-- 
  ox_target:addSphereZone({
    coords = vector3(2438.0720, 4966.5273, 42.3479), 
    radius = 3,
    options = {
        {
            name = 'sphere',
            icon = 'fa-solid fa-dice',
            label =  "Dat do sedu chmel",
            groups = 'pivar',
            onSelect = function()
                local options = {}
                local new_option 
                local item_count_beer
                for _, v in pairs(Config.ProcessTwo) do 
                item_count_beer = ox_inventory:Search('count',v.itemtwo)
                new_option = {
                    title = "Plzen",
                    description = "3x chmel, 1x lahev",
                    disabled = disejbld,
                    onSelect = function ()
                      local input = lib.inputDialog('Zadejte počet ke zpracování', {'Počet'})
                      if not input then return end
                      if input and tonumber(input[1]) >=  0 then
                          if lib.progressCircle({
                            duration = 18000,
                            position = 'bottom',
                            label = 'Předělavas chmel',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                                move = true,
                            },
                            anim = {
                                dict = 'mini@repair',
                                clip = 'fixing_a_ped'
                            },
                        }) then 
                            TriggerServerEvent("pivovar:server:processtwo", v.item, input[1])
                        end
                      end
                    end
                }
                table.insert(options, new_option)
                end
                lib.registerContext({
                  id = 'pivovar_processtwo_menu',
                  title = "Pivovar - Predelaní chmelu",
                  options = options
                })
                lib.showContext('pivovar_processtwo_menu')
            end,
        }
    },
})