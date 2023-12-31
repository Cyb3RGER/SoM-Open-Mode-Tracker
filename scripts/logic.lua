-- goals
function isVanillaShort()
    local value = Tracker:ProviderCountForCode("vanilla_short") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("isVanillaShort: %s", value))
    end
    return value
end

function isVanillaLong()
    local value = Tracker:ProviderCountForCode("vanilla_long") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("isVanillaLong: %s", value))
    end
    return value
end

function isReviveTheTree()
    local value = Tracker:ProviderCountForCode("revive_the_tree") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("isReviveTheTree: %s", value))
    end
    return value
end

-- logic
function isBasicLogic()
    local value = Tracker:ProviderCountForCode("basic") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("isBasicLogic: %s", value))
    end
    return value
end

function isRestrictedLogic()
    local value = Tracker:ProviderCountForCode("restricted") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("isRestrictedLogic: %s", value))
    end
    return value
end

-- role
function isRoleRando()
    local value = Tracker:ProviderCountForCode("roles_random") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("isRoleRando: %s", value))
    end
    return value
end

-- character
function hasBoy()
    local value = Tracker:ProviderCountForCode("boy") == 2
    if ENABLE_DEBUG_LOG then
        print(string.format("hasBoy: %s", value))
    end
    return value
end

function hasBoyRole()
    if not isRoleRando() then
        return hasBoy()
    end
    local value = Tracker:ProviderCountForCode("role_boy") >= 2
    if ENABLE_DEBUG_LOG then
        print(string.format("hasBoyRole: %s", value))
    end
    return value
end

function isBoyDisabled()
    local value = Tracker:ProviderCountForCode("boy") == 0
    if ENABLE_DEBUG_LOG then
        print(string.format("isBoyDisabled: %s", value))
    end
    return value
end

function isBoyRoleDisabled()
    local value = not hasBoyRole() and not hasCharactersWithRoleAvaiable("boy")
    if ENABLE_DEBUG_LOG then
        print(string.format("isBoyRoleDisabled: %s", value))
    end
    return value
end

function hasGirl()
    local value = Tracker:ProviderCountForCode("girl") == 2
    if ENABLE_DEBUG_LOG then
        print(string.format("hasGirl: %s", value))
    end
    return value
end

function hasGirlRole()
    if not isRoleRando() then
        return hasGirl()
    end
    local value = Tracker:ProviderCountForCode("role_girl") >= 2
    if ENABLE_DEBUG_LOG then
        print(string.format("hasGirlRole: %s", value))
    end
    return value
end

function isGirlDisabled()
    local value = Tracker:ProviderCountForCode("girl") == 0
    if ENABLE_DEBUG_LOG then
        print(string.format("isGirlDisabled: %s", value))
    end
    return value
end

function isGirlRoleDisabled()
    local value = not hasGirlRole() and not hasCharactersWithRoleAvaiable("girl")
    if ENABLE_DEBUG_LOG then
        print(string.format("isGirlRoleDisabled: %s", value))
    end
    return value
end

function hasSprite()
    local value = Tracker:ProviderCountForCode("sprite") == 2
    if ENABLE_DEBUG_LOG then
        print(string.format("hasSprite: %s", value))
    end   
    return value
end

function hasSpriteRole()
    if not isRoleRando() then
        return hasSprite()
    end
    local value = Tracker:ProviderCountForCode("role_sprite") >= 2
    if ENABLE_DEBUG_LOG then
        print(string.format("hasSpriteRole: %s", value))
    end
    return value
end

function isSpriteDisabled()
    local value = Tracker:ProviderCountForCode("sprite") == 0
    if ENABLE_DEBUG_LOG then
        print(string.format("isSpriteDisabled: %s", value))
    end
    return value
end

function isSpriteRoleDisabled()
    local value = not hasSpriteRole() and not hasCharactersWithRoleAvaiable("sprite") 
    if ENABLE_DEBUG_LOG then
        print(string.format("isSpriteRoleDisabled: %s", value))
    end
    return value
end

function hasCharactersWithRoleAvaiable(code)
    local obj_boy = Tracker:FindObjectForCode("boy")
    local obj_girl = Tracker:FindObjectForCode("girl")
    local obj_sprite = Tracker:FindObjectForCode("sprite")
    local map = {
        ['boy'] = 1,
        ['girl'] = 2,
        ['sprite'] = 3
    }
    local mapValue = map[code]
    if ENABLE_DEBUG_LOG then
        print(string.format(
            "hasCharactersWithRoleAvaiable: code: %s, obj_boy.state: %s, obj_girl.state: %s, obj_sprite.state: %s",
            code, obj_boy:Get("state"), obj_girl:Get("state"), obj_sprite:Get("state")))
    end
    if not isRoleRando() then
        if code == "boy" then
            return obj_boy:Get("state") == 1
        elseif code == "girl" then
            return obj_girl:Get("state") == 1
        elseif code == "sprite" then
            return obj_sprite:Get("state") == 1
        else
            return false
        end
    end
    return (obj_boy:Get("state") >= 1 and (obj_boy:Get("role") == 0 or obj_boy:Get("role") == mapValue)) or
        (obj_girl:Get("state") >= 1 and (obj_girl:Get("role") == 0 or obj_girl:Get("role") == mapValue)) or
        (obj_sprite:Get("state") >= 1 and (obj_sprite:Get("role") == 0 or obj_sprite:Get("role") == mapValue)) 
end

-- key items
function hasKey()
    local value = Tracker:ProviderCountForCode("key") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasKey: %s", value))
    end
    return value
end

function hasTail()
    local value = Tracker:ProviderCountForCode("tail") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasTail: %s", value))
    end
    return value
end

function hasDrum()
    local value = Tracker:ProviderCountForCode("drum") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasDrum: %s", value))
    end
    return value
end

-- magic
function hasUndine()
    local value = Tracker:ProviderCountForCode("undine") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasUndine: %s", value))
    end
    return value
end

function hasGnome()
    local value = Tracker:ProviderCountForCode("gnome") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasGnome: %s", value))
    end
    return value
end

function hasSylphid()
    local value = Tracker:ProviderCountForCode("sylphid") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasSylphid: %s", value))
    end
    return value
end

function hasSalamando()
    local value = Tracker:ProviderCountForCode("salamando") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasSalamando: %s", value))
    end
    return value
end

function hasShade()
    local value = Tracker:ProviderCountForCode("shade") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasShade: %s", value))
    end
    return value
end

function hasLumina()
    local value = Tracker:ProviderCountForCode("lumina") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasLumina: %s", value))
    end
    return value
end

function hasLuna()
    local value = Tracker:ProviderCountForCode("luna") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasLuna: %s", value))
    end
    return value
end

function hasDryad()
    local value = Tracker:ProviderCountForCode("dryad") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasDryad: %s", value))
    end
    return value
end

function undineNotNeeded()
    local value = Tracker:ProviderCountForCode("undine_not_needed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("undineNotNeeded: %s", value))
    end
    return value
end

function gnomeNotNeeded()
    local value = Tracker:ProviderCountForCode("gnome_not_needed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("gnomeNotNeeded: %s", value))
    end
    return value
end


function sylphidNotNeeded()
    local value = Tracker:ProviderCountForCode("sylphid_not_needed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("sylphidNotNeeded: %s", value))
    end
    return value
end


function salamandoNotNeeded()
    local value = Tracker:ProviderCountForCode("salamando_not_needed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("undineNotNeeded: %s", value))
    end
    return value
end

function shadeNotNeeded()
    local value = Tracker:ProviderCountForCode("shade_not_needed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("shadeNotNeeded: %s", value))
    end
    return value
end


function luminaNotNeeded()
    local value = Tracker:ProviderCountForCode("lumina_not_needed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("luminaNotNeeded: %s", value))
    end
    return value
end

function lunaNotNeeded()
    local value = Tracker:ProviderCountForCode("luna_not_needed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("lunaNotNeeded: %s", value))
    end
    return value
end

function dryadNotNeeded()
    local value = Tracker:ProviderCountForCode("dryad_not_needed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("dryadNotNeeded: %s", value))
    end
    return value
end

function hasAllElements()
    if isSpriteRoleDisabled() then
        return hasSylphid() and hasSalamando() and hasLumina() and hasGirlRole()
    elseif isGirlRoleDisabled() or luminaNotNeeded() then
        return hasUndine() and hasGnome() and hasSylphid() and hasSalamando() and hasShade() and 
            hasLuna() and hasDryad() and hasSpriteRole() 
    else
        return hasUndine() and hasGnome() and hasSylphid() and hasSalamando() and hasShade() and
            hasLumina() and hasLuna() and hasDryad() and hasGirlRole() and hasSpriteRole()
    end
end

function hasAllElementsGP()
    if isSpriteRoleDisabled() then        
        return (hasSylphid() or sylphidNotNeeded()) and (hasSalamando() or salamandoNotNeeded()) and
           (hasLumina() or luminaNotNeeded()) and hasGirlRole()
    elseif isGirlRoleDisabled() or luminaNotNeeded() then
        return (hasUndine() or undineNotNeeded()) and (hasGnome() or gnomeNotNeeded()) and 
            (hasSylphid() or sylphidNotNeeded()) and (hasSalamando() or salamandoNotNeeded()) and 
            (hasShade() or shadeNotNeeded()) and (hasLuna() or lunaNotNeeded()) and (hasDryad() or dryadNotNeeded()) and 
            hasSpriteRole() 
    else
        return (hasUndine() or undineNotNeeded()) and  (hasGnome() or gnomeNotNeeded()) and 
            (hasSylphid() or sylphidNotNeeded()) and  (hasSalamando() or salamandoNotNeeded()) and 
            (hasShade() or shadeNotNeeded()) and (hasLumina() or luminaNotNeeded()) and 
            (hasLuna() or lunaNotNeeded()) and (hasDryad() or dryadNotNeeded()) and hasGirlRole() and hasSpriteRole()
    end
end

-- seeds
function hasWaterSeed()
    local value = Tracker:ProviderCountForCode("water_seed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasWaterSeed: %s", value))
    end
    return value
end

function hasEarthSeed()
    local value = Tracker:ProviderCountForCode("earth_seed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasEarthSeed: %s", value))
    end
    return value
end

function hasWindSeed()
    local value = Tracker:ProviderCountForCode("wind_seed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasWindSeed: %s", value))
    end
    return value
end

function hasFireSeed()
    local value = Tracker:ProviderCountForCode("fire_seed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasFireSeed: %s", value))
    end
    return value
end

function hasDarkSeed()
    local value = Tracker:ProviderCountForCode("dark_seed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasDarkSeed: %s", value))
    end
    return value
end

function hasLightSeed()
    local value = Tracker:ProviderCountForCode("light_seed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasLightSeed: %s", value))
    end
    return value
end

function hasMoonSeed()
    local value = Tracker:ProviderCountForCode("moon_seed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasMoonSeed: %s", value))
    end
    return value
end

function hasTreeSeed()
    local value = Tracker:ProviderCountForCode("tree_seed") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasTreeSeed: %s", value))
    end
    return value
end

function countSeeds()
    local count = 0
    if hasWaterSeed() then
        count = count + 1
    end
    if hasEarthSeed() then
        count = count + 1
    end
    if hasWindSeed() then
        count = count + 1
    end
    if hasFireSeed() then
        count = count + 1
    end
    if hasDarkSeed() then
        count = count + 1
    end
    if hasLightSeed() then
        count = count + 1
    end
    if hasMoonSeed() then
        count = count + 1
    end
    if hasTreeSeed() then
        count = count + 1
    end
    return count
end

-- weapons
function hasWhip()
    local value = Tracker:ProviderCountForCode("whip") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasWhip: %s", value))
    end
    return value
end

function hasAxe()
    local value = Tracker:ProviderCountForCode("axe") == 1
    if ENABLE_DEBUG_LOG then
        print(string.format("hasWhip: %s", value))
    end
    return value
end

function canCutStuff()
    local value = hasAxe() or (Tracker:ProviderCountForCode("sword") == 1)
    if ENABLE_DEBUG_LOG then
        print(string.format("canCutStuff: %s", value))
    end
    return value
end

-- orbs

function updateOrbStates()
    local _isSpriteRoleDisabled = isSpriteRoleDisabled()
    local _isGirlRoleDisabled = isGirlRoleDisabled()
    local _hasSpriteRole = hasSpriteRole()
    local _hasGirlRole = hasGirlRole()
    local _hasAllElements = hasAllElements()
    local _hasAllElementsGP = hasAllElementsGP()
    if ENABLE_DEBUG_LOG then
        print(string.format(
            "updateOrbStates: isSpriteDisabled: %s, isGirlDisabled: %s, hasSpriteRole: %s, hasGirlRole: %s, hasAllElements: %s, hasAllElementsGP: %s",
            _isSpriteRoleDisabled, _isGirlRoleDisabled, _hasSpriteRole, _hasGirlRole, _hasAllElements, _hasAllElementsGP))
    end
    for code, obj in pairs(ORB_OBJS) do
        local tmp = _hasAllElements
        if code:match("gp_") then
            tmp = _hasAllElementsGP
        end
        obj.ItemInstance:Set("isSpriteDisabled", _isSpriteRoleDisabled)
        obj.ItemInstance:Set("isGirlDisabled", _isGirlRoleDisabled)
        obj.ItemInstance:Set("hasSpriteRole", _hasSpriteRole)
        obj.ItemInstance:Set("hasGirlRole", _hasGirlRole)
        obj.ItemInstance:Set("hasAllElements", tmp)       
    end
end

function canDestroyOrb(name)

    updateOrbStates()

    local obj = Tracker:FindObjectForCode(name)

    if isSpriteRoleDisabled() and isGirlRoleDisabled() then
        return true
    end

    local _hasSpriteRole = hasSpriteRole()
    local _hasGirlRole = hasGirlRole()

    if obj:Get("state") == 0 then
        if name:match("gp_") then
           return hasAllElementsGP() 
        else
            return hasAllElements()    
        end        
    elseif obj:Get("state") == 1 then
        return hasUndine() and _hasSpriteRole
    elseif obj:Get("state") == 2 then
        return hasGnome() and _hasSpriteRole
    elseif obj:Get("state") == 3 then
        return hasSylphid() and (_hasSpriteRole or _hasGirlRole)
    elseif obj:Get("state") == 4 then
        return hasSalamando() and (_hasSpriteRole or _hasGirlRole)
    elseif obj:Get("state") == 5 then
        return hasShade() and _hasSpriteRole
    elseif obj:Get("state") == 6 then
        return hasLumina() and _hasGirlRole
    elseif obj:Get("state") == 7 then
        return hasLuna() and _hasSpriteRole
    elseif obj:Get("state") == 8 then
        return hasDryad() and _hasSpriteRole
    end

    return false
end

function canCrossUpperLandForest()
   return hasDrum() or canDestroyUFOrb()
end

function canDestroyETOrb()
    return canDestroyOrb("et_orb")
end

function canDestroyUFOrb()
    return canDestroyOrb("uf_orb")
end

function canDestroyMCOrb()
    return canDestroyOrb("mc_orb")
end

function canDestroyFPOrb1()
    return canDestroyOrb("fp_orb1")
end

function canDestroyFPOrb2()
    return canDestroyOrb("fp_orb2")
end

function canDestroyFPOrb3()
    return canDestroyOrb("fp_orb3")
end

function canDestroyMPOrb()
    print("canDestroyMPOrb", canDestroyOrb("mp_orb"))
    return canDestroyOrb("mp_orb")
end

function canDestroyGPOrb1()
    return canDestroyOrb("gp_orb1")
end
function canDestroyGPOrb2()
    return canDestroyOrb("gp_orb2")
end
function canDestroyGPOrb3()
    return canDestroyOrb("gp_orb3")
end
function canDestroyGPOrb4()
    return canDestroyOrb("gp_orb4")
end
function canDestroyGPOrb5()
    return canDestroyOrb("gp_orb5")
end
function canDestroyGPOrb6()
    return canDestroyOrb("gp_orb6")
end
function canDestroyGPOrb7()
    return canDestroyOrb("gp_orb7")
end

-- access
function hasWaterPalaceAccess()
    return isBasicLogic() or hasWaterSeed()
end

function hasEarthPalaceAccess()
    return isBasicLogic() or hasEarthSeed()
end

function hasWindPalaceAccess()
    return isBasicLogic() or hasWindSeed()
end

function hasFirePalaceAccess()
    return isBasicLogic() or hasFireSeed()
end

function hasDarkPalaceAccess()
    return isBasicLogic() or hasDarkSeed()
end

function hasLightPalaceAccess()
    return isBasicLogic() or hasLightSeed()
end

function hasMoonPalaceAccess()
    return isBasicLogic() or hasMoonSeed()
end

function hasTreePalaceAccess()
    return isBasicLogic() or hasTreeSeed()
end

function hasManaFortressAccess()    
    return not isReviveTheTree() and canCutStuff() and hasWhip() and (isVanillaShort() or grandPalaceBoss())
end

function hasManaTreeAccess()
    return canCutStuff() and (not isReviveTheTree() or manaTreeRevive())    
end

-- utils
function always()
    return true
end

function grandPalaceBoss()
    return hasWhip() and canDestroyGPOrb1() and canDestroyGPOrb2()  and canDestroyGPOrb3() and
        canDestroyGPOrb4() and canDestroyGPOrb5() and canDestroyGPOrb6() and canDestroyGPOrb7()
end

function manaTreeRevive()
    local neededSeed
    for i = 1, 8 do
        neededSeed = Tracker:ProviderCountForCode("orb_count" .. i) * i
        if neededSeed > 0 then
            break
        end
    end
    return countSeeds() >= neededSeed
end


