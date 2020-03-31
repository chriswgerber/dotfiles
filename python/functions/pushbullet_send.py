#!/usr/bin/env python3

import json
import logging
import os
import sys
import urllib.error
import urllib.parse
import urllib.request


PUSHBULLET_URL = 'https://api.pushbullet.com/v2'

handlers = []

FILE_HDLR = logging.FileHandler(filename=os.environ.get('PUSHBULLET_LOG_FILE'))
handlers.append(FILE_HDLR)
# handlers.append(logging.StreamHandler(sys.stdout))
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s\t%(funcName)s\t%(levelname)s\t%(message)s',
    handlers=handlers,
)

LOGGER = logging.getLogger()


def send_push(title=None, message=None):
    """Send a push."""
    url = "{}/{}".format(PUSHBULLET_URL, 'pushes')
    headers = {
        'Access-Token': os.environ.get('PUSHBULLET_API_KEY'),
        'Content-Type': 'application/json',
    }
    data = json.dumps({
        'email': os.environ.get('PUSHBULLET_EMAIL'),
        'type': 'note',
        'title': title,
        'body': message,
    })

    LOGGER.info('data: %s', data)

    req = urllib.request.Request(
        url,
        data=data.encode('ascii'),
        headers=headers
    )

    try:
        resp = urllib.request.urlopen(req)
        LOGGER.info('success: %s', resp.read().decode("utf-8"))
    except urllib.error.HTTPError as err:
        LOGGER.error('fail: %s', err.read().decode("utf-8"))

    return None


if __name__ == "__main__":
    send_push(sys.argv[1], sys.argv[2])
