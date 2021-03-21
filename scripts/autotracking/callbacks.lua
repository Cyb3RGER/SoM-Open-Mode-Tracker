function updateGameState()
    --ToDo
    IS_GAME_RUNNING = true
end

function updateChars(segment)
    if not IS_GAME_RUNNING then return end
    checkFlagsInSegmentUsingTable(segment, CHARS, 2)
end

function updateSeaHearTail(segment)
    if not IS_GAME_RUNNING then return end
    checkFlagsInSegmentUsingTable(segment, SEA_HARE_TAIL)
end

function updateGoldKey(segment)
    if not IS_GAME_RUNNING then return end
    checkFlagsInSegmentUsingTable(segment, GOLD_KEY)
end

function updateMidgeMallet(segment)
    if not IS_GAME_RUNNING then return end
    checkFlagsInSegmentUsingTable(segment, MIDGE_MALLET)
end

function updateMoogleBelt(segment)
    if not IS_GAME_RUNNING then return end
    checkFlagsInSegmentUsingTable(segment, MOOGLE_BELT)
end

function updateSeeds(segment)
    if not IS_GAME_RUNNING then return end
    checkFlagsInSegmentUsingTable(segment, SEEDS)
end

function updateMagic(segment)
    if not IS_GAME_RUNNING then return end
    checkFlagsInSegmentUsingTable(segment, MAGIC)
end

function updateWeaponOrbs(segment)
    if not IS_GAME_RUNNING then return end
    checkFlagsInSegmentUsingTable(segment, WEAPONS_ORBS, 1)
end

function updateWeapons(segment)
    if not IS_GAME_RUNNING then return end
    checkFlagsInSegmentUsingTable(segment, WEAPONS)
end