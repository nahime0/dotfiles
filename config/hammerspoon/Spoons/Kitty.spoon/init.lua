--- === Kitty ===
---
--- Kitty functionality for Hammerspoon
---
--- Download: [https://github.com/nahime/dotfiles/tree/main/config/hammerspoon/Spoons/Kitty.spoon](https://github.com/nahime/dotfiles/tree/main/config/hammerspoon/Spoons/Kitty.spoon)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Kitty"
obj.version = "1.0"
obj.author = "nahime"
obj.homepage = "https://github.com/nahime/dotfiles"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
    self.mods = {"ctrl", "shift", "alt", "cmd"}
    return self
end

function obj:focusOrOpen()
    local kitty = hs.application.find("kitty", true)
    if kitty then
        if not kitty:isFrontmost() then
            kitty:activate()
        end
    else
        hs.application.open("/Applications/kitty.app")
    end
end

function obj:bindHotkeys()
    hs.hotkey.bind(self.mods, "K", function() self:focusOrOpen() end)
end

return obj
