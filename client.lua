local QBCore = exports['qb-core']:GetCoreObject()
local Config = Config or require('config')

print("Config loaded:", json.encode(Config))

local lootProps = {}
local lootedLocations = {}

local function spawnLootAtCoords(coords, tier)
    local propModel = Config.LootProps[math.random(1, #Config.LootProps)]

    RequestModel(propModel)
    while not HasModelLoaded(propModel) do Wait(10) end

    local _, z = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, true)
    local prop = CreateObject(propModel, coords.x, coords.y, z, false, false, false)
    SetEntityAsMissionEntity(prop, true, true)
    PlaceObjectOnGroundProperly(prop)
    FreezeEntityPosition(prop, true)

    exports.ox_target:addLocalEntity(prop, {
        {
            name = 'loot_prop',
            icon = 'fa-solid fa-box-open',
            label = 'Search',
            distance = 2.0,
            onSelect = function(data)
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)

                RequestAnimDict("random@domestic")
                while not HasAnimDictLoaded("random@domestic") do Wait(10) end
                TaskPlayAnim(playerPed, "random@domestic", "pickup_low", 8.0, -8, 2000, 2, 0, 0, 0, 0)
                Wait(2000)

                TriggerServerEvent('t_lootzones:giveLoot', tier)

                local respawnTime = GetGameTimer() + (Config.RespawnCooldown * 1000)
                lootedLocations[coords] = { tier = tier, respawnTime = respawnTime }

                DeleteEntity(prop)
                exports.ox_target:removeLocalEntity(prop)
            end
        }
    })

    table.insert(lootProps, prop)
end

local function spawnLootInZone(zone)
    local tier = zone.tier
    local coords = zone.coords
    local radius = zone.radius

    for i = 1, math.random(3, 6) do
        local x = coords.x + math.random(-radius, radius)
        local y = coords.y + math.random(-radius, radius)
        local spawnCoords = vector3(x, y, coords.z)
        
        spawnLootAtCoords(spawnCoords, tier)
    end
end

local function initLootZones()
    for _, zone in ipairs(Config.LootZones) do
        spawnLootInZone(zone)
    end
end

CreateThread(function()
    while true do
        Wait(1000)
        local currentTime = GetGameTimer()

        for coords, data in pairs(lootedLocations) do
            if currentTime >= data.respawnTime then
                spawnLootAtCoords(coords, data.tier)
                lootedLocations[coords] = nil
            end
        end
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        initLootZones()
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, prop in ipairs(lootProps) do
            if DoesEntityExist(prop) then DeleteEntity(prop) end
        end
    end
end)
