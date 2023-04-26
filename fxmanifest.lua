fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"
lua54 'yes'
client_scripts {
	'client.lua',
	'config.lua'
}

server_scripts{
	'server.lua',
	'config.lua'
}
files {
    'config.lua'
}
shared_scripts {
   'config.lua'
}
