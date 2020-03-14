local variant = Tracker.ActiveVariantUID
local items_only = variant:find("itemsonly")
local no_pins = variant:find("no_pins")

--scripts
ScriptHost:LoadScript("scripts/custom_items/class.lua")
ScriptHost:LoadScript("scripts/custom_items/custom_item_character.lua")
ScriptHost:LoadScript("scripts/custom_items/character.lua")
ScriptHost:LoadScript("scripts/custom_items/custom_item_orb.lua")
ScriptHost:LoadScript("scripts/custom_items/orb.lua")


--custom items
--character
local boy = CharacterItem("Boy", "boy")
local girl = CharacterItem("Girl", "girl")
local sprite = CharacterItem("Sprite", "sprite")
--orbs
local etOrb = OrbItem("Earth Temple Orb", "et_orb")
local mcOrb = OrbItem("Matango Cave Orb", "mc_orb")
local fpOrb1 = OrbItem("Fire Palace Orb 1", "fp_orb1")
local fpOrb2 = OrbItem("Fire Palace Orb 2", "fp_orb2")
local fpOrb3 = OrbItem("Fire Palace Orb 3", "fp_orb3")
local mpOrb = OrbItem("Moon Palace Orb", "mp_orb")


ScriptHost:LoadScript("scripts/settings.lua")
ScriptHost:LoadScript("scripts/logic.lua")
--items
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/orbs.json")
Tracker:AddItems("items/hints.json")
Tracker:AddItems("items/settings.json") 
if not items_only then
    Tracker:AddMaps("maps/maps.json")       
    Tracker:AddLocations("locations/locations.json")
    Tracker:AddLocations("locations/hints.json")
end
--layouts
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/broadcast.json")
Tracker:AddLayouts("layouts/tracker.json")


--if _VERSION == "Lua 5.3" then
--    ScriptHost:LoadScript("scripts/autotracking.lua")
--else
--    print("Auto-tracker is unsupported by your tracker version")
--end








