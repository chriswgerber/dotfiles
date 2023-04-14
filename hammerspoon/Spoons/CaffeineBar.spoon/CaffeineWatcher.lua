---

CaffeineWatcher = {
    watcherID = "CaffeineBarWatch"
}

function CaffeineWatcher:enable(key, fnc)
    hs.settings.watchKey(self.watcherID, key, fnc)
end

function CaffeineWatcher:disable(key)
    hs.settings.watchKey(self.watcherID, key, nil)
end
