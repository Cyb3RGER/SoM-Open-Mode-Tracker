CharacterItem = class(CustomItemCharacter)

-- states
-- 0 => disabled
-- 1 => not found
-- 2 => found

function CharacterItem:init(name, code)
    self:createItem(name)
    self.code = code
    self:setProperty("active", false)

    self.state = 1

    self.ImageDisabled = ImageReference:FromPackRelativePath("images/"..code.."_disabled.png")
    self.ImageNotFound = ImageReference:FromPackRelativePath("images/"..code.."_not_found.png")
    self.ImageFound = ImageReference:FromPackRelativePath("images/"..code..".png")
    
    self.ItemInstance.PotentialIcon = self.ImageNotFound

    self:updateIcon()    
end

function CharacterItem:getState()
    return self.state
end

function CharacterItem:setState(state)
    self:propertyChanged("state",state)
end

function CharacterItem:advanceState()
    if self.state == 2 then
    else     
        self:setState(self.state + 1)
    end
end

function CharacterItem:decreaseState()
    if self.state == 0 then      
    else 
        self:setState(self.state - 1)
    end
end

function CharacterItem:setActive(active)
    if active == true and self.state == 1 then
        self:setState(2)
    else
        self:setState(1)
    end
end

function CharacterItem:getActive()
    return (self.state == 2 or self.state == 0)
end

function CharacterItem:updateIcon()
    if self.state == 1 then
        self.ItemInstance.Icon = self.ImageNotFound
    elseif self.state == 2 then
        self.ItemInstance.Icon = self.ImageFound
    elseif self.state == 0 then
        self.ItemInstance.Icon = self.ImageDisabled
    end
end

function CharacterItem:onLeftClick()
    self:advanceState()
end

function CharacterItem:onRightClick()
    self:decreaseState()
end

function CharacterItem:canProvideCode(code)
    if code == self.code then
        return true
    else
        return false
    end
end

function CharacterItem:providesCode(code)
    if code == self.code then
        return self.state
    end
    return 0
end

function CharacterItem:advanceToCode(code)
end

function CharacterItem:save()
    local saveData = {}
    saveData["state"] = self:getState()
    return saveData
end

function CharacterItem:load(data)
    if data["state"] ~= nil then
        self:setState(data["state"])
    end
    return true
end

function CharacterItem:propertyChanged(key, value)
    if key == "state" then
        self.state = value
    end
    self:updateIcon()
end
