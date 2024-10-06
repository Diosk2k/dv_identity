fx_version 'cerulean'
game 'gta5'
author 'DV Development'
description ' A custom identity resource for FiveM by Diosk'
version '1.0'

client_scripts {
    'client.lua',
    'html/index.html',
    'html/js/script.js',
    'html/css/style.css',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
}

files {
    'html/index.html',
    'html/js/script.js',
    'html/css/style.css',
}

ui_page 'html/index.html'