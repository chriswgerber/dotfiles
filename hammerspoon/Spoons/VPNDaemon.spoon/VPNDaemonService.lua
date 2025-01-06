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
    menuID       = "com.chriswgerber.VPNDaemonService",
    globalDNSKey = "State:/Network/Global/DNS",
    inetKey      = "State:/Network/Interface/ppp0/IPv4",
    dnsKey       = "Setup:/Network/Service/.*/DNS",
    settingsKeys = {},
    ---
    logName  = 'VPNDaemonService',
    logLevel = 'info',
    logger   = nil,
    ---
    menuIcon = nil,
    networkState = {
        DNS  = nil,
        IPv4 = {
            localAddr = nil,
            targetAddr = nil,
        },
    },
}
VPNDaemonService.settingsKeys = {
    VPNDaemonService.globalDNSKey,
    VPNDaemonService.inetKey,
    VPNDaemonService.dnsKey,
}
VPNDaemonService.__index = VPNDaemonService


--- VPNDaemonService:watchSetting(config, keys)
--- Method
--- A method called when there is a change to the setting.
---
--- Returns:
---  * Nil
function VPNDaemonService:watchSetting(config, keys)
    self.logger.i("settings:watcher:called")
    self.logger.d("Dumping Network Config")
    self.logger.d("Keys:", Util:dump(keys))
    self.logger.d("Contents:", Util:dump(config:contents(keys, true)))

    self:updateNetworkState(config:contents(self.inetKey), config:contents({ self.globalDNSKey, self.dnsKey }, true))

    self.logger.d("networkState:", Util:dump(self.networkState))

    self:updateState(self.networkState)
end


--- VPNDaemonService:getResolvConf
--- Method
---
--- Returns:
---  * Nil
function VPNDaemonService:getResolvConf(search)
    local servers = {}
    for line in io.lines("/etc/resolv.conf") do
        st, en = string.find(line, search)
        if st ~= nil then
            servers[string.sub(line, en+1, string.len(line))] = true
        end
    end

    return servers
end


--- VPNDaemonService:updateNetworkState(ipv4Config, dnsConfig)
--- Method
--- Updates the internally stored network state based on the provided configurations.
---
--- Returns:
---  * Nil
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
    self.networkState.DNS = VPNDaemonService:getResolvConf("nameserver ")
    self.logger.d("network DNS", Util:dump(self.networkState.DNS))
    self.logger.d("dnsConfig", Util:dump(dnsConfig))
    for key, val in pairs(dnsConfig) do
        for key2, val2 in pairs(val['ServerAddresses']) do
            self.networkState.DNS[val2] = true
        end
    end
end


--- VPNDaemonService:updateState(config)
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
