--settings
function isLongMode()
	local value = Tracker:ProviderCountForCode("mode")

	if (value == 1) then
		return 1
	end

	return 0
end

function isShortMode()
	if isLongMode() == 1 then
		return 0
	else 
		return 1
	end
end
--character
function hasGirl()
	local value = Tracker:ProviderCountForCode("girl")

	if (value == 1) then
		return 1
	end

	return 0
end

function hasSprite()
	local value = Tracker:ProviderCountForCode("sprite")

	if (value == 1) then
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
function canDestroyOrb(name)		

	if (Tracker:ProviderCountForCode(name .. "_unknown") == 1) then
		return 0
	elseif (Tracker:ProviderCountForCode(name .. "_undine") == 1 and hasUndine() == 1 and hasSprite() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name .. "_rocky") == 1 and hasRocky() == 1 and hasSprite() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name .. "_sylphid") == 1 and hasSylphid() == 1 and hasSprite() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name .. "_salamando") == 1 and hasSalamando() == 1 and (hasSprite() == 1)) then
		return 1
	elseif (Tracker:ProviderCountForCode(name .. "_shade") == 1 and hasShade() == 1 and hasSprite() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name .. "_lumina") == 1 and hasLumina() == 1 and hasGirl() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name .. "_luna") == 1 and hasLuna() == 1 and hasSprite() == 1) then
		return 1
	elseif (Tracker:ProviderCountForCode(name .. "_dryad") == 1 and hasDryad() == 1 and hasSprite() == 1) then
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
	if(canDestroyOrb("fp_orb2") == 1 and canDestroyFPOrb1() == 1) then
		return 1 
	end	
	return 0
end	

function canDestroyFPOrb3()		
	if(canDestroyOrb("fp_orb3") == 1 and canDestroyFPOrb1() == 1 and canDestroyFPOrb2() == 1) then
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

-- utils
function always()
	return 1
end

function grandPalaceBoss()

	if (hasWhip() == 1 and hasGirl() == 1 and hasSprite() == 1 and hasUndine() == 1 and hasRocky() == 1 
		and hasSylphid() == 1 and hasSalamando() == 1 and hasShade() == 1 and hasLumina() == 1 and hasLuna() == 1) then
		return 1
	end

	return 0
end
