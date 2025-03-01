fx_version 'cerulean'
game 'gta5'

author 'Kael Script'
description 'Review Script For Fivem Script'
version '1.0.0'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua',
}

server_scripts {
    'server/**.lua',
}

lua54 'yes'

