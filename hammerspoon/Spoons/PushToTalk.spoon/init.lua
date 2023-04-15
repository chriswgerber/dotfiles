--- === PushToTalk ===
---
--- Implements push-to-talk and push-to-mute functionality with configured key.
--- I implemented this after reading Gitlab remote handbook https://about.gitlab.com/handbook/communication/ about Shush utility.
---
--- My workflow:
---
--- When Zoom starts, PushToTalk automatically changes mic state from `default`
--- to `push-to-talk`, so I need to press key to unmute myself and speak.
--- If I need to actively chat in group meeting or it's one-on-one meeting,
--- I'm switching to `push-to-mute` state, so mic will be unmute by default and key mutes it.
---
--- PushToTalk has menubar with colorful icons so you can easily see current mic state.
---
--- Sample config: `spoon.SpoonInstall:andUse("PushToTalk", {start = true, config = { app_switcher = { ['zoom.us'] = 'push-to-talk' }}})`
--- and separate hotkey to toggle states with lambda function `function() spoon.PushToTalk.toggleStates({'push-to-talk', 'release-to-talk'}) end`
---
--- Check out my config: https://github.com/skrypka/hammerspoon_config/blob/master/init.lua

--- Menubar Icons
local ICONS <const> = {
    speak = hs.spoons.resourcePath("speak.pdf"),
    muted = hs.spoons.resourcePath("muted.pdf"),
    record = hs.spoons.resourcePath("record.pdf"),
    unrecord = hs.spoons.resourcePath("unrecord.pdf"),
}

--- States
local STATES <const> = {
    mute = 'mute',
    unmute = 'unmute',
    pushToTalk = 'push-to-talk',
    releaseToTakl = 'release-to-talk',
}

local obj = {
    -- Metadata
    name     = "PushToTalk",
    version  = "0.1",
    author   = "Roman Khomenko <roman.dowakin@gmail.com>",
    homepage = "https://github.com/Hammerspoon/Spoons",
    license  = "MIT - https://opensource.org/licenses/MIT",
    menuID   = "com.chriswgerber.PushToTalk",
    -- Settings
    hotkey = "ctrl",
    defaultState = STATES.unmute,
    pushed = false,

    --- PushToTalk.app_switcher
    --- Variable
    --- Takes mapping from application name to mic state.
    --- For example this `{ ['zoom.us'] = 'push-to-talk' }` will switch mic to `push-to-talk` state when Zoom app starts.
    app_switcher = {},

    --- PushToTalk.detect_on_start
    --- Variable
    --- Check running applications when starting PushToTalk.
    --- Defaults to false for backwards compatibility. With this disabled, PushToTalk will only change state when applications are launched or quit while PushToTalk is already active. Enable this to look through list of running applications when PushToTalk is started. If multiple apps defined in app_switcher are running, it will set state to the first one it encounters.
    detect_on_start = true,
}

obj.__index = obj

--- Menu table
obj.menutable = {
    {
        id = STATES.unmute,
        title = "Unmuted",
        state = "off",
        onStateImage = nil,
        offStateImage = ICONS.speak,
        fn = function() obj.setState(STATES.unmute) end,
    },
    {
        id = STATES.mute,
        title = "Muted",
        state = "off",
        onStateImage = nil,
        offStateImage = ICONS.muted,
        fn = function() obj.setState(STATES.mute) end,
    },
    {
        id = STATES.pushToTalk,
        title = string.format("Push-to-talk (%s)", obj.hotkey),
        state = "off",
        onStateImage = nil,
        offStateImage = ICONS.record,
        fn = function() obj.setState(STATES.pushToTalk) end,
    },
    {
        id = STATES.releaseToTalk,
        title = string.format("Release-to-talk (%s)", obj.hotkey),
        state = "off",
        onStateImage = nil,
        offStateImage = ICONS.unrecord,
        fn = function() obj.setState(STATES.releaseToTalk) end,
    },
}


local function setActiveOption(active)
    for i, v in ipairs(obj.menutable) do
        if v.id == active then
            v.state = "on"
        else
            v.state = "off"
        end
        table[i] = v
    end

    return obj.menutable
end

local function showState()
    local device = hs.audiodevice.defaultInputDevice()
    local muted = false

    obj.menubar:setMenu(setActiveOption(obj.state))

    if obj.state == STATES.unmute then
        obj.menubar:setIcon(ICONS.speak)
    elseif obj.state == STATES.mute then
        obj.menubar:setIcon(ICONS.muted)
        muted = true
    elseif obj.state == STATES.pushToTalk then
        if obj.pushed then
            obj.menubar:setIcon(ICONS.record, false)
        else
            obj.menubar:setIcon(ICONS.unrecord)
            muted = true
        end
    elseif obj.state == STATES.releaseToTalk then
        if obj.pushed then
            obj.menubar:setIcon(ICONS.unrecord)
            muted = true
        else
            obj.menubar:setIcon(ICONS.record, false)
        end
    end

    device:setMuted(muted)
end

function obj.setState(s)
    obj.state = s
    showState()
end

local function appWatcher(appName, eventType, appObject)
    local new_app_state = obj.app_switcher[appName];
    if (new_app_state) then
        if (eventType == hs.application.watcher.launching) then
            obj.setState(new_app_state)
        elseif (eventType == hs.application.watcher.terminated) then
            obj.setState(obj.defaultState)
        end
    end
end

local function eventTapWatcher(event)
    device = hs.audiodevice.defaultInputDevice()
    print(event:getFlags()[obj.hotkey])
    if event:getFlags()[obj.hotkey] then
        obj.pushed = true
    else
        obj.pushed = false
    end
    showState()
end

local function initialState()
    local apps = hs.application.runningApplications()

    for i, app in pairs(apps) do
        for name, state in pairs(obj.app_switcher) do
            if app:name() == name then
                return state
            end
        end
    end

    return obj.defaultState
end

--- PushToTalk::bindHotKeys()
--- Method
--- Bind Hotkeys.
function obj:bindHotKeys()
end

--- PushToTalk:init()
--- Method
--- Initial setup.
function obj:init()
    obj.appWatcher = hs.application.watcher.new(appWatcher)
    obj.eventTapWatcher = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, eventTapWatcher)
    obj.menubar = hs.menubar.new(true, obj.menuID)
end

--- PushToTalk:start()
--- Method
--- Starts menu and key watcher
function obj:start()
    obj.appWatcher:start()
    ---
    obj.eventTapWatcher:start()
    ---
    obj.menubar:setTitle("Mic")
    obj.menubar:setMenu(obj.menutable)
    ---
    if obj.detect_on_start then obj.state = initialState() end
    obj.setState(obj.state)
end

--- PushToTalk:stop()
--- Method
--- Stops PushToTalk
function obj:stop()
    if obj.appWatcher then obj.appWatcher:stop() end
    if obj.eventTapWatcher then obj.eventTapWatcher:stop() end
    if obj.menubar then obj.menubar:delete() end
end

--- PushToTalk:toggleStates()
--- Method
--- Cycle states in order
---
--- Parameters:
---  * states - A array of states to toggle. For example: `{'push-to-talk', 'release-to-talk'}`
function obj:toggleStates(states)
    new_state = states[1]
    for i, v in pairs(states) do
        if v == obj.state then
            new_state = states[(i % #states) + 1]
        end
    end
    obj.setState(new_state)
end

return obj
