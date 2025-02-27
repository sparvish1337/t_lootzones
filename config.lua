Config = {}

-- Loot Zones Configuration
Config.LootZones = {
    { tier = "low", coords = vector3(124.8107, -1071.8347, 29.1923), radius = 10.0 },
    { tier = "medium", coords = vector3(73.1340, -1054.9486, 29.4266), radius = 20.0 },
    { tier = "high", coords = vector3(70.3375, -1139.5919, 29.2709), radius = 30.0 },
}

Config.LootProps = { -- Lootable props that spawn inside the zone
    "prop_box_wood01a",
    "prop_box_wood02a",
    "v_res_fh_crateclosed",
    "v_ind_ss_box04",
    "v_res_filebox01",
}

Config.LootTables = { -- Loot tables for each tier
    low = {
        { item = "water", min = 1, max = 3 },
        { item = "bread", min = 1, max = 2 },
        { item = "bandage", min = 1, max = 1 },
        { item = "cash", min = 10, max = 100 },

    },
    medium = {
        { item = "water", min = 2, max = 4 },
        { item = "bread", min = 2, max = 3 },
        { item = "bandage", min = 1, max = 2 },
        { item = "ammo-9", min = 1, max = 30 },
        { item = "cash", min = 10, max = 100 },
    },
    high = {
        { item = "water", min = 3, max = 5 },
        { item = "bread", min = 3, max = 4 },
        { item = "bandage", min = 2, max = 3 },
        { item = "ammo-9", min = 2, max = 30 },
        { item = "weapon_pistol", min = 1, max = 1 },
        { item = "cash", min = 10, max = 100 },
    },
}

Config.RespawnCooldown = 300 -- Respawn cooldown in seconds

return Config
