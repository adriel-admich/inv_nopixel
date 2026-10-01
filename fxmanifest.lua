fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'inv_nopixel'
author 'adriel-admich'
description 'Inventário inspirado em NoPixel com compatibilidade Qbox/ox_inventory'
version '0.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/items.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/bridge.lua',
    'server/main.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/app.js',
    'web/style.css'
}

dependencies {
    'ox_lib'
}
