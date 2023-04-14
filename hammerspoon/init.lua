-- Look for Spoons in ~/.dotfiles/hammerspoon/Spoons

-- Hardcode because envs
dot_spoons_dir = os.getenv("HOME") .. "/.dotfiles/hammerspoon/Spoons/?.spoon/init.lua"

-- Add path
hs.printf("Extra spoons dir %s", dot_spoons_dir)
package.path = package.path .. ";" .. dot_spoons_dir

-- Load spoons
hs.loadSpoon("CaffeineBar")
spoon.CaffeineBar:start()

hs.loadSpoon("Notify")
spoon.Notify.hostname = "Improving-mbp"
spoon.Notify:start()

-- hs.loadSpoon("PushToTalk")
-- spoon.PushToTalk.app_switcher = { ['Slack'] = 'push-to-talk' }
-- spoon.PushToTalk:start()
