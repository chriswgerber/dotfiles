--- CaffeineBar class

dofile(hs.spoons.resourcePath("CaffeineWatcher.lua"))

CaffeineBar = {
    name     = "CaffeineBar",
    version  = "1.0",
    author   = "chriswgerber <chriswgerber@gmail.com>",
    homepage = "https://www.chriswgerber.com",
    license  = "MIT - https://opensource.org/licenses/MIT",
---
    menuID      = "com.chriswgerber.CaffeineBar",
    settingsKey = "CaffeineBar_enable",
    sleepType   = "displayIdle",
---
    logger  = hs.logger.new('Caff.Bar', 'debug'),
    menubar = nil,
    watcher = CaffeineWatcher,
    hotkeys = {},
---
    bindings = {
        enable = {
            {"cmd", "alt"},
            "L",
            function() CaffeineBar:setCaffeinate(true) end,
        },
        disable = {
            {"ctrl", "cmd", "alt"},
            "L",
            function() CaffeineBar:setCaffeinate(false) end,
        },
    }
}
CaffeineBar.__index = CaffeineBar

--- Menu view constants.
local CaffeineStates = {
    ON = "on",
    OFF = "off",
}


--- View states
menuIcons = {
    on = hs.spoons.resourcePath("Resources/full-mug-drink-svgrepo-com.svg"),
    off = hs.spoons.resourcePath("Resources/empty-mug-drink-svgrepo-com.svg"),
}

--- CaffeineBar:updateState(state)
--- Method
--- Updates the display of the caffeine menu bar based on the current state.
---
--- Parameters:
---  * state - A boolean describing if it is on or off.
---
--- Returns:
---  * Nil
function CaffeineBar:updateState(state)
    if state then
        hs.settings.set(self.settingsKey, CaffeineStates.ON)
        self.menubar:setIcon(menuIcons[CaffeineStates.ON])
    else
        hs.settings.set(self.settingsKey, CaffeineStates.OFF)
        self.menubar:setIcon(menuIcons[CaffeineStates.OFF])
    end
end

--- CaffeineBar:setCaffeinate(state)
--- Method
--- Enable caffeinate to prevent display idle.
---
--- Parameters:
---  * state: State to set caffeinate to.
---
--- Returns:
---  * Nil
function CaffeineBar:setCaffeinate(state)
    hs.caffeinate.set(self.sleepType, state)
    self:updateState(state)
end

--- CaffeineBar:clicked()
--- Method
--- A method called when menu is clicked to toggle caffeinate status.
---
--- Returns:
---  * Nil
function CaffeineBar:toggleCaffeinate()
    state = hs.caffeinate.toggle(self.sleepType)
    self:updateState(state)
end

--- CaffeineBar:watchSetting()
--- Method
--- A method called when there is a change to the caffeinate setting.
---
--- Returns:
---  * Nil
function CaffeineBar:watchSetting()
    self.logger.i("settings:watcher")
    self:updateState(hs.caffeinate.get(self.sleepType))
end
