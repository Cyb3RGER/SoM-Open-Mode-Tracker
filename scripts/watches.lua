function updateRoleRando(code)
    if ENABLE_DEBUG_LOG then
        print("called updateRoleRando")
    end

    local _isRoleRando = isRoleRando()

    for _, obj in pairs(CHAR_OBJS) do
        obj.ItemInstance:Set("isRoleRando", _isRoleRando)
    end

    for _, obj in pairs(ORB_OBJS) do
        obj.ItemInstance:Set("isRoleRando", _isRoleRando)
    end
end

function updateFlammieDrumLogic(code)
    if ENABLE_DEBUG_LOG then
        print("called updateFlammieDrumLogic")
    end
    local logic = Tracker:ProviderCountForCode("drum_logic_random")    
    if logic > 0 then
        -- reset and...
        local obj = Tracker:FindObjectForCode("drum")
        if obj and code:find("drum_logic") ~= nil then
            obj.Active = false
        end
        -- ...try to update drum from autotracking
        if updateFlammieDrum and AutoTracker:GetConnectionState("SNES") == 3 then
            updateFlammieDrum()
        end
    else
        -- make static
        local obj = Tracker:FindObjectForCode("drum")
        if obj then
            obj.Active = true
        end
    end
end

function updateNotNeeded()
    if ENABLE_DEBUG_LOG then
        print("called updateNotNeeded")
    end
    local vals = {
        Tracker:ProviderCountForCode("undine_not_needed"),
        Tracker:ProviderCountForCode("gnome_not_needed"),
        Tracker:ProviderCountForCode("sylphid_not_needed"),
        Tracker:ProviderCountForCode("salamando_not_needed"),
        Tracker:ProviderCountForCode("shade_not_needed"),
        Tracker:ProviderCountForCode("lumina_not_needed"),
        Tracker:ProviderCountForCode("luna_not_needed"),
        Tracker:ProviderCountForCode("dryad_not_needed")
    }
    for code, obj in pairs(ORB_OBJS) do        
        if string.match(code, "gp_orb") then            
            obj.ItemInstance:Set("undine_not_needed", vals[1])
            obj.ItemInstance:Set("gnome_not_needed", vals[2])
            obj.ItemInstance:Set("sylphid_not_needed", vals[3])
            obj.ItemInstance:Set("salamando_not_needed", vals[4])
            obj.ItemInstance:Set("shade_not_needed", vals[5])
            obj.ItemInstance:Set("lumina_not_needed", vals[6])
            obj.ItemInstance:Set("luna_not_needed", vals[7])
            obj.ItemInstance:Set("dryad_not_needed", vals[8])
            -- obj.ItemInstance:Set("notNeeded",
            --    {
            --        [1] = Tracker:ProviderCountForCode("undine_not_needed"),
            --        [2] = Tracker:ProviderCountForCode("gnome_not_needed"),
            --        [3] = Tracker:ProviderCountForCode("sylphid_not_needed"),
            --        [4] = Tracker:ProviderCountForCode("salamando_not_needed"),
            --        [5] = Tracker:ProviderCountForCode("shade_not_needed"),
            --        [6] = Tracker:ProviderCountForCode("lumina_not_needed"),
            --        [7] = Tracker:ProviderCountForCode("luna_not_needed"),
            --        [8] = Tracker:ProviderCountForCode("dryad_not_needed"),
            --    }
            -- )
        end
    end
end

if PopVersion and PopVersion >= "0.11.0" then
    ScriptHost:AddWatchForCode("updateRoleRando", "roles", updateRoleRando)
    ScriptHost:AddWatchForCode("updateFlammieDrumLogic", "drum_logic", updateFlammieDrumLogic)
    ScriptHost:AddWatchForCode("updateFlammieDrum", "drum", updateFlammieDrumLogic)
    ScriptHost:AddWatchForCode("updateNotNeeded", "not_needed", updateNotNeeded)
    updateFlammieDrumLogic()
end
