--- === WindowManager ===
---
--- Window management functionality for Hammerspoon
---
--- Download: [https://github.com/nahime/dotfiles/tree/main/config/hammerspoon/Spoons/WindowManager.spoon](https://github.com/nahime/dotfiles/tree/main/config/hammerspoon/Spoons/WindowManager.spoon)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "WindowManager"
obj.version = "1.0"
obj.author = "nahime"
obj.homepage = "https://github.com/nahime/dotfiles"
obj.license = "MIT - https://opensource.org/licenses/MIT"

-- Default configuration
obj.defaultConfig = {
    moveStep = 20,
    moveLargeStep = 100,
    animationDuration = 0.2,
    gridDivisions = 2,
    padding = 5
}

obj.config = {}

function obj:init()
    self.config = {}
    for k, v in pairs(self.defaultConfig) do
        self.config[k] = v
    end
    return self
end

function obj:configure(config)
    if config then
        for k, v in pairs(config) do
            self.config[k] = v
        end
    end
    return self
end

function obj:getCurrentWindow()
    local win = hs.window.focusedWindow()
    if not win then return nil end
    return {
        win = win,
        frame = win:frame(),
        screen = win:screen(),
        maxFrame = win:screen():frame()
    }
end

function obj:animate(win, newFrame)
    if self.config.animationDuration > 0 then
        win:setFrame(newFrame, self.config.animationDuration)
    else
        win:setFrame(newFrame)
    end
end

function obj:moveLeft(amount)
    local current = self:getCurrentWindow()
    if not current then return end
    local nx = math.max(current.frame.x - amount, current.maxFrame.x + self.config.padding)
    current.frame.x = nx
    self:animate(current.win, current.frame)
end

function obj:moveRight(amount)
    local current = self:getCurrentWindow()
    if not current then return end
    local maxX = current.maxFrame.w - current.frame.w - self.config.padding
    local nx = math.min(current.frame.x + amount, maxX)
    current.frame.x = nx
    self:animate(current.win, current.frame)
end

function obj:toLeft()
    local current = self:getCurrentWindow()
    if not current then return end
    local frame = {
        x = current.maxFrame.x + self.config.padding,
        y = current.maxFrame.y + self.config.padding,
        w = (current.maxFrame.w - (self.config.padding * 2)) / self.config.gridDivisions,
        h = current.maxFrame.h - (self.config.padding * 2)
    }
    self:animate(current.win, frame)
end

function obj:toRight()
    local current = self:getCurrentWindow()
    if not current then return end
    local width = (current.maxFrame.w - (self.config.padding * 2)) / self.config.gridDivisions
    local frame = {
        x = current.maxFrame.x + current.maxFrame.w - width - self.config.padding,
        y = current.maxFrame.y + self.config.padding,
        w = width,
        h = current.maxFrame.h - (self.config.padding * 2)
    }
    self:animate(current.win, frame)
end

function obj:maximize()
    local current = self:getCurrentWindow()
    if not current then return end
    local frame = {
        x = current.maxFrame.x + self.config.padding,
        y = current.maxFrame.y + self.config.padding,
        w = current.maxFrame.w - (self.config.padding * 2),
        h = current.maxFrame.h - (self.config.padding * 2)
    }
    self:animate(current.win, frame)
end

function obj:center()
    local current = self:getCurrentWindow()
    if not current then return end
    local centered = {
        x = current.maxFrame.x + (current.maxFrame.w - current.frame.w) / 2,
        y = current.maxFrame.y + (current.maxFrame.h - current.frame.h) / 2,
        w = current.frame.w,
        h = current.frame.h
    }
    self:animate(current.win, centered)
end

function obj:moveToNextScreen()
    local current = self:getCurrentWindow()
    if not current then return end
    local nextScreen = current.screen:next()
    current.win:moveToScreen(nextScreen)
end

function obj:bindHotkeys()
    local mods = {
        normal = {"shift", "alt"},
        large = {"ctrl", "shift", "alt"}
    }

    -- Bind all the hotkeys with default mappings
    hs.hotkey.bind(mods.normal, "H", function() self:toLeft() end)
    hs.hotkey.bind(mods.normal, "L", function() self:toRight() end)
    hs.hotkey.bind(mods.normal, "J", function() self:moveLeft(self.config.moveStep) end)
    hs.hotkey.bind(mods.normal, "K", function() self:moveRight(self.config.moveStep) end)
    hs.hotkey.bind(mods.large, "J", function() self:moveLeft(self.config.moveLargeStep) end)
    hs.hotkey.bind(mods.large, "K", function() self:moveRight(self.config.moveLargeStep) end)
    hs.hotkey.bind(mods.normal, "M", function() self:maximize() end)
    hs.hotkey.bind(mods.normal, "C", function() self:center() end)
    hs.hotkey.bind(mods.normal, "N", function() self:moveToNextScreen() end)
end

return obj 