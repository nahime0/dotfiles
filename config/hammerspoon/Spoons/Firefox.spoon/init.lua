--- === Firefox ===
---
--- Firefox functionality for Hammerspoon
---
--- Download: [https://github.com/nahime/dotfiles/tree/main/config/hammerspoon/Spoons/Firefox.spoon](https://github.com/nahime/dotfiles/tree/main/config/hammerspoon/Spoons/Firefox.spoon)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Firefox"
obj.version = "1.0"
obj.author = "nahime"
obj.homepage = "https://github.com/nahime/dotfiles"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
    self.mods = {"ctrl", "shift", "alt", "cmd"}
    return self
end

function obj:focusOrOpen()
    local firefox = hs.application.find("Firefox", true)
    if firefox then
        if not firefox:isFrontmost() then
            firefox:activate()
        end
    else
        hs.application.open("/Applications/Firefox.app")
    end
end

function obj:bindHotkeys()
    hs.hotkey.bind(self.mods, "F", function() self:focusOrOpen() end)
end

return obj
