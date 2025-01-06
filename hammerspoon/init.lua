hs.printf("hs.configdir = %s", hs.configdir)
dot_spoons_dir = hs.configdir .. "/Spoons"
hs.printf("Extra spoons dir %s", dot_spoons_dir)

-- Add dots dirs to path
package.path = dot_spoons_dir .. "/?.spoon/init.lua;" .. package.path
package.path = dot_spoons_dir .. "/?.lua;" .. package.path

-- ===========
-- Load spoons
-- ===========


-- Caffeinate
hs.loadSpoon("CaffeineBar")
spoon.CaffeineBar:start()


-- Notify
hs.loadSpoon("Notify")
spoon.Notify.hostname = "Keyva-mbp"
spoon.Notify:start()


-- -- VPNDaemon
-- hs.loadSpoon("VPNDaemon")
-- spoon.VPNDaemon:start()


-- Streamdeck plugin
-- hs.loadSpoon("StreamDeck")
-- spoon.StreamDeck:start()


-- PushToTalk plugin
-- hs.loadSpoon("PushToTalk")
-- spoon.PushToTalk.app_switcher = { ['Slack'] = 'push-to-talk' }
-- spoon.PushToTalk:start()
