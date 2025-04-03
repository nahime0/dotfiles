-- Load Spoons
hs.loadSpoon("WindowManager")
hs.loadSpoon("Cursor")
hs.loadSpoon("Firefox")
hs.loadSpoon("Kitty")

-- Configure WindowManager
spoon.WindowManager:configure({
    moveStep = 20,
    moveLargeStep = 100,
    animationDuration = 0.2,
    gridDivisions = 2,
    padding = 5
})

-- Bind default hotkeys
spoon.WindowManager:bindHotkeys()
spoon.Cursor:bindHotkeys()
spoon.Firefox:bindHotkeys()
spoon.Kitty:bindHotkeys()