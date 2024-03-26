fx_version 'cerulean'
game 'gta5'
lua54 'yes'

Author 'CUBE'
version '1.0' -- Beta

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'shared/SHARED_CONFIG.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'client/*.lua'
}

server_scripts { 
    '@es_extended/locale.lua',
    'server/*.lua',
    'server/options/*.lua'
}