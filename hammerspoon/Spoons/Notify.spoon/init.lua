
Notify = {
    name     = "Notify",
    version  = "1.0",
    author   = "chriswgerber <chriswgerber@gmail.com>",
    homepage = "https://www.chriswgerber.com",
    license  = "MIT - https://opensource.org/licenses/MIT",
    logger   = hs.logger.new('Notify', 'debug'),
    hostname = hs.host.names()[1],
}
Notify.notification = {
    title    = "Azimuth",
    subtitle = "Notification",
}
Notify.recipient = "chriswgerber@gmail.com"
Notify.data      = "Ping from computer"

function Notify:sendIMessage(params)
    -- data
    if not params.data then
        params.data = self.data
    end
    -- recipient
    if not params.recipient then
        params.recipient = self.recipient
    end
    ---
    params.message = string.format(
        "Source: %s\nHost: %s\nMessage: %s",
        hs.host.localizedName(),
        self.hostname,
        params.data
    )
    self.logger.f("event:params: %s", hs.inspect(params))

    hs.messages.iMessage(params.recipient, params.message)
end

function Notify:showNotification(params)
    -- data
    if not params.data then
        params.data = self.data
    end
    -- title
    if not params.title then
        params.title = self.notification.title
    end
    -- subtitle
    if not params.subtitle then
        params.subtitle = self.notification.subtitle
    end
    ---
    self.logger.f("event:params: %s", hs.inspect(params))

    hs.notify.new(nil, {
        title = params.title,
        subTitle = params.subtitle,
        informativeText = params.data,
        autoWithdraw = false,
    }):send()
end

function Notify:handleEvent(params)
    self.logger.f("handleEvent:params: received %s", hs.inspect(params))
    -- Deploy message based on requested type
    if params.msgType == "imessage" then
        self:sendIMessage(params)
    else
        self:showNotification(params)
    end
end

--- Notify:init()
--- Method
--- Initialize the spoon.
---
--- Returns:
---  * Nil
function Notify:init()
end

--- Notify:start()
--- Method
--- Start the spoon.
---
--- Returns:
---  * Nil
function Notify:start()
    hs.urlevent.bind("notify", function(eventName, params) self:handleEvent(params) end)
end

--- CaffeineBar:stop()
--- Method
--- Stop the spoon.
---
--- Returns:
---  * Nil
function Notify:stop()
end

return Notify
