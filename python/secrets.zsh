# Python

# Pushbullet
function export_pushbullet_key() {
  local api_url='https://api.pushbullet.com/'

  export PUSHBULLET_API_KEY="$(keychain_get_value ${api_url} ${EMAIL_ADDRESS})"
}
# export_pushbullet_key
