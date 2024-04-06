fx_version 'adamant'

game 'gta5'

lua54 'yes'

description 'Vangelico Robbery'

version '1.0.0'

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

dependencies {
	'es_extended'
}
