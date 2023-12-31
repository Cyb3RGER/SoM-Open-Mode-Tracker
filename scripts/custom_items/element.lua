ElementItem = class(CustomItemElement)

-- states
-- 0 => unknown
-- 1 => needed for GP
-- 2 => not needed for GP

function ElementItem:init(name, code)
    self:createItem(name)
    self.code = code
    self.code_needed = code.."_needed"
    self.code_not_needed = code.."_not_needed"
    -- self:setProperty("active", false)

    self.active = false
    self.state = 0
    self.ElementImage = ImageReference:FromPackRelativePath("images/" .. code .. ".png")
    self.OverlayImageNeeded = "images/overlay_gp_needed.png"
    self.OverlayImageNotNeeded = "images/overlay_not_gp.png"
    self.ItemInstance.Icon = self.ElementImage
    self.ItemInstance.PotentialIcon = self.ElementImage
    if PopVersion and PopVersion >= "0.11.0" then
        self.ItemInstance.IconMods = ""
    end
    self:updateIcon()
end

function ElementItem:getState()
    return self.state
end

function ElementItem:setState(state)
    self:propertyChanged("state", state)
end

function ElementItem:advanceState()
    if self:getState() == 2 then
        self:setState(0)
    else
        self:setState(self.state + 1)
    end
end

function ElementItem:decreaseState()
    if self:getState() == 0 then
        self:setState(2)
    else
        self:setState(self.state - 1)
    end
end

function ElementItem:setActive(active)
    self:propertyChanged("active", active)
end

function ElementItem:getActive()
    return self.active
end

function ElementItem:addImageMod(mods, mod)
    if #mods == 0 then
        mods = mod
    else
        mods = mods..","..mod
    end
    return mods
end

function ElementItem:updateIcon()
    local mods = ""
    if not self:getActive() then
        mods = self:addImageMod(mods, "@disabled")
    end
    if self:getState() == 1 then
        mods = self:addImageMod(mods, "overlay|" .. self.OverlayImageNeeded)
    elseif self:getState() == 2 then
        mods = self:addImageMod(mods, "overlay|" .. self.OverlayImageNotNeeded)
    end    
    if PopVersion and PopVersion >= "0.11.0" then
        self.ItemInstance.IconMods = mods
    end
end


function ElementItem:onLeftClick()
    self:setActive(not self.active)
end

function ElementItem:onRightClick()
    self:advanceState()
end

function ElementItem:canProvideCode(code)
    if code == self.code then
        return true
    elseif code == "not_needed" then
        return true    
    elseif code == self.code_needed then
        return true
    elseif code == self.code_not_needed then
        return true
    else
        return false
    end
end

function ElementItem:providesCode(code)    
    if code == self.code and self:getActive() then
        return 1
    end
    if code == self.code_needed and self:getState() == 1 then
        return 1
    end
    if code == self.code_not_needed and self:getState() == 2 then
        return 1
    end
    return 0
end

function ElementItem:advanceToCode(code)
end

function ElementItem:save()
    local saveData = {}
    saveData["active"] = self:getActive()
    saveData["state"] = self:getState()
    return saveData
end

function ElementItem:load(data)
    if data["active"] ~= nil then
        self:setActive(data["active"])
    end
    if data["state"] ~= nil then
        self:setState(data["state"])
    end
    return true
end

function ElementItem:propertyChanged(key, value)
    if key == "active" then
        self.active = value
    end
    if key == "state" then
        self.state = value
    end
    self:updateIcon()
end
