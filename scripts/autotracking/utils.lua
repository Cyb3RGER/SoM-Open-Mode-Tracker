function checkFlagsInSegmentUsingTable(segment, table, checkmode)
    if not checkmode then
        checkmode = 0
    end
    local addr = table.addr
    for k, v in pairs(table.checks) do
        local readResult
        if segment then
            readResult = segment:ReadUInt8(addr + k)    
        else 
            readResult = AutoTracker:ReadU8(addr + k)
        end
        local obj = Tracker:FindObjectForCode(v)
        if obj then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating obj %s with value %x from addr %x on %x using checkmode %s", v,
                    readResult, addr + k, k, checkmode))
            end
            if checkmode == 0 then
                obj.Active = readResult > 0
            elseif checkmode == 1 then
                obj.CurrentStage = readResult
            elseif checkmode == 2 then
                if readResult > 0 then
                    obj:Set("state", 2)
                elseif obj:Get("state") == 2 then
                    obj:Set("state", 1)
                end
            elseif checkmode == 3 then
                obj:Set("active", readResult > 0)            
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Unknown checkmode %s", checkmode))
            end
        end
    end
end

-- from https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end