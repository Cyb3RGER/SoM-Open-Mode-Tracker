CharacterItem = class(CustomItemCharacter)

-- states
-- 0 => disabled
-- 1 => not found
-- 2 => found

-- roles
-- 0 => unknown
-- 1 => boy/warrior
-- 2 => girl/light mage
-- 3 => sprite/dark mage

function CharacterItem:init(name, code)
    self:createItem(name)
    self.code = code
    self:setProperty("active", false)

    self.state = 1
    self.role = 0
    self.ImageDisabled = ImageReference:FromPackRelativePath("images/"..code.."_disabled.png")
    self.ImageNotFound = ImageReference:FromPackRelativePath("images/"..code.."_not_found.png")
    self.ImageFound = ImageReference:FromPackRelativePath("images/"..code..".png")
    self.OverlayImageBoy = "images/boy_overlay.png"
    self.OverlayImageGirl = "images/girl_overlay.png"
    self.OverlayImageSprite = "images/sprite_overlay.png"
    self.OverlayImageUnknown = "images/overlay_unknown.png"
    self.ItemInstance.PotentialIcon = self.ImageNotFound
    if PopVersion and PopVersion >= "0.11.0" then
        self.ItemInstance.IconMods = ""
    end
    self.isRoleRando = false
    self:updateIcon()    
end

function CharacterItem:getState()
    return self.state
end

function CharacterItem:setState(state)
    self:propertyChanged("state",state)
end

function CharacterItem:getRole()
    if isRoleRando then
        return self.role
    else
        if self.code == "boy" then
            return 1
        elseif self.code == "girl" then
            return 2
        elseif self.code == "sprite" then
            return 3
        else
            return 0
        end
    end
end

function CharacterItem:setRole(role)
    self:propertyChanged("role",role)
end

function CharacterItem:getIsRoleRando()
    return self.isRoleRando
end

function CharacterItem:setIsRoleRando(value)
    self:propertyChanged("isRoleRando",value)
end


function CharacterItem:advanceState()
    if self.state == 2 then
        self:setState(0)
    else     
        self:setState(self.state + 1)
    end
end

function CharacterItem:advanceRole()    
    if self.role == 3 then    
        self:setRole(0)  
    else 
        self:setRole(self.role + 1)
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
    if PopVersion and PopVersion >= "0.11.0" then
        if self.isRoleRando == true then
            if self.role == 0 then
                self.ItemInstance.IconMods = "overlay|"..self.OverlayImageUnknown
            elseif self.role == 1 then
                self.ItemInstance.IconMods = "overlay|"..self.OverlayImageBoy
            elseif self.role == 2 then
                self.ItemInstance.IconMods = "overlay|"..self.OverlayImageGirl
            elseif self.role == 3 then
                self.ItemInstance.IconMods = "overlay|"..self.OverlayImageSprite
            end
        else
            self.ItemInstance.IconMods = ""
        end
    end
end

function CharacterItem:onLeftClick()
    self:advanceState()
end

function CharacterItem:onRightClick()
    if not self.isRoleRando or self.state == 0 then return end
    self:advanceRole()
end

function CharacterItem:canProvideCode(code)
    if code == self.code then
        return true
    elseif  code == "role_boy" and self:getRole() == 1 and self:getActive() then
        return true
    elseif code == "role_girl" and self:getRole() == 2 and self:getActive() then
        return true
    elseif code == "role_sprite" and self:getRole() == 3 and self:getActive() then
        return true
    else
        return false
    end
end

function CharacterItem:providesCode(code)    
    if code == self.code then
        return self.state
    end
    if code == "role_boy" and self:getRole() == 1 and self:getActive() then
        return self.state
    end
    if code == "role_girl" and self:getRole() == 2 and self:getActive() then
        return self.state
    end
    if code == "role_sprite" and self:getRole() == 3 and self:getActive() then
        return self.state
    end
    return 0
end

function CharacterItem:advanceToCode(code)
end

function CharacterItem:save()
    local saveData = {}
    saveData["state"] = self:getState()
    saveData["role"] = self:getRole()
    return saveData
end

function CharacterItem:load(data)
    if data["state"] ~= nil then
        self:setState(data["state"])
    end
    if data["role"] ~= nil then
        self:setRole(data["role"])
    end
    return true
end

function CharacterItem:propertyChanged(key, value)
    if key == "state" then
        self.state = value
    end
    if key == "role" then
        self.role = value
    end
    if key == "isRoleRando" then
        self.isRoleRando = value
    end
    self:updateIcon()
end
