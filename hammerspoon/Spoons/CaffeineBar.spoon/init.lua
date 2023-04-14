--- === CaffeineBar ===
---
--- Menu bar and keybindings for managing the Caffeinate status for Mac.

dofile(hs.spoons.resourcePath("CaffeineBar.lua"))

--- CaffeineBar:init()
--- Method
--- Initialize the spoon.
---
--- Returns:
---  * Nil
function CaffeineBar:init()
    self.logger.i("Init")

    -- Clear settings
    if hs.settings.get(self.settingsKey) then
        hs.settings.clear(self.settingsKey)
    end

    -- Create Menubar
    self.menubar = hs.menubar.new(true, self.menuID)

    -- Create Hotkeys
    for k, v in pairs(self.bindings) do
        self.logger.f("hotkey.init: Binding:%s", k)
        self.hotkeys[k] = hs.hotkey.new(v[1], v[2], v[3])
    end
end

--- CaffeineBar:start()
--- Method
--- Start the spoon.
---
--- Returns:
---  * Nil
function CaffeineBar:start()
    self.logger.i("Start")
    -- Set menu and click callback
    self:setCaffeinate(false)
    self.menubar:setClickCallback(function() self:toggleCaffeinate() end)
    -- Watch caffeine state
    self.watcher:enable(self.settingsKey, function() self:watchSetting() end)
    -- Enable hotkeys
    for k, v in pairs(self.hotkeys) do
        self.logger.f("hotkey.enable: %s", k)
        self.hotkeys[k] = v:enable()
    end
end

--- CaffeineBar:stop()
--- Method
--- Stop the spoon.
---
--- Returns:
---  * Nil
function CaffeineBar:stop()
    self.logger.i("Stop")
    -- Stop watching state
    self.watcher:disable(self.settingsKey)
    -- Clear setting
    hs.settings.clear(self.settingsKey)
    -- Disable hotkeys
    for k, v in pairs(self.hotkeys) do
        self.logger.i("hotkey.disable.", k)
        self.hotkeys[k] = v:disable()
    end
end

return CaffeineBar
