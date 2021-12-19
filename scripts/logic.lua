-- goals
function isVanillaShort()
    local value = Tracker:ProviderCountForCode("vanilla_short")

    if (value == 1) then return 1 end

    return 0
end

function isVanillaLong()
    local value = Tracker:ProviderCountForCode("vanilla_long")

    if (value == 1) then return 1 end

    return 0
end

function isReviveTheTree()
    local value = Tracker:ProviderCountForCode("revive_the_tree")

    if (value == 1) then return 1 end

    return 0
end

-- logic
function isBasicLogic()
    local value = Tracker:ProviderCountForCode("basic")

    if (value == 1) then return 1 end

    return 0
end

function isRestrictedLogic()
    local value = Tracker:ProviderCountForCode("restricted")

    if (value == 1) then return 1 end

    return 0
end

-- role
function isRoleRando()
    local value = Tracker:ProviderCountForCode("roles_random")

    if (value == 1) then return 1 end

    return 0
end


-- character
function hasBoy()
    local value = Tracker:ProviderCountForCode("boy")

    if (value == 2) then return 1 end

    return 0
end

function hasBoyRole()
    local value = Tracker:ProviderCountForCode("role_boy")

    if (value >= 2) then return 1 end

    return 0
end

function isBoyDisabled()
    local value = Tracker:ProviderCountForCode("boy")

    if (value == 0) then return 1 end

    return 0
end

function isBoyRoleDisabled()
    if hasBoyRole() == 0 and hasCharactersWithRoleAvaiable("boy") == 0 then return 1 end
    
    return 0
end

function hasGirl()
    local value = Tracker:ProviderCountForCode("girl")

    if (value == 2) then return 1 end

    return 0
end

function hasGirlRole()
    local value = Tracker:ProviderCountForCode("role_girl")

    if (value >= 2) then return 1 end

    return 0
end

function isGirlDisabled()
    local value = Tracker:ProviderCountForCode("girl")

    if (value == 0) then return 1 end

    return 0
end

function isGirlRoleDisabled()
    if hasGirlRole() == 0 and hasCharactersWithRoleAvaiable("girl") == 0 then return 1 end
    
    return 0
end

function hasSprite()
    local value = Tracker:ProviderCountForCode("sprite")

    if (value == 2) then return 1 end

    return 0
end

function hasSpriteRole()
    local value = Tracker:ProviderCountForCode("role_sprite")

    if (value >= 2) then return 1 end

    return 0
end

function isSpriteDisabled()
    local value = Tracker:ProviderCountForCode("sprite")

    if (value == 0) then return 1 end

    return 0
end

function isSpriteRoleDisabled()
    if hasSpriteRole() == 0 and hasCharactersWithRoleAvaiable("sprite") == 0 then return 1 end

    return 0
end

function hasCharactersWithRoleAvaiable(code)
    local obj_boy = Tracker:FindObjectForCode("boy")
    local obj_girl = Tracker:FindObjectForCode("girl")
    local obj_sprite = Tracker:FindObjectForCode("sprite")
    local map = {
        ['boy']=1,
        ['girl']=2,
        ['sprite']=3
    }
    local mapValue = map[code]

    if (obj_boy:Get("state") == 1 and (obj_boy:Get("role") == 0 or obj_boy:Get("role") == mapValue)) or
        (obj_girl:Get("state") == 1 and (obj_girl:Get("role") == 0 or obj_girl:Get("role") == mapValue)) or
        (obj_sprite:Get("state") == 1 and (obj_sprite:Get("role") == 0 or obj_sprite:Get("role") == mapValue)) then
        return 1 
    end
            
    return 0
end

-- key items
function hasKey()
    local value = Tracker:ProviderCountForCode("key")

    if (value == 1) then return 1 end

    return 0
end

function hasTail()
    local value = Tracker:ProviderCountForCode("tail")

    if (value == 1) then return 1 end

    return 0
end

-- magic
function hasUndine()
    local value = Tracker:ProviderCountForCode("undine")

    if (value == 1) then return 1 end

    return 0
end

function hasGnome()
    local value = Tracker:ProviderCountForCode("gnome")

    if (value == 1) then return 1 end

    return 0
end

function hasSylphid()
    local value = Tracker:ProviderCountForCode("sylphid")

    if (value == 1) then return 1 end

    return 0
end

function hasSalamando()
    local value = Tracker:ProviderCountForCode("salamando")

    if (value == 1) then return 1 end

    return 0
end

function hasShade()
    local value = Tracker:ProviderCountForCode("shade")

    if (value == 1) then return 1 end

    return 0
end

function hasLumina()
    local value = Tracker:ProviderCountForCode("lumina")

    if (value == 1) then return 1 end

    return 0
end

function hasLuna()
    local value = Tracker:ProviderCountForCode("luna")

    if (value == 1) then return 1 end

    return 0
end

function hasDryad()
    local value = Tracker:ProviderCountForCode("dryad")

    if (value == 1) then return 1 end

    return 0
end

-- seeds
function hasWaterSeed()
    local value = Tracker:ProviderCountForCode("water_seed")

    if (value == 1) then return 1 end

    return 0
end

function hasEarthSeed()
    local value = Tracker:ProviderCountForCode("earth_seed")

    if (value == 1) then return 1 end

    return 0
end

function hasWindSeed()
    local value = Tracker:ProviderCountForCode("wind_seed")

    if (value == 1) then return 1 end

    return 0
end

function hasFireSeed()
    local value = Tracker:ProviderCountForCode("fire_seed")

    if (value == 1) then return 1 end

    return 0
end

function hasDarkSeed()
    local value = Tracker:ProviderCountForCode("dark_seed")

    if (value == 1) then return 1 end

    return 0
end

function hasLightSeed()
    local value = Tracker:ProviderCountForCode("light_seed")

    if (value == 1) then return 1 end

    return 0
end

function hasMoonSeed()
    local value = Tracker:ProviderCountForCode("moon_seed")

    if (value == 1) then return 1 end

    return 0
end

function hasTreeSeed()
    local value = Tracker:ProviderCountForCode("tree_seed")

    if (value == 1) then return 1 end

    return 0
end

function countSeeds()
    local count = 0
    if hasWaterSeed() == 1 then count = count + 1 end
    if hasEarthSeed() == 1 then count = count + 1 end
    if hasWindSeed() == 1 then count = count + 1 end
    if hasFireSeed() == 1 then count = count + 1 end
    if hasDarkSeed() == 1 then count = count + 1 end
    if hasLightSeed() == 1 then count = count + 1 end
    if hasMoonSeed() == 1 then count = count + 1 end
    if hasTreeSeed() == 1 then count = count + 1 end
    return count
end

-- weapons
function hasWhip()
    local value = Tracker:ProviderCountForCode("whip")

    if (value == 1) then return 1 end

    return 0
end

function hasAxe()
    local axe = Tracker:ProviderCountForCode("axe")
    if (axe == 1) then return 1 end

    return 0
end

function canCutStuff()
    local axe = Tracker:ProviderCountForCode("axe")
    local sword = Tracker:ProviderCountForCode("sword")

    if (axe == 1 or sword == 1) then return 1 end

    return 0
end

-- orbs

function updateOrbCharacterStates()
    local objs = {
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

    for _,obj in ipairs(objs) do
        obj.ItemState:setProperty("isSpriteDisabled", isSpriteRoleDisabled())
        obj.ItemState:setProperty("isGirlDisabled", isGirlRoleDisabled())        
    end
end

function canDestroyOrb(name)

    updateOrbCharacterStates()

    if isSpriteRoleDisabled() == 1 and isGirlRoleDisabled() == 1 then return 1 end

    if (Tracker:ProviderCountForCode(name) == 0) then
        if isSpriteRoleDisabled() == 1 then
            if hasSylphid() == 1 and hasSalamando() == 1 and hasLumina() == 1 and hasGirlRole() == 1 then
                return 1
            else
                return 0
            end
        elseif isGirlRoleDisabled() == 1 then
            if hasUndine() == 1 and hasGnome() == 1 and hasSylphid() == 1 and hasSalamando() == 1 and 
                hasShade() == 1 and hasLuna() == 1 and hasDryad() == 1 and hasSpriteRole() == 1 then
                return 1
            else
                return 0
            end    
        elseif hasUndine() == 1 and hasGnome() == 1 and hasSylphid() == 1 and hasSalamando() == 1 and 
            hasShade() == 1 and hasLumina() == 1 and hasLuna() == 1 and hasDryad() == 1 and 
            hasGirlRole() == 1 and hasSpriteRole() == 1 then
            return 1
        else
            return 0
        end
    elseif (Tracker:ProviderCountForCode(name) == 1 and hasUndine() == 1 and hasSpriteRole() == 1) then
        return 1
    elseif (Tracker:ProviderCountForCode(name) == 2 and hasGnome() == 1 and hasSpriteRole() == 1) then
        return 1
    elseif (Tracker:ProviderCountForCode(name) == 3 and hasSylphid() == 1 and (hasSpriteRole() == 1 or hasGirlRole() == 1)) then
        return 1
    elseif (Tracker:ProviderCountForCode(name) == 4 and hasSalamando() == 1 and (hasSpriteRole() == 1 or hasGirlRole() == 1)) then
        return 1
    elseif (Tracker:ProviderCountForCode(name) == 5 and hasShade() == 1 and hasSpriteRole() == 1) then
        return 1
    elseif (Tracker:ProviderCountForCode(name) == 6 and hasLumina() == 1 and hasGirlRole() == 1) then
        return 1
    elseif (Tracker:ProviderCountForCode(name) == 7 and hasLuna() == 1 and hasSpriteRole() == 1) then
        return 1
    elseif (Tracker:ProviderCountForCode(name) == 8 and hasDryad() == 1 and hasSpriteRole() == 1) then
        return 1
    end

    return 0
end

function canDestroyETOrb()
    if (canDestroyOrb("et_orb") == 1) then return 1 end
    return 0
end

function canDestroyMCOrb()
    if (canDestroyOrb("mc_orb") == 1) then return 1 end
    return 0
end

function canDestroyFPOrb1()
    if (canDestroyOrb("fp_orb1") == 1) then return 1 end
    return 0
end

function canDestroyFPOrb2()
    if (canDestroyOrb("fp_orb2") == 1) then return 1 end
    return 0
end

function canDestroyFPOrb3()
    if (canDestroyOrb("fp_orb3") == 1) then return 1 end
    return 0
end

function canDestroyMPOrb()
    if (canDestroyOrb("mp_orb") == 1) then return 1 end
    return 0
end

function canDestroyGPOrb1()
    if (canDestroyOrb("gp_orb1") == 1) then return 1 end
    return 0
end
function canDestroyGPOrb2()
    if (canDestroyOrb("gp_orb2") == 1) then return 1 end
    return 0
end
function canDestroyGPOrb3()
    if (canDestroyOrb("gp_orb3") == 1) then return 1 end
    return 0
end
function canDestroyGPOrb4()
    if (canDestroyOrb("gp_orb4") == 1) then return 1 end
    return 0
end
function canDestroyGPOrb5()
    if (canDestroyOrb("gp_orb5") == 1) then return 1 end
    return 0
end
function canDestroyGPOrb6()
    if (canDestroyOrb("gp_orb6") == 1) then return 1 end
    return 0
end
function canDestroyGPOrb7()
    if (canDestroyOrb("gp_orb7") == 1) then return 1 end
    return 0
end

-- access
function hasWaterPalaceAccess()
    if (isBasicLogic() == 1) then
        return 1
    else
        return hasWaterSeed()
    end
    return 0
end

function hasEarthPalaceAccess()
    if (isBasicLogic() == 1) then
        return 1
    else
        return hasEarthSeed()
    end
    return 0
end

function hasWindPalaceAccess()
    if (isBasicLogic() == 1) then
        return 1
    else
        return hasWindSeed()
    end
    return 0
end

function hasFirePalaceAccess()
    if (isBasicLogic() == 1) then
        return 1
    else
        return hasFireSeed()
    end
    return 0
end

function hasDarkPalaceAccess()
    if (isBasicLogic() == 1) then
        return 1
    else
        return hasDarkSeed()
    end
    return 0
end

function hasLightPalaceAccess()
    if (isBasicLogic() == 1) then
        return 1
    else
        return hasLightSeed()
    end
    return 0
end

function hasMoonPalaceAccess()
    if (isBasicLogic() == 1) then
        return 1
    else
        return hasMoonSeed()
    end
    return 0
end

function hasTreePalaceAccess()
    if (isBasicLogic() == 1) then
        return 1
    else
        return hasTreeSeed()
    end
    return 0
end

function hasManaFortressAccess()
    if (canCutStuff() == 1 and hasWhip() == 1) then
        if (isVanillaLong() == 1) then
            return grandPalaceBoss()
            -- this is subject to change soon(TM)
            -- mana fortress will become accessable in mana tree		
        elseif (isReviveTheTree() == 1) then
            return 0
        else
            return 1
        end
    end
    return 0
end

function hasManaTreeAccess()
    if (canCutStuff() == 1) then
        if (isReviveTheTree() == 1) then
            return manaTreeRevive()
        else
            return 1
        end
    end
    return 0
end

-- utils
function always() return 1 end

function grandPalaceBoss()

    if hasWhip() == 1 and 
        canDestroyGPOrb1() == 1 and canDestroyGPOrb2() == 1 and canDestroyGPOrb3() == 1 and canDestroyGPOrb4() == 1 
        and canDestroyGPOrb5() == 1 and canDestroyGPOrb6() == 1 and canDestroyGPOrb7() == 1 then
        return 1
    end

    return 0
end

function manaTreeRevive()
    local neededSeed
    for i = 1, 8 do
        neededSeed = Tracker:ProviderCountForCode("orb_count" .. i) * i
        if neededSeed > 0 then break end
    end

    if (countSeeds() >= neededSeed) then return 1 end
    return 0
end
