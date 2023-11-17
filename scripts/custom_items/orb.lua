OrbItem = class(CustomItemOrb)

-- states
-- 0 => unknown
-- 1 => undine
-- 2 => gnome
-- 3 => sylphid
-- 4 => salamando
-- 5 => shade
-- 6 => lumina
-- 7 => luna
-- 8 => dryad

function OrbItem:init(name, code)
    self:createItem(name)
    self.code = code
    self.baseCode = code
    self:setProperty("active", false)
    self.isSpriteDisabled = 0
    self.isGirlDisabled = 0
    self.isRoleRando = 0
    self.hasAllElements = 0
    self.hasGirlRole = 0
    self.hasSpriteRole = 0
    self.state = 0
    self.notNeeded = {}

    self.disabledStates = 0 -- bitmask 

    self.ImageUnknown = ImageReference:FromPackRelativePath("images/orb.png")
    self.ImageUndine = ImageReference:FromPackRelativePath("images/orb_undine.png")
    self.ImageGnome = ImageReference:FromPackRelativePath("images/orb_gnome.png")
    self.ImageSylphid = ImageReference:FromPackRelativePath("images/orb_sylphid.png")
    self.ImageSalamando = ImageReference:FromPackRelativePath("images/orb_salamando.png")
    self.ImageShade = ImageReference:FromPackRelativePath("images/orb_shade.png")
    self.ImageLumina = ImageReference:FromPackRelativePath("images/orb_lumina.png")
    self.ImageLuna = ImageReference:FromPackRelativePath("images/orb_luna.png")
    self.ImageDryad = ImageReference:FromPackRelativePath("images/orb_dryad.png")
    self.ItemInstance.PotentialIcon = self.ImageUnknown

    self:updateIcon()
end

function OrbItem:getState()
    return self.state
end

function OrbItem:setState(state)
    self:propertyChanged("state", state)
end

function OrbItem:updateDisabledStates()
    self.disabledStates = 0
    if self.isSpriteDisabled == 1 then
        -- 1, 2, 5, 7, 8
        self.disabledStates = self.disabledStates | 1 << 0 | 1 << 1 | 1 << 4 | 1 << 6 | 1 << 7
    end
    if self.isGirlDisabled == 1 then
        -- 6
        self.disabledStates = self.disabledStates | 1 << 5
    end
    for i, v in ipairs(self.notNeeded) do
        if v > 0 then
            self.disabledStates = self.disabledStates | 1 << i - 1
        end
    end
end

function OrbItem:isStateDisabled(state)
    if state < 1 then
        return false
    end
    return self.disabledStates & 1 << (state - 1) > 0
end

function OrbItem:getNextState(state)
    if state == 8 then
        return 0
    else
        return state + 1
    end
end

function OrbItem:getPrevState(state)
    if state == 0 then
        return 8
    else
        return state - 1
    end
end

function OrbItem:advanceState()
    if ENABLE_DEBUG_LOG then
        print(string.format(
            "OrbItem:advanceState: self.isSpriteDisabled %s  self.isGirlDisabled %s  self.state %s  self.isRoleRando %s",
            self.isSpriteDisabled, self.isGirlDisabled, self.state, self.isRoleRando))
    end
    if self.isSpriteDisabled == 1 and self.isGirlDisabled == 1 then
        if (self.state ~= 0 and self.isRoleRando == 0) then
            self:setState(0)
        end
        return
    end
    local nextState = self:getNextState(self.state)
    while self:isStateDisabled(nextState) and nextState ~= self.setState do
        nextState = self:getNextState(nextState)
    end
    -- if self.isSpriteDisabled == 1 then
    --    while nextState == 1 or nextState == 2 or nextState == 5 or nextState == 7 or nextState == 8 do
    --        nextState = self:getNextState(nextState)
    --    end
    -- elseif self.isGirlDisabled == 1 then
    --    if nextState == 6 then
    --        nextState = self:getNextState(nextState)
    --    end
    -- end

    self:setState(nextState)
end

function OrbItem:decreaseState()
    if self.isSpriteDisabled == 1 and self.isGirlDisabled == 1 then
        if (self.state ~= 0 and self.isRoleRando == 0) then
            self:setState(0)
        end
        return
    end
    if self.disabledStates >= (1 << 8) - 1 then
        return
    end
    local nextState = self:getPrevState(self.state)
    while self:isStateDisabled(nextState) and nextState ~= self.setState do
        nextState = self:getPrevState(nextState)
    end
    -- if self.isSpriteDisabled == 1 then
    --    while nextState == 1 or nextState == 2 or nextState == 5 or nextState == 7 or nextState == 8 do
    --        nextState = self:getPrevState(nextState)
    --    end
    -- elseif self.isGirlDisabled == 1 then
    --    if nextState == 6 then
    --        nextState = self:getPrevState(nextState)
    --    end
    -- end

    self:setState(nextState)
end

function OrbItem:setActive(active)
    if active ~= true then
        self:setState(0)
    elseif self.state == 0 then
        self:setState(1)
    end
end

function OrbItem:getActive()
    if ENABLE_DEBUG_LOG then
        print(string.format(
            "OrbItem:getActive: state: %s, hasAllElements: %s, isSpriteDisabled: %s, isGirlDisabled: %s", self.state,
            self.hasAllElements, self.isSpriteDisabled, self.isGirlDisabled))
    end
    return (self.state > 0 or (self.hasAllElements == 1 and (self.isSpriteDisabled == 1 or self.hasGirlRole == 1) and
               (self.isSpriteDisabled == 1 or self.hasSpriteRole == 1)) or
               (self.isSpriteDisabled == 1 and self.isGirlDisabled == 1))
end

function OrbItem:updateIcon()
    if self.state == 0 then
        self.ItemInstance.Icon = self.ImageUnknown
    elseif self.state == 1 then
        self.ItemInstance.Icon = self.ImageUndine
    elseif self.state == 2 then
        self.ItemInstance.Icon = self.ImageGnome
    elseif self.state == 3 then
        self.ItemInstance.Icon = self.ImageSylphid
    elseif self.state == 4 then
        self.ItemInstance.Icon = self.ImageSalamando
    elseif self.state == 5 then
        self.ItemInstance.Icon = self.ImageShade
    elseif self.state == 6 then
        self.ItemInstance.Icon = self.ImageLumina
    elseif self.state == 7 then
        self.ItemInstance.Icon = self.ImageLuna
    elseif self.state == 8 then
        self.ItemInstance.Icon = self.ImageDryad
    end
end

function OrbItem:onLeftClick()
    self:advanceState()
end

function OrbItem:onRightClick()
    self:decreaseState()
end

function OrbItem:canProvideCode(code)
    if code == self.code then
        return true
    else
        return false
    end
end

function OrbItem:providesCode(code)
    if code == self.code and self:getActive() then
        return 1
    end
    return 0
end

function OrbItem:advanceToCode(code)
end

function OrbItem:save()
    local saveData = {}
    saveData["state"] = self:getState()
    return saveData
end

function OrbItem:load(data)
    if data["state"] ~= nil then
        self:setState(data["state"])
    end
    return true
end

function OrbItem:propertyChanged(key, value)
    if ENABLE_DEBUG_LOG then
        print("OrbItem:propertyChanged", key, value)
    end
    if key == "state" then
        self.state = value
    end
    if key == "isSpriteDisabled" then
        self.isSpriteDisabled = value
        self:updateDisabledStates()
        if self:isStateDisabled(self.state) and self.isRoleRando == 0 then
            self:setState(0)
        end
    end
    if key == "isGirlDisabled" then
        self.isGirlDisabled = value
        self:updateDisabledStates()
        if self:isStateDisabled(self.state) and self.isRoleRando == 0 then
            self:setState(0)
        end
    end
    if key == "isRoleRando" then
        self.isRoleRando = value
    end
    if (key == "isSpriteDisabled" or key == "isGirlDisabled") and self.isGirlDisabled == 1 and self.isSpriteDisabled ==
        1 and self.isRoleRando == 0 then
        self:setState(0)
    end
    if key == "hasAllElements" then
        self.hasAllElements = value
    end
    if key == "hasGirlRole" then
        self.hasGirlRole = value
    end
    if key == "hasSpriteRole" then
        self.hasSpriteRole = value
    end
    if key == "notNeeded" then
        --print("OrbItem:propertyChanged", "notNeeded", type(value))
        self.notNeeded = value
        -- self:updateDisabledStates()
        -- if self:isStateDisabled(self.state) then
        --    self:setState(0)
        -- end
    end
    if string.match(key, "not_needed") then
        if key == "undine_not_needed" then
            self.notNeeded[1] = value
        end
        if key == "gnome_not_needed" then
            self.notNeeded[2] = value
        end
        if key == "sylphid_not_needed" then
            self.notNeeded[3] = value
        end
        if key == "salamando_not_needed" then
            self.notNeeded[4] = value
        end
        if key == "shade_not_needed" then
            self.notNeeded[5] = value
        end
        if key == "lumina_not_needed" then
            self.notNeeded[6] = value
        end
        if key == "luna_not_needed" then
            self.notNeeded[7] = value
        end
        if key == "dryad_not_needed" then
            self.notNeeded[8] = value
        end
        self:updateDisabledStates()
        if self:isStateDisabled(self.state) then
            self:setState(0)
        end
    end
    self:updateIcon()
end
