local variant = Tracker.ActiveVariantUID
local items_only = variant:find("itemsonly")
local no_pins = variant:find("no_pins")
ENABLE_DEBUG_LOG = false

-- scripts
ScriptHost:LoadScript("scripts/custom_items/class.lua")
ScriptHost:LoadScript("scripts/custom_items/custom_item_character.lua")
ScriptHost:LoadScript("scripts/custom_items/character.lua")
ScriptHost:LoadScript("scripts/custom_items/custom_item_orb.lua")
ScriptHost:LoadScript("scripts/custom_items/orb.lua")

-- custom items
-- character
CHAR_OBJS = {
    boy = CharacterItem("Boy", "boy"),
    girl = CharacterItem("Girl", "girl"),
    sprite = CharacterItem("Sprite", "sprite"),
}
-- orbs
ORB_OBJS = {
    et_orb = OrbItem("Earth Temple Orb", "et_orb"),
    uf_orb = OrbItem("Upper Land Forest Orb", "uf_orb"),
    mc_orb = OrbItem("Matango Cave Orb", "mc_orb"),
    fp_orb1 = OrbItem("Fire Palace Orb 1", "fp_orb1"),
    fp_orb2 = OrbItem("Fire Palace Orb 2", "fp_orb2"),
    fp_orb3 = OrbItem("Fire Palace Orb 3", "fp_orb3"),
    mp_orb = OrbItem("Moon Palace Orb", "mp_orb"),
    gp_orb1 = OrbItem("Grand Palace Orb", "gp_orb1"),
    gp_orb2 = OrbItem("Grand Palace Orb", "gp_orb2"),
    gp_orb3 = OrbItem("Grand Palace Orb", "gp_orb3"),
    gp_orb4 = OrbItem("Grand Palace Orb", "gp_orb4"),
    gp_orb5 = OrbItem("Grand Palace Orb", "gp_orb5"),
    gp_orb6 = OrbItem("Grand Palace Orb", "gp_orb6"),
    gp_orb7 = OrbItem("Grand Palace Orb", "gp_orb7")
}

ScriptHost:LoadScript("scripts/utils.lua")
ScriptHost:LoadScript("scripts/logic.lua")
-- items
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/orbs.json")
Tracker:AddItems("items/hints.json")
Tracker:AddItems("items/settings.json")
if not items_only then
    -- maps
    Tracker:AddMaps("maps/maps.json")
    -- locations
    Tracker:AddLocations("locations/locations.json")
    Tracker:AddLocations("locations/hints.json")
end
-- layouts
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/broadcast.json")
Tracker:AddLayouts("layouts/tracker.json")

-- autotracking
if PopVersion then
    ScriptHost:LoadScript("scripts/watches.lua")
    ScriptHost:LoadScript("scripts/autotracking.lua")
end