-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true or ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true and not IS_ITEMS_ONLY
-------------------------------------------------------

-- Globals --------------------------------------------
IS_GAME_RUNNING = true
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    ITEMS_BASE_ADDR = 0x7ECF00
    ScriptHost:LoadScript("scripts/autotracking/items/chars.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/keyitems.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/magic.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/weapons.lua")
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    ScriptHost:LoadScript("scripts/autotracking/locations.lua")
end
-------------------------------------------------------

print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Enable Debug Logging:        ", "true")
end
print("---------------------------------------------------------------------")
print("")

-- Functions ------------------------------------------
ScriptHost:LoadScript("scripts/autotracking/utils.lua")
ScriptHost:LoadScript("scripts/autotracking/callbacks.lua")
-------------------------------------------------------

-- Memory Watches -------------------------------------
--ScriptHost:AddMemoryWatch("CheckGameState",  , , updateGameState) -- ToDo
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("Adding item tracker watches")
    end
    ScriptHost:AddMemoryWatch("Characters", CHARS.addr , #CHARS.checks+1, updateChars)
    ScriptHost:AddMemoryWatch("SeaHearTail", SEA_HARE_TAIL.addr , #SEA_HARE_TAIL.checks+1, updateSeaHearTail)
    ScriptHost:AddMemoryWatch("GoldKey", GOLD_KEY.addr , #GOLD_KEY.checks+1, updateGoldKey)
    ScriptHost:AddMemoryWatch("MidgeMallet", MIDGE_MALLET.addr , #MIDGE_MALLET.checks+1, updateMidgeMallet)
    ScriptHost:AddMemoryWatch("MoogleBelt", MOOGLE_BELT.addr , #MOOGLE_BELT.checks+1, updateMoogleBelt)
    ScriptHost:AddMemoryWatch("FlammieDrum", FLAMMIE_DRUM.addr , #FLAMMIE_DRUM.checks+1, updateFlammieDrum)
    ScriptHost:AddMemoryWatch("Seeds", SEEDS.addr , #SEEDS.checks+1, updateSeeds)
    ScriptHost:AddMemoryWatch("Magic", MAGIC.addr , #MAGIC.checks+1, updateMagic)
    ScriptHost:AddMemoryWatch("WeaponOrbs", WEAPONS_ORBS.addr , #WEAPONS_ORBS.checks+1, updateWeaponOrbs)
    ScriptHost:AddMemoryWatch("Weapons", WEAPONS.addr , #WEAPONS.checks+1, updateWeapons)
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("Adding location tracker watches")
    end
    ScriptHost:AddMemoryWatch("EventPointerTableAddr",EVENT_POINTER_TABLE_ADDR_ADDR,0x3,updateEventPointerTableAddr)
    ScriptHost:AddMemoryWatch("EventFlags",EVENT_FLAGS_ADDR,0xFF,updateEventFlags)
    ScriptHost:AddMemoryWatch("CurrentEventPointer",CURRENT_EVENT_POINTER_ADDR,0x3,updateCurrentEventPointer)
    --ScriptHost:AddMemoryWatch("VanillaEventDataBank9",0x90000,0xF2D6,updateEventData)
    --ScriptHost:AddMemoryWatch("VanillaEventDataBankA",0xA0000,0xB574,updateEventData)
    --ScriptHost:AddMemoryWatch("CustomEventData",0x240000,0x1ffff,updateEventData)
end
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Autotracking finished initializing!")
end
