OrbItem = class(CustomItemOrb)

-- states
-- 0 => unknown
-- 1 => undine
-- 2 => rocky
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
    self.forceState = false
    self.removeLumina = false
    self.state = 0

    self.ImageUnknown = ImageReference:FromPackRelativePath("images/orb.png")
    self.ImageUndine = ImageReference:FromPackRelativePath("images/orb_undine.png")
    self.ImageRocky = ImageReference:FromPackRelativePath("images/orb_rocky.png")
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
    self:propertyChanged("state",state)
end

function OrbItem:advanceState()   
    if self.forceState == false then
        if self.state == 8 then
            self:setState(0)
        elseif self.state == 5 and self.removeLumina == true then 
            self:setState(self.state + 2)
        else
            self:setState(self.state + 1)
        end
    end
end

function OrbItem:decreaseState()
    if self.forceState == false then
        if self.state == 0 then
            self:setState(8)
        elseif self.state == 7 and self.removeLumina == true then 
            self:setState(self.state - 2)
        else
            self:setState(self.state - 1)
        end
    end
end

function OrbItem:setActive(active)
    if self.forceState == false then
        if active ~= true then
            self:setState(0)
        elseif self.state == 0 then
            self:setState(1)
        end
    end
end

function OrbItem:getActive()
    return (self.state > 0 or self.forceState == true)
end

function OrbItem:updateIcon()
    if self.state == 0 then
        self.ItemInstance.Icon = self.ImageUnknown
    elseif self.state == 1 then
        self.ItemInstance.Icon = self.ImageUndine
    elseif self.state == 2 then
        self.ItemInstance.Icon = self.ImageRocky
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
    if code == self.code then
        return self.state
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
    if (key == "state") then
        self.state = value
    end
    if key == "forceState" then
        self.forceState = value
    end
    if key == "removeLumina" then
        self.removeLumina = value
        if self.state == 6 then
            self.setState(0)
        end
    end
    self:updateIcon()
end
