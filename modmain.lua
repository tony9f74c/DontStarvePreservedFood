PrefabFiles = {
    "preserved_food",
}

Assets = {
    Asset( "IMAGE", "images/preserved_food.tex" ),
    Asset( "ATLAS", "images/preserved_food.xml" ),
}

local _G = GLOBAL
local STRINGS = _G.STRINGS
local RECIPETABS = _G.RECIPETABS
local Recipe = _G.Recipe
local Ingredient = _G.Ingredient
local TECH = _G.TECH
local getConfig = GetModConfigData
local KnownModIndex = _G.KnownModIndex
local Action = _G.Action
local ActionHandler = _G.ActionHandler
local ACTIONS = _G.ACTIONS
local CUSTOMTABS = GLOBAL.CUSTOM_RECIPETABS

local bbt = KnownModIndex:IsModEnabled("workshop-522117250") -- Check if Birds and Berries and Trees and Flowers for Friends is enabled
local mfr = KnownModIndex:IsModEnabled("workshop-861013495") -- Check if More Fruits is enabled

local dstPrefabs = {
    {name = "asparagus",            cfg = "Asparagus",          raw = "asparagus"},
    {name = "bananas",              cfg = "Bananas",            raw = "cave_banana"},
    {name = "berries",              cfg = "Berries",            raw = "berries"},
    {name = "berries_juicy",        cfg = "BerriesJuicy",       raw = "berries_juicy"},
    {name = "blue_shrooms",         cfg = "BlueShrooms",        raw = "blue_cap"},
    {name = "cactus",               cfg = "Cactus",             raw = "cactus_meat"},
    {name = "cactus_flowers",       cfg = "CactusFlowers",      raw = "cactus_flower"},
    {name = "carrots",              cfg = "Carrots",            raw = "carrot"},
    {name = "corn",                 cfg = "Corn",               raw = "corn"},
    {name = "dragonfruits",         cfg = "Dragonfruits",       raw = "dragonfruit"},
    {name = "durians",              cfg = "Durians",            raw = "durian"},
    {name = "eels",                 cfg = "Eels",               raw = "eel"},
    {name = "eggplants",            cfg = "Eggplants",          raw = "eggplant"},
    {name = "figs",                 cfg = "Figs",               raw = "fig"},
    {name = "fish",                 cfg = "Fish",               raw = "fish"},
    {name = "garlic",               cfg = "Garlic",             raw = "garlic"},
    {name = "glowberries",          cfg = "GlowBerries",        raw = "wormlight"},
    {name = "green_shrooms",        cfg = "GreenShrooms",       raw = "green_cap"},
    {name = "kelp",                 cfg = "KelpFronds",         raw = "kelp"},
    {name = "lesser_glowberries",   cfg = "LesserGlowBerries",  raw = "wormlight_lesser"},
    {name = "lichens",              cfg = "Lichens",            raw = "cutlichen"},
    {name = "lightbulbs",           cfg = "LightBulbs",         raw = "lightbulb"},
    {name = "moon_shrooms",         cfg = "MoonShrooms",        raw = "moon_cap"},
    {name = "onions",               cfg = "Onions",             raw = "onion"},
    {name = "peppers",              cfg = "Peppers",            raw = "pepper"},
    {name = "pomegranates",         cfg = "Pomegranates",       raw = "pomegranate"},
    {name = "potatoes",             cfg = "Potatoes",           raw = "potato"},
    {name = "pumpkins",             cfg = "Pumpkins",           raw = "pumpkin"},
    {name = "red_shrooms",          cfg = "RedShrooms",         raw = "red_cap"},
    {name = "stone_fruits",         cfg = "StoneFruits",        raw = "rock_avocado_fruit_ripe"},
    {name = "succulents",           cfg = "Succulents",         raw = "succulent_picked"},
    {name = "toma_roots",           cfg = "TomaRoots",          raw = "tomato"},
    {name = "watermelons",          cfg = "Watermelons",        raw = "watermelon"},
    
    {name = "meat",                 cfg = "Meat",               raw = "meat"},
    {name = "monster_meat",         cfg = "MonsterMeat",        raw = "monstermeat"},
    {name = "frog_legs",            cfg = "FrogLegs",           raw = "froglegs"},
    {name = "morsels",              cfg = "Morsels",            raw = "smallmeat"},
    {name = "raw_fish",             cfg = "RawFish",            raw = "fishmeat"},
    {name = "leafy_meat",           cfg = "LeafyMeat",          raw = "plantmeat"},
    {name = "fish_morsels",         cfg = "FishMorsels",        raw = "fishmeat_small"},

    -- {name = "mandrake_soup",    cfg = "MandrakeSoup",    raw = "mandrakesoup"},
    -- {name = "meaty_stew",       cfg = "MeatyStew",       raw = "bonestew"},
    -- {name = "meatballs",        cfg = "Meatballs",       raw = "meatballs"},
}

-- Birds and Berries and Trees for Friends
local bbtPrefabs = {
    {name = "apples",           cfg = "Apples",         raw = "treeapple"},
    {name = "blueberries",      cfg = "Blueberries",    raw = "berrybl"},
    {name = "greenberries",     cfg = "Greenberries",   raw = "berrygr"},
    {name = "pineapples",       cfg = "Pineapples",     raw = "pappfruit"},
}
if bbt then for k = 1, #bbtPrefabs, 1 do dstPrefabs[#dstPrefabs+1] = bbtPrefabs[k] end end

-- More Fruits
local mfPrefabs = {
    {name = "grapes",           cfg = "Grapes",         raw = "grapebbit"},
    {name = "lemons",           cfg = "Lemons",         raw = "lemonitem"},
    {name = "limes",            cfg = "Limes",          raw = "limelitem"},
    {name = "oranges",          cfg = "Oranges",        raw = "orangeitm"},
    {name = "strawberries",     cfg = "Strawberries",   raw = "strawbbit"},
    {name = "tomatoes",         cfg = "Tomatoes",       raw = "tomatobit"},
}
if mfr then for k = 1, #mfPrefabs, 1 do dstPrefabs[#dstPrefabs+1] = mfPrefabs[k] end end

STRINGS.NAMES.PRESERVED_ASPARAGUS = "Preserved Asparagus"
STRINGS.NAMES.PRESERVED_BANANAS = "Preserved Bananas"
STRINGS.NAMES.PRESERVED_BERRIES = "Preserved Berries"
STRINGS.NAMES.PRESERVED_BERRIES_JUICY = "Preserved Juicy Berries"
STRINGS.NAMES.PRESERVED_BLUE_SHROOMS = "Preserved Blue Mushrooms"
STRINGS.NAMES.PRESERVED_CACTUS = "Preserved Cactus"
STRINGS.NAMES.PRESERVED_CACTUS_FLOWERS = "Preserved Cactus Flowers"
STRINGS.NAMES.PRESERVED_CARROTS = "Preserved Carrots"
STRINGS.NAMES.PRESERVED_CORN = "Preserved Corn"
STRINGS.NAMES.PRESERVED_DRAGONFRUITS = "Preserved Dragonfruits"
STRINGS.NAMES.PRESERVED_DURIANS = "Preserved Durians"
STRINGS.NAMES.PRESERVED_EELS = "Preserved Eels"
STRINGS.NAMES.PRESERVED_EGGPLANTS = "Preserved Eggplants"
STRINGS.NAMES.PRESERVED_FISH = "Preserved Fish"
STRINGS.NAMES.PRESERVED_GARLIC = "Preserved Garlic"
STRINGS.NAMES.PRESERVED_GLOWBERRIES = "Preserved Glow Berries"
STRINGS.NAMES.PRESERVED_GREEN_SHROOMS = "Preserved Green Mushrooms"
STRINGS.NAMES.PRESERVED_HONEY = "Preserved Honey"
STRINGS.NAMES.PRESERVED_LESSER_GLOWBERRIES = "Preserved Glow Berries"
STRINGS.NAMES.PRESERVED_LICHENS = "Preserved Lichens"
STRINGS.NAMES.PRESERVED_LIGHTBULBS = "Preserved Light Bulbs"
STRINGS.NAMES.PRESERVED_MANDRAKE_SOUP = "Preserved Mandrake Soup"
STRINGS.NAMES.PRESERVED_MEATBALLS = "Preserved Meatballs"
STRINGS.NAMES.PRESERVED_MEATY_STEW = "Preserved Meaty Stew"
STRINGS.NAMES.PRESERVED_ONIONS = "Preserved Onions"
STRINGS.NAMES.PRESERVED_PEPPERS = "Preserved Peppers"
STRINGS.NAMES.PRESERVED_POMEGRANATES = "Preserved Pomegranates"
STRINGS.NAMES.PRESERVED_POTATOES = "Preserved Potatoes"
STRINGS.NAMES.PRESERVED_PUMPKINS = "Preserved Pumpkins"
STRINGS.NAMES.PRESERVED_RED_SHROOMS = "Preserved Red Mushrooms"
STRINGS.NAMES.PRESERVED_STONE_FRUITS = "Preserved Stone Fruits"
STRINGS.NAMES.PRESERVED_SUCCULENTS = "Preserved Succulents"
STRINGS.NAMES.PRESERVED_TOMA_ROOTS = "Preserved Toma Roots"
STRINGS.NAMES.PRESERVED_WATERMELONS = "Preserved Watermelons"
STRINGS.NAMES.PRESERVED_FIGS = "Preserved Figs"
STRINGS.NAMES.PRESERVED_KELP = "Preserved Kelp"
STRINGS.NAMES.PRESERVED_MOON_SHROOMS = "Preserved Moon Shrooms"

STRINGS.NAMES.PRESERVED_MEAT = "Preserved Meat"
STRINGS.NAMES.PRESERVED_MONSTER_MEAT = "Preserved Monster Meat"
STRINGS.NAMES.PRESERVED_FROG_LEGS = "Preserved Frog Legs"
STRINGS.NAMES.PRESERVED_MORSELS = "Preserved Morsels"
STRINGS.NAMES.PRESERVED_RAW_FISH = "Preserved Raw Fish"
STRINGS.NAMES.PRESERVED_LEAFY_MEAT = "Preserved Leafy Meat"
STRINGS.NAMES.PRESERVED_FISH_MORSELS = "Preserved Fish Morsels"

if bbt then
    STRINGS.NAMES.PRESERVED_APPLES = "Preserved Apples"
    STRINGS.NAMES.PRESERVED_BLUEBERRIES = "Preserved Blueberries"
    STRINGS.NAMES.PRESERVED_GREENBERRIES = "Preserved Greenberries"
    STRINGS.NAMES.PRESERVED_PINEAPPLES = "Preserved Pineapples"
end

if mfr then
    STRINGS.NAMES.PRESERVED_GRAPES = "Preserved Grapes"
    STRINGS.NAMES.PRESERVED_LEMONS = "Preserved Lemons"
    STRINGS.NAMES.PRESERVED_LIMES = "Preserved Limes"
    STRINGS.NAMES.PRESERVED_ORANGES = "Preserved Oranges"
    STRINGS.NAMES.PRESERVED_STRAWBERRIES = "Preserved Strawberries"
    STRINGS.NAMES.PRESERVED_TOMATOES = "Preserved Tomatoes"
end

-- RECIPES --

AddRecipeTab("Preserved Food", 101, "images/preserved_food.xml", "preserved_food.tex")

local recipeTabs = {
    CUSTOMTABS["Preserved Food"],
    RECIPETABS.TOOLS,
    RECIPETABS.SURVIVAL,
    RECIPETABS.FARM,
    RECIPETABS.SCIENCE,
    RECIPETABS.TOWN,
    RECIPETABS.REFINE,
    RECIPETABS.MAGIC,
}
local recipeTab = recipeTabs[getConfig("cfgRecipeTab")]

local recipeTechs = {
    TECH.NONE,
    TECH.SCIENCE_ONE, -- Science Machine
    TECH.SCIENCE_TWO, -- Alchemy Engine
    TECH.MAGIC_TWO, -- Prestihatitator
    TECH.MAGIC_THREE, -- Shadow Manipulator
    TECH.ANCIENT_TWO, -- Broken APS
    TECH.ANCIENT_FOUR, -- Repaired APS
}
local recipeTech = recipeTechs[getConfig("cfgRecipeTech")]

local honey = getConfig("cfgAddHoney") -- check if honey requirement is enabled
local nitre = getConfig("cfgAddNitre") -- check if nitre requirement is enabled
local function addRecipe(name, cfg, raw)
    local mats = {Ingredient(raw, getConfig("cfgRaw"..cfg)), honey and Ingredient("honey", getConfig("cfgHoney")) or nil, nitre and Ingredient("nitre", getConfig("cfgNitre")) or nil}
    return AddRecipe("preserved_"..name, mats, recipeTab, recipeTech, nil, nil, true, nil, nil, "images/inventoryimages/"..name..".xml")
end
-- Add recipes
for k = 1, #dstPrefabs, 1 do
    addRecipe(dstPrefabs[k].name, dstPrefabs[k].cfg, dstPrefabs[k].raw)
end
-- Add honey separately
AddRecipe("preserved_honey", {Ingredient("honey", getConfig("cfgRawHoney")), nitre and Ingredient("nitre", getConfig("cfgNitre")) or nil}, recipeTab, recipeTech, nil, nil, true, nil, nil, "images/inventoryimages/honey.xml")
-- Add dishes separately
AddRecipe("preserved_meatballs", {Ingredient("meatballs", getConfig("cfgPreservedMeatballs")), nitre and Ingredient("nitre", getConfig("cfgNitre")) or nil}, recipeTab, recipeTech, nil, nil, true, nil, nil, "images/inventoryimages/meatballs.xml")
AddRecipe("preserved_meaty_stew", {Ingredient("bonestew", getConfig("cfgPreservedMeatyStew")), nitre and Ingredient("nitre", getConfig("cfgNitre")) or nil}, recipeTab, recipeTech, nil, nil, true, nil, nil, "images/inventoryimages/meaty_stew.xml")
AddRecipe("preserved_mandrake_soup", {Ingredient("mandrakesoup", getConfig("cfgPreservedMandrakeSoup")), nitre and Ingredient("nitre", getConfig("cfgNitre")) or nil}, recipeTab, recipeTech, nil, nil, true, nil, nil, "images/inventoryimages/mandrake_soup.xml")

-- ACTION --

local OPEN_CAN = Action()
OPEN_CAN.str = "Open"
OPEN_CAN.id = "OPEN_CAN"
OPEN_CAN.fn = function(act)
    if act.invobject and act.invobject.components.preservedfood then
        local target = act.target or act.doer
        return act.invobject.components.preservedfood:Open(target)
    end
end
AddAction(OPEN_CAN)
AddStategraphActionHandler("wilson", ActionHandler(OPEN_CAN, "dolongaction"))
AddStategraphActionHandler("wilson_client", ActionHandler(OPEN_CAN, "dolongaction"))
AddComponentAction("INVENTORY", "preservedfood", function(inst, doer, actions, right)          
    table.insert(actions, ACTIONS.OPEN_CAN)
end)
