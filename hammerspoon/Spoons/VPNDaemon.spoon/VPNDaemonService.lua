--- VPNDaemonService class

dofile(hs.spoons.resourcePath("Menu.lua"))
dofile(hs.spoons.resourcePath("Util.lua"))

VPNDaemonService = {
    name     = "VPNDaemonService",
    version  = "1.0",
    author   = "chriswgerber <chriswgerber@gmail.com>",
    homepage = "https://www.chriswgerber.com",
    license  = "MIT - https://opensource.org/licenses/MIT",
    ---
    menuID      = "com.chriswgerber.VPNDaemonService",
    settingsKeys = {
        "State:/Network/Interface/ppp0/IPv4",
        "State:/Network/Global/DNS",
        "Setup:/Network/Service/[A-Z0-9\\-]+/DNS"
    },
    inetKey = "State:/Network/Interface/ppp0/IPv4",
    dnsKey = "Setup:/Network/Service/[A-Z0-9\\-]+/DNS",
    -- dnsKey = "State:/Network/Global/DNS",
    ---
    logName = 'VPNDaemonService',
    logLevel = 'info',
    logger  = nil,
    menuIcon = nil,
    networkState = {
        DNS = nil,
        IPv4 = {
            localAddr = nil,
            targetAddr = nil,
        },
    },
}
VPNDaemonService.__index = VPNDaemonService

--- VPNDaemonService:watchSetting()
--- Method
--- A method called when there is a change to the setting.
---
--- Returns:
---  * Nil
function VPNDaemonService:watchSetting(config, keys)
    self.logger.i("settings:watcher:called")

    self.logger.d("Dumping Network Config")
    self.logger.d(Util:dump(keys))
    self.logger.d(Util:dump(config:contents(keys, true)))

    self:updateNetworkState(config:contents(self.inetKey), config:contents(self.dnsKey, true))

    self.logger.d(string.format("networkState: %s", Util:dump(self.networkState)))

    self:updateState(self.networkState)
end


function VPNDaemonService:updateNetworkState(ipv4Config, dnsConfig)
    if ipv4Config[self.inetKey] ~= nil then
        self.networkState.IPv4 = {
            localAddr = ipv4Config[self.inetKey]['Addresses'][1],
            targetAddr = ipv4Config[self.inetKey]['DestAddresses'][1],
        }
    else
        self.networkState.IPv4 = {
            localAddr = nil,
            targetAddr = nil,
        }

    end
    self.networkState.DNS = nil
    self.logger.d(Util:dump(dnsConfig))
    for key, val in pairs(dnsConfig) do
        self.networkState.DNS = "[" .. table.concat(val['ServerAddresses'], ', ') .. "]"
    end
end

--- VPNDaemonService:updateState(state)
--- Method
--- Updates the display of the menu bar based on the current state.
---
--- Parameters:
---  * state - A boolean describing if it is on or off.
---
--- Returns:
---  * Nil
function VPNDaemonService:updateState(config)
    local vpn_enabled = false

    if (config.IPv4.localAddr ~= nil) then
        vpn_enabled = true
    end

    if vpn_enabled then
        self.logger.i("State: On")
        self.menuIcon:SetOn(config)
    else
        self.logger.i("State: Off")
        self.menuIcon:SetOff(config)
    end
end
