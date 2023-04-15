--[[
	Azimuth
	Customizations and automations for my way of working.
]]
dofile(hs.spoons.resourcePath("Azimuth.lua"))

-- spoon
obj = _Azimuth:initSpoon()

--[[
  Hotkeys
--]]
obj.hotkeys = {
  caffeinate = true
}

--- Init
function obj:init()
  _Azimuth.logger.i("init")
  obj.hotkeys = _Azimuth:initHotKeys(obj.hotkeys)
end

--- Start
function obj:start()
  _Azimuth.logger.i("start")
  obj.hotkeys = _Azimuth:enableHotKeys(obj.hotkeys)
end

--- Stop
function obj:stop()
  _Azimuth.logger.i("stop")
  obj.hotkeys = _Azimuth:disableHotKeys(obj.hotkeys)
end

return obj
