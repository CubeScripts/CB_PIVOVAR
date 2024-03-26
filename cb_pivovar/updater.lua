local logo = [[
    _____ _    _ ____  ______    _____  _____ _____  _____ _____ _______ _____ 
    / ____| |  | |  _ \|  ____|  / ____|/ ____|  __ \|_   _|  __ \__   __/ ____|
   | |    | |  | | |_) | |__    | (___ | |    | |__) | | | | |__) | | | | (___  
   | |    | |  | |  _ <|  __|    \___ \| |    |  _  /  | | |  ___/  | |  \___ \ 
   | |____| |__| | |_) | |____   ____) | |____| | \ \ _| |_| |      | |  ____) |
    \_____|\____/|____/|______| |_____/ \_____|_|  \_\_____|_|      |_| |_____/                                                                     
          Creator: cannabisforme
          support: https://discord.gg/HZP7Bcx2Tn                                                                                
]]
print(logo)

local curVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
local resourceName = "cb_pivovar"

if Config.checkForUpdates then
    CreateThread(function()
        if GetCurrentResourceName() ~= "cb_pivovar" then
            resourceName = "cb_pivovar (" .. GetCurrentResourceName() .. ")"
        end
    end)

    CreateThread(function()
        while true do
            PerformHttpRequest("https://api.github.com/repos/CubeScripts/CB_PIVOVAR/releases/latest", CheckVersion, "GET")
            Wait(3600000)
        end
    end)

    CheckVersion = function(err, responseText, headers)
        local repoVersion, repoURL, repoBody = GetRepoInformations()

        CreateThread(function()
            if curVersion ~= repoVersion then
                Wait(4000)
                print(logo)
                print("^0[^3WARNING^0] " .. resourceName .. " is ^1NOT ^0up to date!")
                print("^0[^3WARNING^0] Your Version: ^2" .. curVersion .. "^0")
                print("^0[^3WARNING^0] Latest Version: ^2" .. repoVersion .. "^0")
                print("^0[^3WARNING^0] Get the latest Version from: ^2" .. repoURL .. "^0")
                print("^0[^3WARNING^0] Changelog:^0")
                print("^1" .. repoBody .. "^0")
            else
                Wait(4000)
                print("^0[^2INFO^0] " .. resourceName .. " is up to date! (^2" .. curVersion .. "^0)")
            end
        end)
    end

    GetRepoInformations = function()
        local repoVersion, repoURL, repoBody = nil, nil, nil

        PerformHttpRequest("https://api.github.com/repos/CubeScripts/CB_PIVOVAR/releases/latest", function(err, response, headers)
            if err == 200 then
                local data = json.decode(response)

                repoVersion = data.tag_name
                repoURL = data.html_url
                repoBody = data.body
            else
                repoVersion = curVersion
                repoURL = "https://github.com/CubeScripts/CB_PIVOVAR/tree/main/cb_pivovar"
            end
        end, "GET")

        repeat
            Wait(50)
        until (repoVersion and repoURL and repoBody)

        return repoVersion, repoURL, repoBody
    end
end