--goals
function isVanillaShort()
	local value = Tracker:ProviderCountForCode("vanilla_short")
	
	if (value == 1) then
		return 1
	end

	return 0
end

function isVanillaLong()
	local value = Tracker:ProviderCountForCode("vanilla_long")

	if (value == 1) then
		return 1
	end

	return 0
end

function isReviveTheTree()
	local value = Tracker:ProviderCountForCode("revive_the_tree")

	if (value == 1) then
		return 1
	end

	return 0
end

--logic
function isBasicLogic()
	local value = Tracker:ProviderCountForCode("basic")

	if (value == 1) then
		return 1
	end

	return 0
end

function isRestrictedLogic()
	local value = Tracker:ProviderCountForCode("restricted")

	if (value == 1) then
		return 1
	end

	return 0
end

--character
function hasBoy()
	local value = Tracker:ProviderCountForCode("boy")

	if (value == 2) then
		return 1
	end

	return 0
end

function isBoyDisabled()
	local value = Tracker:ProviderCountForCode("boy")

	if (value == 0) then
		return 1
	end

	return 0
end
	
function hasGirl()
	local value = Tracker:ProviderCountForCode("girl")	

	if (value == 2) then
		return 1
	end

	return 0
end

function isGirlDisabled()	
	local value = Tracker:ProviderCountForCode("girl")

	if (value == 0) then
		return 1
	end

	return 0
end

function hasSprite()
	local value = Tracker:ProviderCountForCode("sprite")

	if (value == 2) then
		return 1
	end

	return 0
end

function isSpriteDisabled()
	local value = Tracker:ProviderCountForCode("sprite")

	if (value == 0) then
		return 1
	end

	return 0
end

--key items
function hasKey()
	local value = Tracker:ProviderCountForCode("key")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasTail()
	local value = Tracker:ProviderCountForCode("tail")

	if (value == 1) then
		return 1
	end

	return 0
end

--magic
function hasUndine()
	local value = Tracker:ProviderCountForCode("undine")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasRocky()
	local value = Tracker:ProviderCountForCode("rocky")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasSylphid()
	local value = Tracker:ProviderCountForCode("sylphid")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasSalamando()
	local value = Tracker:ProviderCountForCode("salamando")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasShade()
	local value = Tracker:ProviderCountForCode("shade")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasLumina()
	local value = Tracker:ProviderCountForCode("lumina")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasLuna()
	local value = Tracker:ProviderCountForCode("luna")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasDryad()
	local value = Tracker:ProviderCountForCode("dryad")

	if (value == 1) then
		return 1
	end

	return 0
end

--seeds
function hasWaterSeed()
	local value = Tracker:ProviderCountForCode("water_seed")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasEarthSeed()
	local value = Tracker:ProviderCountForCode("earth_seed")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasWindSeed()
	local value = Tracker:ProviderCountForCode("wind_seed")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasFireSeed()
	local value = Tracker:ProviderCountForCode("fire_seed")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasDarkSeed()
	local value = Tracker:ProviderCountForCode("dark_seed")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasLightSeed()
	local value = Tracker:ProviderCountForCode("light_seed")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasMoonSeed()
	local value = Tracker:ProviderCountForCode("moon_seed")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasTreeSeed()
	local value = Tracker:ProviderCountForCode("tree_seed")

	if (value == 1) then
		return 1
	end

	return 0
end

--weapons
function hasWhip()
	local value = Tracker:ProviderCountForCode("whip")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasAxe()
	local axe = Tracker:ProviderCountForCode("axe")
	if (axe == 1) then
		return 1
	end

	return 0
end

function canCutStuff()
	local axe = Tracker:ProviderCountForCode("axe")
	local sword = Tracker:ProviderCountForCode("sword")	

	if (axe == 1 or sword == 1) then
		return 1
	end

	return 0
end

--orbs

function updateOrbPerCharacterStates()
	local objs = {
		Tracker:FindObjectForCode("et_orb"),
		Tracker:FindObjectForCode("mc_orb"),
		Tracker:FindObjectForCode("fp_orb1"),
		Tracker:FindObjectForCode("fp_orb2"),
		Tracker:FindObjectForCode("fp_orb3"),
		Tracker:FindObjectForCode("mp_orb")
	}
	for i=1, 6 do
		local obj = objs[i]
		if isSpriteDisabled() == 1 then
			if isGirlDisabled() == 1 then
				obj.ItemState:setProperty("state",0)		
				obj.ItemState:setProperty("forceState",true)		
			else
				obj.ItemState:setProperty("state",6)	
				obj.ItemState:setProperty("forceState",true)
			end
		else		
			obj.ItemState:setProperty("forceState",false)
			if isGirlDisabled() == 1 then
				obj.ItemState:setProperty("removeLumina",true)
			else
				obj.ItemState:setProperty("removeLumina",false)
			end
		end
	end
end

--this is subject to change soon(TM)
--ToDo: account for the girl being able to destroy sylphid and salamando orbs
--      when this feature gets implemented into the randomizer
function canDestroyOrb(name)

	updateOrbPerCharacterStates()

	if isSpriteDisabled() == 1 then
		if isGirlDisabled() == 1 then
			return 1
		else
			return hasLumina() and hasGirl()
		end
	end

	if (Tracker:ProviderCountForCode(name) == 0) then
		if hasUndine() == 1 and hasRocky() == 1 and hasSylphid() == 1 and hasSalamando() == 1 
			and hasShade() == 1 and hasLumina() == 1 and hasLuna() == 1 and hasDryad() == 1
			and hasGirl() == 1 and hasSprite() == 1 then
			return 1
		else
			return 0
		end
	elseif (Tracker:ProviderCountForCode(name) == 1 and hasUndine() == 1 and hasSprite() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name) == 2 and hasRocky() == 1 and hasSprite() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name) == 3 and hasSylphid() == 1 and hasSprite() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name) == 4 and hasSalamando() == 1 and (hasSprite() == 1)) then
		return 1
	elseif (Tracker:ProviderCountForCode(name) == 5 and hasShade() == 1 and hasSprite() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name) == 6 and hasLumina() == 1 and hasGirl() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name) == 7 and hasLuna() == 1 and hasSprite() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name) == 8 and hasDryad() == 1 and hasSprite() == 1) then
		return 1
	end

	return 0
end

function canDestroyETOrb()
	if(canDestroyOrb("et_orb") == 1) then
		return 1
	end
	return 0
end	

function canDestroyMCOrb()
	if(canDestroyOrb("mc_orb") == 1) then
		return 1
	end
	return 0
end	

function canDestroyFPOrb1()
	if(canDestroyOrb("fp_orb1") == 1) then
		return 1
	end
	return 0
end	

function canDestroyFPOrb2()
	if(canDestroyOrb("fp_orb2") == 1) then
		return 1 
	end	
	return 0
end	

function canDestroyFPOrb3()
	if(canDestroyOrb("fp_orb3") == 1) then
		return 1 
	end
	return 0
end	

function canDestroyMPOrb()
	if(canDestroyOrb("mp_orb") == 1) then
		return 1
	end
	return 0
end	

--access
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
		--this is subject to change soon(TM)
		--mana fortress will become accessable in mana tree
		--ToDo: 
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
function always()
	return 1
end

function grandPalaceBoss()

	--this a bug in the rando currently
	--ToDo: remove when fixed
	if (isReviveTheTree() == 1 or isVanillaShort() == 1) then
		return 1
	end

	if (hasWhip() == 1 and hasGirl() == 1 and hasSprite() == 1 and hasUndine() == 1 and hasRocky() == 1 
		and hasSylphid() == 1 and hasSalamando() == 1 and hasShade() == 1 and hasLumina() == 1 and hasLuna() == 1) then
		return 1
	end

	return 0
end

function manaTreeRevive()
	if (hasWaterSeed() == 1 and hasEarthSeed() == 1 and hasWindSeed() == 1 and hasFireSeed() == 1 
		and hasDarkSeed() == 1 and hasLightSeed() == 1 and hasMoonSeed() == 1 and hasTreeSeed() == 1) then
		return 1
	end
	return 0
end