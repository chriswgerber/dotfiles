
_Azimuth = {}
_Azimuth.settings = {}
_Azimuth.logger = hs.logger.new('Azimuth', 'debug')

_obj = nil

function _Azimuth:initSpoon()
  if not _obj then
    _obj = {}
  end
  _obj.__index = obj
  _obj.name = "Azimuth"
  _obj.version = "1.0"
  _obj.author = "chriswgerber <chriswgerber@gmail.com>"
  _obj.homepage = "https://www.chriswgerber.com"
  _obj.license = "MIT - https://opensource.org/licenses/MIT"

  return _obj
end


-- Icons
-- local icons <const> = {
--   on  = hs.spoons.resourcePath("Resources/caffeine_full_icon.png"),
--   off = hs.spoons.resourcePath("Resources/caffeine_empty_icon.png")
-- }

_Azimuth.settings.caffeinate_key = "azimuth_caffeinate"
--- Azimuth:caffeinate(title, icon)
--- Method
--- Toggles caffeinate status
---
--- Parameters:
---  * Nil
---
--- Returns:
---  * Nil
function _Azimuth:caffeinate()
  _Azimuth.logger.i("Toggle caffeine")

  hs.caffeinate.set("displayIdle", true, true)
  hs.settings.set(_Azimuth.settings.caffeinate_key, "on")

  _Azimuth.logger.i("Caffeine State", hs.caffeinate.get("displayIdle"))
end

--- Hotkeys
local hotkeys <const> = {
  caffeinate = function ()
    _Azimuth.logger.i("caffeinate.enable")
    hs.settings.set(_Azimuth.settings.caffeinate_key, "off")
    return hs.hotkey.new({"cmd", "alt"}, "L", function() _Azimuth:caffeinate() end)
  end,
}

function _Azimuth:initHotKeys(target)
  _Azimuth.logger.i("hotkey.init start", target.caffeinate)
  for k,v in pairs(target) do
    _Azimuth.logger.i("hotkey.init ", k)
    fnc = hotkeys[k]
    target[k] = fnc()
  end
  return target
end

function _Azimuth:enableHotKeys(target)
  for k,v in pairs(target) do
    _Azimuth.logger.i("hotkey.enable %s", k)
    target[k] = v:enable()
  end
  return target
end

function _Azimuth:disableHotKeys(target)
  for k,v in pairs(target) do
    _Azimuth.logger.i("hotkey.disable %s", k)
    target[k] = v:disable()
  end
  return target
end
