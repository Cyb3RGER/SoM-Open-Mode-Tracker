function checkFlagsInSegmentUsingTable(segment, table)
    checkFlagsInSegmentUsingTable(segment,table,0)
end

function checkFlagsInSegmentUsingTable(segment, table, checkmode)
    local addr = table.addr
    for k,v in pairs(table.checks) do
        local readResult = segment:ReadUInt8(addr+k)
        local obj = Tracker:FindObjectForCode(v)
        if obj then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating obj %s with value %x from addr %x on %x using checkmode %s", v, readResult, addr+k, k, checkmode))
            end
            if not checkmode or checkmode == 0 then
                obj.Active = readResult > 0
            elseif checkmode == 1 then
                obj.CurrentStage = readResult
            elseif checkmode == 2 then
                if readResult > 0 then
                    obj:Set("state", 2)
                elseif obj:Get("state") then
                    obj:Set("state", 1)
                end
            end
        end
    end
end