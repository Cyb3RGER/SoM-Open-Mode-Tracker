-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = false or ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true and not IS_ITEMS_ONLY
AUTOTRACKER_ENABLE_DEBUG_LOGGING_EVENTS = false and AUTOTRACKER_ENABLE_DEBUG_LOGGING
-------------------------------------------------------

-- Globals --------------------------------------------
IS_GAME_RUNNING = false
IS_AP = false
AP_SEED_ADDR = 0xfd0040
ENABLED_WATCHES = false
CURRENT_MAP_ADDR = 0x7e00dc
NMI_VECTOR_ADDR = 0x7e0100
ITEMS_BASE_ADDR = 0x7ECF00
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    ScriptHost:LoadScript("scripts/autotracking/items/chars.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/keyitems.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/magic.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/weapons.lua")
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    ScriptHost:LoadScript("scripts/autotracking/locations.lua")
    ScriptHost:LoadScript("scripts/autotracking/locations_ap.lua")
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
ScriptHost:AddMemoryWatch("CheckGameState1", CURRENT_MAP_ADDR, 0x2 , updateGameState)
ScriptHost:AddMemoryWatch("CheckGameState2", NMI_VECTOR_ADDR, 0x1, updateGameState)
ScriptHost:AddMemoryWatch("CheckGameState3", CHARS.addr, 0x3 , updateGameState)
ScriptHost:AddMemoryWatch("CheckGameState4", AP_SEED_ADDR, 0x2 , updateGameState)

function enableWatches()
    if ENABLED_WATCHES then
        return
    end
    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print("Adding item tracker watches")
        end
        ScriptHost:AddMemoryWatch("Characters", CHARS.addr, #CHARS.checks + 1, updateChars)
        ScriptHost:AddMemoryWatch("SeaHearTail", SEA_HARE_TAIL.addr, #SEA_HARE_TAIL.checks + 1, updateSeaHearTail)
        ScriptHost:AddMemoryWatch("GoldKey", GOLD_KEY.addr, #GOLD_KEY.checks + 1, updateGoldKey)
        ScriptHost:AddMemoryWatch("MidgeMallet", MIDGE_MALLET.addr, #MIDGE_MALLET.checks + 1, updateMidgeMallet)
        ScriptHost:AddMemoryWatch("MoogleBelt", MOOGLE_BELT.addr, #MOOGLE_BELT.checks + 1, updateMoogleBelt)
        ScriptHost:AddMemoryWatch("FlammieDrum", FLAMMIE_DRUM.addr, #FLAMMIE_DRUM.checks + 1, updateFlammieDrum)
        ScriptHost:AddMemoryWatch("Seeds", SEEDS.addr, #SEEDS.checks + 1, updateSeeds)
        ScriptHost:AddMemoryWatch("Magic", MAGIC.addr, #MAGIC.checks + 1, updateMagic)
        ScriptHost:AddMemoryWatch("WeaponOrbs", WEAPONS_ORBS.addr, #WEAPONS_ORBS.checks + 1, updateWeaponOrbs)
        ScriptHost:AddMemoryWatch("Weapons", WEAPONS.addr, #WEAPONS.checks + 1, updateWeapons)
    end
    if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print("Adding location tracker watches", "IS_AP: "..tostring(IS_AP))
        end
        if IS_AP then
            for k, _ in pairs(EVENT_MAPPING_AP) do
                ScriptHost:AddMemoryWatch("EventFlagsAP" .. k, EVENT_FLAGS_ADDR+k, 0x1, updateEventFlagsAP)
            end
        else
            ScriptHost:AddMemoryWatch("EventPointerTableAddr", EVENT_POINTER_TABLE_ADDR_ADDR, 0x3, updateEventPointerTableAddr)
            ScriptHost:AddMemoryWatch("EventFlags", EVENT_FLAGS_ADDR, 0xFF, updateEventFlags)
            ScriptHost:AddMemoryWatch("CurrentEventPointer", CURRENT_EVENT_POINTER_ADDR, 0x3, updateCurrentEventPointer)
            -- ScriptHost:AddMemoryWatch("VanillaEventDataBank9",0x90000,0xF2D6,updateEventData)
            -- ScriptHost:AddMemoryWatch("VanillaEventDataBankA",0xA0000,0xB574,updateEventData)
            -- ScriptHost:AddMemoryWatch("CustomEventData",0x240000,0x1ffff,updateEventData)
        end
    end
    ENABLED_WATCHES = true
end

function disableWatches()
    if not ENABLED_WATCHES then
        return
    end
    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print("Removing item tracker watches")
        end
        ScriptHost:RemoveMemoryWatch("Characters")
        ScriptHost:RemoveMemoryWatch("SeaHearTail")
        ScriptHost:RemoveMemoryWatch("GoldKey")
        ScriptHost:RemoveMemoryWatch("MidgeMallet")
        ScriptHost:RemoveMemoryWatch("MoogleBelt")
        ScriptHost:RemoveMemoryWatch("FlammieDrum")
        ScriptHost:RemoveMemoryWatch("Seeds")
        ScriptHost:RemoveMemoryWatch("Magic")
        ScriptHost:RemoveMemoryWatch("WeaponOrbs")
        ScriptHost:RemoveMemoryWatch("Weapons")
    end
    if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print("Removing location tracker watches")
        end
        ScriptHost:RemoveMemoryWatch("EventPointerTableAddr")
        ScriptHost:RemoveMemoryWatch("EventFlags")
        ScriptHost:RemoveMemoryWatch("CurrentEventPointer")
        ScriptHost:RemoveMemoryWatch("EventPointerTable")
        ADDED_EVENT_POINTER_TABLE_MEMORY_WATCH = false
        for k, _ in pairs(EVENT_MAPPING) do
            ScriptHost:RemoveMemoryWatch("EventData" .. k)
        end
        ADDED_EVENT_DATA_MEMORY_WATCHES = false
        for k, _ in pairs(EVENT_MAPPING_AP) do
            ScriptHost:RemoveMemoryWatch("EventFlagsAP" .. k)
        end
    end
    ENABLED_WATCHES = false
end

if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Autotracking finished initializing!")
end

-- function autotracker_started()
--    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
--        print("called autotracker_started!")
--    end
--    resetLocations()
-- end

function resetLocations()
    for k, v in pairs(EVENT_MAPPING) do
        if v and v[1] then
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                obj.AvailableChestCount = obj.ChestCount
            end
        end
    end
end
