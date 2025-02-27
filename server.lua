local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-lootzones:giveLoot', function(tier)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local lootTable = Config.LootTables[tier]
    if not lootTable or #lootTable == 0 then return end

    local loot = lootTable[math.random(1, #lootTable)]
    local amount = math.random(loot.min, loot.max)

    Player.Functions.AddItem(loot.item, amount)
    TriggerClientEvent('QBCore:Notify', src, "You found " .. amount .. "x " .. loot.item, 'success')
end)
