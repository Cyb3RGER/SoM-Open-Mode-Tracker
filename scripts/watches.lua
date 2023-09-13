function updateRoleRando(code)
    if ENABLE_DEBUG_LOG then
        print("called updateRoleRando")
    end
    local objs_chars = {
        Tracker:FindObjectForCode("boy"),
        Tracker:FindObjectForCode("girl"),
        Tracker:FindObjectForCode("sprite")
    }

    for _,obj in ipairs(objs_chars) do
        obj.ItemState:setProperty("isRoleRando", isRoleRando() > 0)       
    end

    local objs_orbs = {
        Tracker:FindObjectForCode("et_orb"),
        Tracker:FindObjectForCode("uf_orb"),
        Tracker:FindObjectForCode("mc_orb"),
        Tracker:FindObjectForCode("fp_orb1"),
        Tracker:FindObjectForCode("fp_orb2"),
        Tracker:FindObjectForCode("fp_orb3"),
        Tracker:FindObjectForCode("mp_orb"),
        Tracker:FindObjectForCode("gp_orb1"),
        Tracker:FindObjectForCode("gp_orb2"),
        Tracker:FindObjectForCode("gp_orb3"),
        Tracker:FindObjectForCode("gp_orb4"),
        Tracker:FindObjectForCode("gp_orb5"),
        Tracker:FindObjectForCode("gp_orb6"),
        Tracker:FindObjectForCode("gp_orb7"),
    }

    for _,obj in ipairs(objs_orbs) do
        obj.ItemState:setProperty("isRoleRando", isRoleRando())
    end
end

function updateFlammieDrumLogic(code)    
    if ENABLE_DEBUG_LOG then
        print("called updateFlammieDrumLogic")
    end
    local logic = Tracker:ProviderCountForCode("drum_logic_random")    
    print("called updateFlammieDrumLogic:", logic, code)
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

if PopVersion and PopVersion >= "0.11.0" then
    ScriptHost:AddWatchForCode("updateRoleRando","roles",updateRoleRando)
    ScriptHost:AddWatchForCode("updateFlammieDrumLogic","drum_logic",updateFlammieDrumLogic)
    ScriptHost:AddWatchForCode("updateFlammieDrum","drum",updateFlammieDrumLogic)
    updateFlammieDrumLogic()
end