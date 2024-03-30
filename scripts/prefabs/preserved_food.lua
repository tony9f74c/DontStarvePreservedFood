local getConfig = GetModConfigData

local bbt = KnownModIndex:IsModEnabled("workshop-522117250") -- Check if Birds and Berries and Trees and Flowers for Friends is enabled
local mfr = KnownModIndex:IsModEnabled("workshop-861013495") -- Check if More Fruits is enabled

local function makePreservedFood(prefab, raw, cfg, cooked)
    local mult = getConfig("cfgPreserved"..cfg, "workshop-2709418733") or getConfig("cfgPreserved"..cfg, "DontStarvePreservedFood")
    
    local assets = {
        Asset("ATLAS", "images/inventoryimages/"..prefab..".xml"),
        Asset("IMAGE", "images/inventoryimages/"..prefab..".tex"),
        Asset("ANIM", "anim/preserved_food.zip"),
    }

    local function fn(Sim)
        local inst = CreateEntity()
        inst.entity:AddTransform()
        inst.entity:AddNetwork()
        MakeInventoryPhysics(inst)
        inst.entity:AddAnimState()
        inst.AnimState:SetBank("preserved_food")
        inst.AnimState:SetBuild("preserved_food")
        inst.AnimState:PlayAnimation(prefab)
    
        inst.entity:SetPristine()
        if not TheWorld.ismastersim then
            return inst
        end
    
        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.atlasname = "images/inventoryimages/"..prefab..".xml"
        inst.components.inventoryitem.cangoincontainer = true
        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
        if cooked ~= nil then
            inst:AddComponent("cookable")
            inst.components.cookable.oncooked = function ()
                local x, y, z = inst.Transform:GetWorldPosition()
                local player = FindClosestPlayerInRange(x, y, z, 2)
                for k = 1, mult , 1 do
                    player.components.inventory:GiveItem(SpawnPrefab(cooked))
                end
            end
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("preservedfood")
        inst.components.preservedfood.output = raw
        inst.components.preservedfood.outputAmount = mult

        return inst
    end

    return Prefab("preserved_"..prefab, fn, assets)
end

return
    makePreservedFood("asparagus",             "asparagus",                "Asparagus",            "asparagus_cooked"),
    makePreservedFood("bananas",               "cave_banana",              "Bananas",              "cave_banana_cooked"),
    makePreservedFood("berries",               "berries",                  "Berries",              "berries_cooked"),
    makePreservedFood("berries_juicy",         "berries_juicy",            "BerriesJuicy",         "berries_juicy_cooked"),
    makePreservedFood("blue_shrooms",          "blue_cap",                 "BlueShrooms",          "blue_cap_cooked"),
    makePreservedFood("cactus",                "cactus_meat",              "Cactus",               "cactus_meat_cooked"),
    makePreservedFood("cactus_flowers",        "cactus_flower",            "CactusFlowers"),
    makePreservedFood("carrots",               "carrot",                   "Carrots",              "carrot_cooked"),
    makePreservedFood("corn",                  "corn",                     "Corn",                 "corn_cooked"),
    makePreservedFood("dragonfruits",          "dragonfruit",              "Dragonfruits",         "dragonfruit_cooked"),
    makePreservedFood("durians",               "durian",                   "Durians",              "durian_cooked"),
    makePreservedFood("eels",                  "eel",                      "Eels",                 "eel_cooked"),
    makePreservedFood("eggplants",             "eggplant",                 "Eggplants",            "eggplant_cooked"),
    makePreservedFood("figs",                  "fig",                      "Figs",                 "fig_cooked"),
    makePreservedFood("fish",                  "fish",                     "Fish",                 "fish_cooked"),
    makePreservedFood("garlic",                "garlic",                   "Garlic",               "garlic_cooked"),
    makePreservedFood("glowberries",           "wormlight",                "GlowBerries"),
    makePreservedFood("green_shrooms",         "green_cap",                "GreenShrooms",         "green_cap_cooked"),
    makePreservedFood("honey",                 "honey",                    "Honey"),
    makePreservedFood("kelp",                  "kelp",                     "KelpFronds",           "kelp_cooked"),
    makePreservedFood("lesser_glowberries",    "wormlight_lesser",         "LesserGlowBerries"),
    makePreservedFood("lichens",               "cutlichen",                "Lichens"),
    makePreservedFood("lightbulbs",            "lightbulb",                "LightBulbs"),
    makePreservedFood("mandrake_soup",         "mandrakesoup",             "MandrakeSoup"),
    makePreservedFood("meatballs",             "meatballs",                "Meatballs"),
    makePreservedFood("meaty_stew",            "bonestew",                 "MeatyStew"),
    makePreservedFood("moon_shrooms",          "moon_cap",                 "MoonShrooms",          "moon_cap_cooked"),
    makePreservedFood("onions",                "onion",                    "Onions",               "onion_cooked"),
    makePreservedFood("peppers",               "pepper",                   "Peppers",              "pepper_cooked"),
    makePreservedFood("pomegranates",          "pomegranate",              "Pomegranates",         "pomegranate_cooked"),
    makePreservedFood("potatoes",              "potato",                   "Potatoes",             "potato_cooked"),
    makePreservedFood("pumpkins",              "pumpkin",                  "Pumpkins",             "pumpkin_cooked"),
    makePreservedFood("red_shrooms",           "red_cap",                  "RedShrooms",           "red_cap_cooked"),
    makePreservedFood("stone_fruits",          "rock_avocado_fruit_ripe",  "StoneFruits",          "rock_avocado_fruit_ripe_cooked"),
    makePreservedFood("succulents",            "succulent_picked",         "Succulents"),
    makePreservedFood("toma_roots",            "tomato",                   "TomaRoots",            "tomato_cooked"),
    makePreservedFood("watermelons",           "watermelon",               "Watermelons",          "watermelon_cooked"),

    makePreservedFood("meat",                  "meat",                     "Meat",                 "cookedmeat"),
    makePreservedFood("monster_meat",          "monstermeat",              "MonsterMeat",          "cookedmonstermeat"),
    makePreservedFood("frog_legs",             "froglegs",                 "FrogLegs",             "froglegs_cooked"),
    makePreservedFood("morsels",               "smallmeat",                "Morsels",              "cookedsmallmeat"),
    makePreservedFood("raw_fish",              "fishmeat",                 "RawFish",              "fishmeat_cooked"),
    makePreservedFood("leafy_meat",            "plantmeat",                "LeafyMeat",            "plantmeat_cooked"),
    makePreservedFood("fish_morsels",          "fishmeat_small",           "FishMorsels",          "fishmeat_small_cooked"),

    bbt and makePreservedFood("apples",        "treeapple",    "Apples") or nil,
    bbt and makePreservedFood("blueberries",   "berrybl",      "Blueberries",      "berrybl_cooked") or nil,
    bbt and makePreservedFood("greenberries",  "berrygr",      "Greenberries",     "berrygr_cooked") or nil,
    bbt and makePreservedFood("pineapples",    "pappfruit",    "Pineapples",       "pappfruit_cooked") or nil,

    mfr and makePreservedFood("grapes",        "grapebbit",    "Grapes",           "grapebbit_cooked") or nil,
    mfr and makePreservedFood("lemons",        "lemonitem",    "Lemons") or nil,
    mfr and makePreservedFood("limes",         "limelitem",    "Limes") or nil,
    mfr and makePreservedFood("oranges",       "orangeitm",    "Oranges") or nil,
    mfr and makePreservedFood("strawberries",  "strawbbit",    "Strawberries",     "strawbbit_cooked") or nil,
    mfr and makePreservedFood("tomatoes",      "tomatobit",    "Tomatoes",         "tomatobit_cooked") or nil