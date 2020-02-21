local variant = Tracker.ActiveVariantUID
local items_only = variant:find("itemsonly")

--scripts
ScriptHost:LoadScript("scripts/logic.lua")
--items
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/orbs.json")
--layouts
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/broadcast.json")
Tracker:AddLayouts("layouts/tracker.json")

if not items_only then
    Tracker:AddMaps("maps/maps.json")
    Tracker:AddItems("items/settings.json")    
    Tracker:AddLocations("locations/locations.json")
end





