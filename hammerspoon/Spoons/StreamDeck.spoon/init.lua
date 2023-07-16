hs.printf("Loading spoon Streamdeck")

require "Azimuth.streamdeck.buttons"

local Deck = {
    name     = "Deck",
    version  = "1.0",
    author   = "chriswgerber <chriswgerber@gmail.com>",
    homepage = "https://www.chriswgerber.com",
    license  = "MIT - https://opensource.org/licenses/MIT",

---
    logger  = hs.logger.new('Deck', 'debug'),

--- Buttons
    buttons = {
        ['name'] = 'Lock',
        ['image'] = streamdeck_imageFromText('🔒'),
        ['onClick'] = function()
            hs.caffeinate.lockScreen()
        end
    }
}
Deck.__index = Deck
Deck.currentDeck = nil

function streamdeckDiscoverer(connected, obj)
    if connected then
        Deck.currentDeck = obj
        for i, button in ipairs(Deck.buttons) do
            Deck.currentDeck:setButtonImage(i, button.image)
        end
    end

    Deck.currentDeck:buttonCallback(streamdeckHandler)
end

function streamdeckHandler(userdata, button, pressed)
    if pressed then
        button = Deck.currentDeck.buttons[i]
        if button then
            button.onClick()
        end
    end
end

--- Deck:init()
--- Method
--- Initialize the spoon.
---
--- Returns:
---  * Nil
function Deck:init()
    self.logger.i("start")
    hs.streamdeck.init(streamdeckDiscoverer)
end

--- Deck:start()
--- Method
--- Start the spoon.
---
--- Returns:
---  * Nil
function Deck:start()
    self.logger.i("start")
    devices = hs.streamdeck.numDevices()
    self.logger.f("Number of devices: %d", devices)
end

--- Deck:stop()
--- Method
--- Stop the spoon.
---
--- Returns:
---  * Nil
function Deck:stop()
    self.logger.i("Stop")
    -- for k, v in pairs(self.hotkeys) do
    --     self.logger.i("hotkey.disable.", k)
    --     self.hotkeys[k] = v:disable()
    -- end
end

return Deck
