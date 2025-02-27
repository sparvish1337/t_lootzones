fx_version 'cerulean'
game 'gta5'

author 'Z'
description 'Loot Zones Script for Qbox/Qbcore'
version '1.0.0'

shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'


dependencies {
    'qb-core', -- Dependency on qb-core
    'ox_target' -- Dependency on ox_target
}