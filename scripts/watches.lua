function updateRoleRando(code)
    print("called updateRoleRando")
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

if PopVersion and PopVersion >= "0.11.0" then
    ScriptHost:AddWatchForCode("updateRoleRando","roles",updateRoleRando)
end