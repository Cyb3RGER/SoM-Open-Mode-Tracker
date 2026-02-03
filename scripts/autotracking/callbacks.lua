-- for downward compatibility we have to adjust for diffrently mapped rom addresses
-- since v0.18.2 PopTracker uses the "correct" mapping and we dont need an offset anymore
ROM_ADRESS_OFFSET = 0xc00000
if PopVersion and PopVersion >= '0.18.2' then
    ROM_ADRESS_OFFSET = 0
end

function updateGameState(segment)
    local current_map = AutoTracker:ReadU16(CURRENT_MAP_ADDR)
    --check if first byte of nmi vector is not 0x40 (RTI)
    local nmi_first_byte = AutoTracker:ReadU8(NMI_VECTOR_ADDR)
    local char_flag1 = AutoTracker:ReadU8(CHARS.addr)
    local char_flag2 = AutoTracker:ReadU8(CHARS.addr + 1)
    local char_flag3 = AutoTracker:ReadU8(CHARS.addr + 2)
    local has_char_setup = (char_flag1 == 0 or char_flag1 == 1) and (char_flag2 == 0 or char_flag2 == 1) and (char_flag3 == 0 or char_flag3 == 1) and char_flag1 + char_flag2 + char_flag3 > 0
    local in_title =  nmi_first_byte == 0x40
    -- game is running when not_in_title and current map is not uninitalized or 0
    IS_GAME_RUNNING = not in_title and current_map ~= 0x5555 and current_map ~= 0x0000 and has_char_setup
    IS_AP = AutoTracker:ReadU16(AP_SEED_ADDR) > 0
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print('updateGameState', IS_GAME_RUNNING, nmi_first_byte, in_title, current_map, has_char_setup, IS_AP)
    end
    if (IS_GAME_RUNNING and not ENABLED_WATCHES) then
        enableWatches()
    elseif (not IS_GAME_RUNNING and ENABLED_WATCHES) then
        disableWatches()
    end
end

function updateChars(segment)
    if not IS_GAME_RUNNING then
        return
    end
    checkFlagsInSegmentUsingTable(segment, CHARS, 2)
end

function updateSeaHearTail(segment)
    if not IS_GAME_RUNNING then
        return
    end
    checkFlagsInSegmentUsingTable(segment, SEA_HARE_TAIL)
end

function updateGoldKey(segment)
    if not IS_GAME_RUNNING then
        return
    end
    checkFlagsInSegmentUsingTable(segment, GOLD_KEY)
end

function updateMidgeMallet(segment)
    if not IS_GAME_RUNNING then
        return
    end
    checkFlagsInSegmentUsingTable(segment, MIDGE_MALLET)
end

function updateMoogleBelt(segment)
    if not IS_GAME_RUNNING then
        return
    end
    checkFlagsInSegmentUsingTable(segment, MOOGLE_BELT)
end

function updateFlammieDrum(segment)
    if not IS_GAME_RUNNING then
        return
    end
    checkFlagsInSegmentUsingTable(segment, FLAMMIE_DRUM)
end

function updateSeeds(segment)
    if not IS_GAME_RUNNING then
        return
    end
    checkFlagsInSegmentUsingTable(segment, SEEDS)
end

function updateMagic(segment)
    if not IS_GAME_RUNNING then
        return
    end
    checkFlagsInSegmentUsingTable(segment, MAGIC, 3)
end

function updateWeaponOrbs(segment)
    if not IS_GAME_RUNNING then
        return
    end
    checkFlagsInSegmentUsingTable(segment, WEAPONS_ORBS, 1)
end

function updateWeapons(segment)
    if not IS_GAME_RUNNING then
        return
    end
    checkFlagsInSegmentUsingTable(segment, WEAPONS)
end

function updateEventFlags(segment)
    if not IS_GAME_RUNNING then
        return
    end
    if not EVENT_FLAG_MAPPING then
        return
    end
    local vals = {}
    for k, v in pairs(EVENT_FLAG_MAPPING) do
        local addr = EVENT_FLAGS_ADDR + v
        local readResult = AutoTracker:ReadU8(addr)
        local code = EVENT_MAPPING[k][1]
        local target_val = 1
        if EVENT_MAPPING[k][3] then
            target_val = EVENT_MAPPING[k][3]
        end
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("Updating location %s with val %x from addr %x", code, readResult, addr))
        end
        if EVENT_MAPPING[k][2] then
            local obj = Tracker:FindObjectForCode(code)
            if obj then
                if readResult >= target_val then
                    obj.AvailableChestCount = 0
                else
                    obj.AvailableChestCount = obj.ChestCount
                end
            end
        else
            if not vals[code] then
                vals[code] = 0
            end
            if readResult >= target_val then
                vals[code] = vals[code] + 1
            end
        end
    end
    for code, count in pairs(vals) do
        local obj = Tracker:FindObjectForCode(code)
        if obj then
            obj.AvailableChestCount = obj.ChestCount - count
        end
    end
end

function getEventPointer(eventNr)
    local addr = EVENT_POINTER_TABLE_ADDR + eventNr * 3
    local readResult = AutoTracker:ReadU24(addr) - ROM_ADRESS_OFFSET
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_EVENTS then
        print(string.format("Got Pointer for Event %x from addr %x: %x (%x)", eventNr, addr, readResult,
            readResult + ROM_ADRESS_OFFSET))
    end
    return readResult
end

function updateEvent(eventNr)
    local prt = getEventPointer(eventNr)
    local addr = prt
    local startOfEvent = addr
    local endOfEvent = addr
    local readResult = AutoTracker:ReadU8(addr)
    local flag = nil
    while readResult ~= 0x00 do
        if readResult == 0x29 or readResult == 0x2A or readResult == 0x30 then
            local readResult2 = AutoTracker:ReadU8(addr + 1)
            for i = 1, #EVENT_FLAGS + 1 do
                if readResult2 == EVENT_FLAGS[i] then
                    flag = readResult2
                end
            end
        end
        if flag then
            break
        end
        if EVENT_CMDS[readResult] then
            addr = addr + EVENT_CMDS[readResult]
        end
        addr = addr + 1
        readResult = AutoTracker:ReadU8(addr)
        endOfEvent = addr
    end
    EVENT_FLAG_MAPPING[eventNr] = flag
    if not flag then
        NOTHING_EVENTS[eventNr] = {startOfEvent, endOfEvent}
    end
end

function updateEventPointerTableAddr(segment)
    if not IS_GAME_RUNNING then
        return
    end
    local tableAddr = AutoTracker:ReadU24(EVENT_POINTER_TABLE_ADDR_ADDR) - ROM_ADRESS_OFFSET
    if tableAddr > 0 then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("Event pointer table at %x", tableAddr))
        end
        EVENT_POINTER_TABLE_ADDR = tableAddr
        if not ADDED_EVENT_POINTER_TABLE_MEMORY_WATCH then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Adding event pointer table watch now"))
            end
            ScriptHost:AddMemoryWatch("EventPointerTable", tableAddr, 0x3 * 0xA00, updateEventPointerTable)
            ADDED_EVENT_POINTER_TABLE_MEMORY_WATCH = true
        end
    else
        EVENT_POINTER_TABLE_ADDR = nil
        ADDED_EVENT_POINTER_TABLE_MEMORY_WATCH = false
    end
end

function canPullAllPointers()
    if not EVENT_POINTER_TABLE_ADDR then
        return false
    end
    for k, _ in pairs(EVENT_MAPPING) do
        local addr = getEventPointer(k)
        if addr <= ROM_ADRESS_OFFSET then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("can not pull all pointers yet"))
            end
            return false
        end
    end
    return true
end

function updateEventPointerTable()
    if not IS_GAME_RUNNING then
        return
    end
    if not EVENT_POINTER_TABLE_ADDR then
        ADDED_EVENT_DATA_MEMORY_WATCHES = false
        return
    end
    if not ADDED_EVENT_DATA_MEMORY_WATCHES then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("Adding event data watch now"))
        end
        if not canPullAllPointers() then
            return
        end
        for k, _ in pairs(EVENT_MAPPING) do
            local addr = getEventPointer(k)
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_EVENTS then
                print(string.format("Adding Event Data Watches for eventNr %x at addr %x with size %x", k, addr,
                    EVENT_DATA_WATCH_SIZE))
            end
            ScriptHost:AddMemoryWatch("EventData" .. k, addr, EVENT_DATA_WATCH_SIZE, updateEventData)
        end
        --updateEventData()
        ADDED_EVENT_DATA_MEMORY_WATCHES = true
    end
end

function updateEventData(segment)
    updateEvents()
end

function updateEvents()
    if not IS_GAME_RUNNING then
        return
    end
    if not canPullAllPointers() then
        return
    end
    EVENT_FLAG_MAPPING = {}
    NOTHING_EVENTS = {}
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("============ updateEvents ==========================="))
    end
    for k, _ in pairs(EVENT_MAPPING) do
        updateEvent(k)
    end
    for k, v in pairs(EVENT_FLAG_MAPPING) do
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_EVENTS then
            print(string.format("Event %x has flag %x", k, v))
        end
    end
    for k, v in pairs(NOTHING_EVENTS) do
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_EVENTS then
            print(string.format("Event %x @ %x to %x has no flag", k, v[1], v[2]))
        end
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_EVENTS then
        print(string.format("====================================================="))
    end
    updateEventFlags()
end

function updateCurrentEventPointer()
    if not IS_GAME_RUNNING then
        return
    end
    if not NOTHING_EVENTS then
        return
    end
    local readResult = AutoTracker:ReadU24(CURRENT_EVENT_POINTER_ADDR) - ROM_ADRESS_OFFSET
    if readResult > 0 then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_EVENTS then
            print(string.format("Currently running event at %x", readResult))
        end
        for k, v in pairs(NOTHING_EVENTS) do
            if readResult >= v[1] and readResult <= v[2] then
                if AUTOTRACKER_ENABLE_DEBUG_LOGGING_EVENTS then
                    print(string.format("Currently running location event %x", k))
                end
                local code = EVENT_MAPPING[k][1]
                local obj = Tracker:FindObjectForCode(code)
                if obj then
                    if EVENT_MAPPING[k][2] then
                        obj.AvailableChestCount = 0
                    elseif not EVENT_MAPPING[k][4] and obj.AvailableChestCount > 0 then
                        EVENT_MAPPING[k][4] = true
                        obj.AvailableChestCount = obj.AvailableChestCount - 1
                    end
                end
            end
        end
    end
end

function updateEventFlagsAP(segment)
    if not IS_GAME_RUNNING or not IS_AP then
        return
    end
    local vals = {}
    for addr, values in pairs(EVENT_MAPPING_AP) do
        local readResult = AutoTracker:ReadU8(EVENT_FLAGS_ADDR, addr)
        for target_val, loc_info in pairs(values) do
            local code = loc_info[1]
            if readResult >= target_val then
                if loc_info[2] then
                    vals[code] = -1
                else
                    if vals[code] then
                        vals[code] = vals[code] + 1
                    else
                        vals[code] = 1;
                    end
                end
            elseif not vals[code] then
                vals[code] = 0;
            end
        end
    end
    for code, count in pairs(vals) do
        local o = Tracker:FindObjectForCode(code)
        if o then
            if count == -1 then
                o.AvailableChestCount = 0
            else
                o.AvailableChestCount = o.ChestCount - count
            end
        end
    end
end
