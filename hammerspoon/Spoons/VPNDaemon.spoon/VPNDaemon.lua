--- VPNDaemon class
dofile(hs.spoons.resourcePath("VPNDaemonService.lua"))


VPNDaemon = {
    spoon    = VPNDaemonService,
    logName  = 'VPNDaemon',
    logLevel = 'info',
    logger   = nil,
    ---
    networkConfig     = hs.network.configuration.open(),
}
VPNDaemon.settingsCallback = function(a, b)
    VPNDaemon.spoon:watchSetting(a, b)
end
VPNDaemon.__index = VPNDaemon

--- VPNDaemon:init()
--- Method
--- Initialize the spoon.
---
--- Returns:
---  * Nil
function VPNDaemon:init()
    self.logger = hs.logger.new(self.logName, self.logLevel)
    self.logger.i("Init")

    -- Create Menubar
    self.spoon.menuIcon = MenuItem:new{menuID = self.spoon.menuID}
end

--- VPNDaemon:start()
--- Method
--- Start the spoon.
---
--- Returns:
---  * Nil
function VPNDaemon:start()
    self.logger.i("Start")
    self.spoon.logger = hs.logger.new(self.spoon.logName, self.spoon.logLevel)

    --- Monitor
    self.networkConfig:monitorKeys(self.spoon.settingsKeys)
    self.networkConfig:setCallback(self.settingsCallback)
    self.networkConfig:start()

    -- Set Initial
    self.settingsCallback(self.networkConfig, self.spoon.settingsKeys)
end
