
fx_version   'cerulean'
use_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

name         'fd_anchor'
author       'coblyox'
version      '1.0.0'
repository   'https://github.com/FelisDevelopment/fd_anchor'

dependencies {
	'/onesync',
}

shared_scripts {
	'init.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}
