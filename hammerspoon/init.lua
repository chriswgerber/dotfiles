hs.printf("hs.configdir = %s", hs.configdir)

dot_spoons_dir = hs.configdir .. "/Spoons"
hs.printf("Extra spoons dir %s", dot_spoons_dir)

-- Add dots dirs to path
package.path = dot_spoons_dir .. "/?.spoon/init.lua;" .. package.path
package.path = dot_spoons_dir .. "/?.lua;" .. package.path

-- ===========
-- Load spoons
-- ===========


-- Caffeinate plugin
hs.loadSpoon("CaffeineBar")
spoon.CaffeineBar:start()


-- Notify plugin
hs.loadSpoon("Notify")
spoon.Notify.hostname = "ChrisWGerber-mbp"
spoon.Notify:start()


-- Streamdeck plugin
-- hs.loadSpoon("StreamDeck")
-- spoon.StreamDeck:start()


-- PushToTalk plugin
-- hs.loadSpoon("PushToTalk")
-- spoon.PushToTalk.app_switcher = { ['Slack'] = 'push-to-talk' }
-- spoon.PushToTalk:start()
