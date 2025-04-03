--- === Cursor ===
---
--- Cursor functionality for Hammerspoon
---
--- Download: [https://github.com/nahime/dotfiles/tree/main/config/hammerspoon/Spoons/Cursor.spoon](https://github.com/nahime/dotfiles/tree/main/config/hammerspoon/Spoons/Cursor.spoon)

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Cursor"
obj.version = "1.0"
obj.author = "nahime"
obj.homepage = "https://github.com/nahime/dotfiles"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
    self.mods = {"ctrl", "shift", "alt", "cmd"}
    return self
end

function obj:focusOrOpen()
    local cursor = hs.application.find("Cursor", true)
    if cursor then
        if not cursor:isFrontmost() then
            cursor:activate()
        end
    else
        hs.application.open("/Applications/Cursor.app")
    end
end

function obj:bindHotkeys()
    hs.hotkey.bind(self.mods, "R", function() self:focusOrOpen() end)
end

return obj
