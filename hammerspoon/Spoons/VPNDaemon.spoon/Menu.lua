--- MenuItem class
dofile(hs.spoons.resourcePath("Util.lua"))


MenuItem = {
    menuBar = nil,
    menuID  = "com.chriswgerber.VPNDaemon",
    logger = hs.logger.new("VPNDaemonMenuItem", "info"),
    states = {
        ON = "on",
        OFF = "off",
    },
    icons = {
        on = hs.spoons.resourcePath("Resources/VPN-On.svg"),
        off = hs.spoons.resourcePath("Resources/VPN-Off.svg"),
    },
    currentState = {
        netState = nil,
        localAddr = nil,
        destAddr = nil,
        dns = nil,
    },
}


function MenuItem:SetOn(config)
    self:SetIcon(MenuItem.states.ON)

    self.currentState.netState = "Connected"
    self.currentState.localAddr = config.IPv4.localAddr
    self.currentState.destAddr = config.IPv4.targetAddr
    self.currentState.dns = config.DNS

    self.menuBar:setMenu(function() return self:FormatMenu(); end)
end


function MenuItem:SetOff(config)
    self:SetIcon(MenuItem.states.OFF)
    self.currentState.netState = "Disconnected"
    self.currentState.localAddr = ""
    self.currentState.destAddr = ""
    self.currentState.dns = config.DNS

    self.menuBar:setMenu(function() return self:FormatMenu() end)
end


function MenuItem:FormatMenu()
    local menuConfig = {
        disableMenus = false,
        titleStyle = "font: bold small-caps 1.1em \'System Font\'",
        bodyStyle = "font: 1em \'System Font\'",
        indent = 1,
    }
    local retval = {}

    --- VPN Status
    table.insert(retval, {
        title = MenuItem:formatStyledText('<span style="%s">VPN Status</span>', menuConfig.titleStyle),
        disabled = menuConfig.disableMenus
    })
    table.insert(retval, {
        title = MenuItem:formatStyledText(
            '<span style="%s">%s</span>',
            menuConfig.bodyStyle,
            self.currentState.netState
        ),
        indent = menuConfig.indent,
        disabled = menuConfig.disableMenus
    })
    table.insert(retval, { title = "-" })

    --- DNS Addresses
    table.insert(retval, {
        title = MenuItem:formatStyledText('<span style="%s">DNS Addresses</span>', menuConfig.titleStyle),
        disabled = menuConfig.disableMenus
    })
    for name, exists in pairs(self.currentState.dns) do
        table.insert(retval, {
            title = MenuItem:formatStyledText('<span style="%s">- %s</span>', menuConfig.bodyStyle, name),
            indent = menuConfig.indent,
            disabled = menuConfig.disableMenus
        })
    end
    table.insert(retval, { title = "-" })

    --- Local IP Address
    table.insert(retval, {
        title = MenuItem:formatStyledText('<span style="%s">Local Address</span>', menuConfig.titleStyle),
        disabled = menuConfig.disableMenus
    })
    if self.currentState.localAddr ~= "" then
        table.insert(retval, {
            title = MenuItem:formatStyledText('<span style="%s">%s</span>', menuConfig.bodyStyle, self.currentState.localAddr),
            indent = menuConfig.indent,
            disabled = menuConfig.disableMenus
        })
    end
    table.insert(retval, { title = "-" })

    --- Remote IP Address
    table.insert(retval, {
        title = MenuItem:formatStyledText('<span style="%s">Remote Address</span>', menuConfig.titleStyle),
        disabled = menuConfig.disableMenus
    })
    if self.currentState.destAddr ~= "" then
        table.insert(retval, {
            title = MenuItem:formatStyledText('<span style="%s">%s</span>', menuConfig.bodyStyle, self.currentState.destAddr),
            indent = menuConfig.indent,
            disabled = menuConfig.disableMenus
        })
    end
    table.insert(retval, { title = "-" })

    self.logger.d(Util:dump(retval))

    return retval
end


function MenuItem:formatStyledText(format, ...)
    local arg = {...}
    self.logger.d(Util:dump(arg))

    return hs.styledtext.getStyledTextFromData(
        string.format(format, table.unpack(arg))
    )
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
    --- :popupMenu(point[, darkMode]) -> menubaritem
    return o
end
