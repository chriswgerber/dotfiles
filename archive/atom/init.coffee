# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
if atom.config.get('sync-settings.personalAccessToken') == '' and process.env.GITHUB_GIST_KEY
  atom.config.set('sync-settings.personalAccessToken', process.env.GITHUB_GIST_KEY)

# Disable TLS because node sucks
process.env.NODE_TLS_REJECT_UNAUTHORIZED = 0
