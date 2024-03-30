name = "Preserved Food"
description = "Preserve your food forever!"
author = "Tony"
version = "240330"
forumthread = ""
api_version = 10
all_clients_require_mod = true
dst_compatible = true
client_only_mod = false
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"preserved", "food"}

local function setCount(k)
    return {description = ""..k.."", data = k}
end

local function setTab(k)
    local name = {"Custom", "Tools", "Survival", "Farm", "Science", "Structures", "Refine", "Magic"}
    return {description = ""..name[k].."", data = k}
end

local function setTech(k)
    local name = {"None", "Science Machine", "Alchemy Engine", "Prestihatitator", "Shadow Manip.", "Broken APS", "Repaired APS"}
    return {description = ""..name[k].."", data = k}
end

local tab = {} for k=1,7,1 do tab[k] = setTab(k) end
local tech = {} for k=1,7,1 do tech[k] = setTech(k) end
local ingredient = {} for k=1,20,1 do ingredient[k] = setCount(k) end
local toggle = {{description = "Yes", data = true}, {description = "No", data = false},}

local function rawIngredients(name, desc)
    local ext = desc ~= nil and desc or name
    return {name = "cfgRaw"..name, label = "Raw "..ext, options = ingredient, default = 10, hover = "The amount of items required to craft a can."}
end

local function preservedIngredients(name, desc)
    local ext = desc ~= nil and desc or name
    return {name = "cfgPreserved"..name, label = ""..ext.." from can", options = ingredient, default = 7, hover = "The amount of items you get from opening a can. Same goes for directly cooking a can."}
end

local function preparedFoods(name, desc)
    local ext = desc ~= nil and desc or name
    return {name = "cfgPreserved"..name, label = ""..ext.." to and from can", options = ingredient, default = 1, hover = "The amount of items required to craft a can as well as what you get from opening it."}
end

local dstPrefabs = {
    {"Asparagus"},
    {"Bananas"},
    {"Berries"},
    {"BerriesJuicy", "Juicy Berries"},
    {"BlueShrooms", "Blue Mushrooms"},
    {"Cactus", "Cactus Flesh"},
    {"CactusFlowers", "Cactus Flowers"},
    {"Carrots"},
    {"Corn"},
    {"Dragonfruits"},
    {"Durians"},
    {"Eels"},
    {"Eggplants"},
    {"Figs"},
    {"Fish"},
    {"Garlic"},
    {"GlowBerries", "Glow Berries"},
    {"GreenShrooms", "Green Mushrooms"},
    {"Honey"},
    {"KelpFronds", "Kelp Fronds"},
    {"LesserGlowBerries", "Lesser Glow Berries"},
    {"Lichens"},
    {"LightBulbs", "Light Bulbs"},
    {"MoonShrooms", "Moon Shrooms"},
    {"Onions"},
    {"Peppers"},
    {"Pomegranates"},
    {"Potatoes"},
    {"Pumpkins"},
    {"RedShrooms", "Red Mushrooms"},
    {"StoneFruits", "Stone Fruits"},
    {"Succulents"},
    {"TomaRoots", "Toma Roots"},
    {"Watermelons"},

    {"Meat"},
    {"MonsterMeat", "Monster Meat"},
    {"FrogLegs", "Frog Legs"},
    {"Morsels"},
    {"RawFish", "Raw Fish"},
    {"LeafyMeat", "Leafy Meat"},
    {"FishMorsels", "Fish Morsels"},

    -- {"Meatballs"},
    -- {"MeatyStew", "Meaty Stew"},
    -- {"MandrakeSoup", "Mandrake Soup"},
}

local bbtPrefabs = { -- Birds and Berries and Trees and Flowers for Friends
    {"Apples"},
    {"Blueberries"},
    {"Greenberries"},
    {"Pineapples"},
}

local mfrPrefabs = { -- More Fruits
    {"Grapes"},
    {"Lemons"},
    {"Limes"},
    {"Oranges"},
    {"Tomatoes"},
    {"Strawberries"},
}

local function addDivider(name, title)
    return {name = "cfg"..name.."Title", label = title, options = {{description = "", data = false},}, default = false}
end

options = {
    addDivider("CNF", "Preserved Food Settings"),
    {name = "cfgRecipeTab", label = "Recipe Tab", options = tab, default = 1, hover = "The crafting tab on which the recipe is found."},
    {name = "cfgRecipeTech", label = "Recipe Tech", options = tech, default = 2, hover = "The research building required to see/craft the recipe."},
    {name = "cfgAddHoney", label = "Honey Required", options = toggle, default = true, hover = "Toggle whether Honey is required or not."},
    {name = "cfgHoney", label = "How Much Honey", options = ingredient, default = 10, hover = "The amount of Honey required to craft."},
    {name = "cfgAddNitre", label = "Nitre Required", options = toggle, default = true, hover = "Toggle whether Nitre is required or not."},
    {name = "cfgNitre", label = "How Much Nitre", options = ingredient, default = 1, hover = "The amount of Nitre required to craft."}
}

local function addOptions(table)
    for k=1, #table, 1 do -- raw and preserved ingredients
        desc = table[k][2] ~= nil
        options[#options+1] = rawIngredients(table[k][1], desc and table[k][2])
        options[#options+1] = preservedIngredients(table[k][1], desc and table[k][2])
    end
end

addOptions(dstPrefabs)

options[#options+1] = addDivider("PRP", "Prepared Foods")
options[#options+1] = preparedFoods("Meatballs")
options[#options+1] = preparedFoods("MeatyStew", "Meaty Stew")
options[#options+1] = preparedFoods("MandrakeSoup", "Mandrake Soup")

options[#options+1] = addDivider("BBT", "Birds and Berries and Trees")
addOptions(bbtPrefabs)

options[#options+1] = addDivider("MFR", "More Fruits")
addOptions(mfrPrefabs)

configuration_options = options