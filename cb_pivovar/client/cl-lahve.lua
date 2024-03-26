local ox_target = exports.ox_target
local ox_inventory = exports.ox_inventory
local item = exports.ox_inventory:Items()

ox_target:addSphereZone({
  coords = vector3(1395.91, 3622.96, 35.01),
  radius = 3,
  options = {
      {
          name = 'sphere',
          icon = 'fa-solid fa-bottle-droplet',
          label =  "Skládka špinavých lahví",
          groups = 'pivar',
          onSelect = function()
              local options = {}
              local new_option 
              for _, v in pairs(Config.BuyBottlesItem) do 
                  item_count = ox_inventory:Search('count',v.item)
              new_option = {
                  title = item[v.item].label.." - $"..v.price,
                  description = 'Tady nalezneš dosti špinavé flašky, můžeš je umýt\n a budou vypadat jako nové!',
                  onSelect = function ()
                    local input = lib.inputDialog('Zadejte počet ke koupi', {'Počet'})
                    if not input then return end
                    if input and tonumber(input[1]) >=  0 then
                        if lib.progressCircle({
                          duration = 5000,
                          label = 'Kecáš s chábrem',
                          position = 'bottom',
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
                          TriggerServerEvent("pivovar:server:koupitlahve", v.item, input[1])
                      end
                    end
                  end
              }
              table.insert(options, new_option)
              end
              lib.registerContext({
                id = 'pivovar_buy_menu',
                title = 'Koupit flašky - Pivovar',
                options = options
              })
              lib.showContext('pivovar_buy_menu')
          end,
      }
  },
})

-- >> wash bottle << -- 

   ox_target:addSphereZone({
    coords = vector3(2439.6155, 4977.6450, 46.8106), 
    radius = 0.5,
    options = {
        {
            name = 'sphere',
            icon = 'fa-solid fa-faucet-drip',
            label =  'Umýt lahve',
            onSelect = function()
              local options = {}
              local new_option 
              local item_count
              for _, v in pairs(Config.BuyBottlesItem) do 
              item_count = ox_inventory:Search('count',v.item)
              local message 
              if item_count == 0 then
                message  = "Tady to vypadá, že u sebe nic nemáš.."
                disejbld = true
              else
                message  = "Aktuálně máš u sebe "..item_count.." kusů"
                disejbld = false
              end
              new_option = {
                  title = item[v.item].label,
                  description = message,
                  disabled = disejbld,
                  onSelect = function ()
                    local input = lib.inputDialog('Zadejte počet ke zpracování', {'Počet'})
                    if not input then return end
                    if input and tonumber(input[1]) >=  0 then
                        if lib.progressCircle({
                          duration = 18000,
                          position = 'bottom',
                          label = 'Zpracováváš suroviny',
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
                          TriggerServerEvent("pivovar:server:umytlahve", v.item, input[1])
                      end
                    end
                  end
              }
              table.insert(options, new_option)
              end
              lib.registerContext({
                id = 'pivovar_wash_menu',
                title = "Pivovar - Umytí lahve",
                options = options
              })
              lib.showContext('pivovar_wash_menu')
          end,
      }
  },
})
