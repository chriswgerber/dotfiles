--- MenuItem class

MenuItem = {
    menuBar = nil,
    menuID  = "com.chriswgerber.VPNDaemon",
    states = {
        ON = "on",
        OFF = "off",
    },
    icons = {
        on = hs.spoons.resourcePath("Resources/VPN-On.svg"),
        off = hs.spoons.resourcePath("Resources/VPN-Off.svg"),
    },
    tooltipFormat = [[
VPN: %s

Local Address: %s
Target Address: %s
DNS Addresses: %s]],
}

function MenuItem:SetOn(config)
    self:SetIcon(MenuItem.states.ON)
    local tooltip = self:FormatTooltip(
        "Connected",
        config.IPv4.localAddr,
        config.IPv4.targetAddr,
        config.DNS
    )
    self.menuBar:setTooltip(tooltip)
end

function MenuItem:SetOff(config)
    self:SetIcon(MenuItem.states.OFF)
    local tooltip = self:FormatTooltip("Disconnected", "N/A", "N/A", config.DNS)
    self.menuBar:setTooltip(tooltip)
end

function MenuItem:FormatTooltip(netState, localAddr, destAddr, dns)
    return string.format(self.tooltipFormat, netState, localAddr, destAddr, dns)
end

function MenuItem:SetIcon(iconState)
    self.menuBar:setIcon(self.icons[iconState])
end

function MenuItem:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.menuBar = hs.menubar.new(true, o.menuID)
    o.menuBar:imagePosition(hs.menubar.imagePositions.imageOnly)

    return o
end
