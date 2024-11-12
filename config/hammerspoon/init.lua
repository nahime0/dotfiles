local CurrentWindow = {
    win = nil,
    frame = nil,
    screen = nil,
    maxFrame = nil,
    -- Configurazione predefinita
    config = {
        moveStep = 20,
        moveLargeStep = 100,
        animationDuration = 0.2,
        gridDivisions = 2, -- Per divisioni dello schermo (metà, terzi, quarti)
        padding = 0 -- Padding dalle estremità dello schermo
    }
}

function CurrentWindow:new(config)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    if config then
        for k, v in pairs(config) do
            self.config[k] = v
        end
    end
    return obj
end

function CurrentWindow:init()
    self.win = hs.window.focusedWindow()
    if not self.win then return false end
    self.frame = self.win:frame()
    self.screen = self.win:screen()
    self.maxFrame = self.screen:frame()
    return true
end

function CurrentWindow:animate(newFrame)
    if self.config.animationDuration > 0 then
        self.win:setFrame(newFrame, self.config.animationDuration)
    else
        self.win:setFrame(newFrame)
    end
end

function CurrentWindow:moveLeft(amount)
    if not self:init() then return end
    local nx = math.max(self.frame.x - amount, self.maxFrame.x + self.config.padding)
    self.frame.x = nx
    self:animate(self.frame)
end

function CurrentWindow:moveRight(amount)
    if not self:init() then return end
    local maxX = self.maxFrame.w - self.frame.w - self.config.padding
    local nx = math.min(self.frame.x + amount, maxX)
    self.frame.x = nx
    self:animate(self.frame)
end

function CurrentWindow:toLeft()
    if not self:init() then return end
    self.frame = {
        x = self.maxFrame.x + self.config.padding,
        y = self.maxFrame.y + self.config.padding,
        w = (self.maxFrame.w - (self.config.padding * 2)) / self.config.gridDivisions,
        h = self.maxFrame.h - (self.config.padding * 2)
    }
    self:animate(self.frame)
end

function CurrentWindow:toRight()
    if not self:init() then return end
    local width = (self.maxFrame.w - (self.config.padding * 2)) / self.config.gridDivisions
    self.frame = {
        x = self.maxFrame.x + self.maxFrame.w - width - self.config.padding,
        y = self.maxFrame.y + self.config.padding,
        w = width,
        h = self.maxFrame.h - (self.config.padding * 2)
    }
    self:animate(self.frame)
end

-- Nuove funzionalità
function CurrentWindow:maximize()
    if not self:init() then return end
    self.frame = {
        x = self.maxFrame.x + self.config.padding,
        y = self.maxFrame.y + self.config.padding,
        w = self.maxFrame.w - (self.config.padding * 2),
        h = self.maxFrame.h - (self.config.padding * 2)
    }
    self:animate(self.frame)
end

function CurrentWindow:center()
    if not self:init() then return end
    local centered = {
        x = self.maxFrame.x + (self.maxFrame.w - self.frame.w) / 2,
        y = self.maxFrame.y + (self.maxFrame.h - self.frame.h) / 2,
        w = self.frame.w,
        h = self.frame.h
    }
    self:animate(centered)
end

function CurrentWindow:moveToNextScreen()
    if not self:init() then return end
    local nextScreen = self.screen:next()
    self.win:moveToScreen(nextScreen)
end

-- Configurazione e istanziazione
local window = CurrentWindow:new({
    moveStep = 20,
    moveLargeStep = 100,
    animationDuration = 0.2,
    gridDivisions = 2,
    padding = 5
})

-- Keybindings
local mods = {
    normal = {"shift", "alt"},
    large = {"control", "shift", "alt"}
}

-- Movimenti base
hs.hotkey.bind(mods.normal, "H", function() window:toLeft() end)
hs.hotkey.bind(mods.normal, "L", function() window:toRight() end)
hs.hotkey.bind(mods.normal, "J", function() window:moveLeft(window.config.moveStep) end)
hs.hotkey.bind(mods.normal, "K", function() window:moveRight(window.config.moveStep) end)
hs.hotkey.bind(mods.large, "J", function() window:moveLeft(window.config.moveLargeStep) end)
hs.hotkey.bind(mods.large, "K", function() window:moveRight(window.config.moveLargeStep) end)

-- Nuovi keybindings
hs.hotkey.bind(mods.normal, "M", function() window:maximize() end)
hs.hotkey.bind(mods.normal, "C", function() window:center() end)
hs.hotkey.bind(mods.normal, "N", function() window:moveToNextScreen() end)
