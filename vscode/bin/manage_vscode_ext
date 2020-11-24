#!/usr/bin/env python3

import hashlib
import logging
import os
import os.path
from shutil import copyfile
import subprocess
import sys


VSCODE_EXT_FILE_ENV_VAR='VSCODE_EXT_FILE'


def exec_command(cmd):
    logging.debug('Exec: {}'.format(' '.join(cmd)))
    try:
        sub_proc = subprocess.check_output(cmd, stderr=subprocess.STDOUT)

        return str(sub_proc, 'utf-8')
    except subprocess.CalledProcessError as err:

        return "Process failed. {}".format(err)


class VsCodeExtension:

    def __init__(self, name=None, version='', **kwargs):
      self.name = kwargs.get('name', name)
      self.version = kwargs.get('version', version)


class VsCodeExtensionSet(set):

    EXT_CLAZZ=VsCodeExtension

    def __init__(self, extensions=[], **kwargs):
        super()
        self.__sha__ = hashlib.sha256()
        ext = kwargs.get('extensions', extensions)
        [self.update_sha(''.join(a)) for a in ext]

        self.idx = 0
        self.__extensions__ = [self.EXT_CLAZZ(*e) for e in ext]

    @property
    def sha256(self):
        return self.__sha__.hexdigest()

    @sha256.setter
    def sha256(self, value):
        self.__sha__ = value

    def update_sha(self, value):
        self.__sha__.update(value.encode('utf-8'))

    def __contains__(self, key):

        return key in [j.name for j in self.__extensions__]

    def __iter__(self):
        return self

    def __next__(self):
        if self.idx == len(self.__extensions__):
            self.idx = 0
            raise StopIteration

        self.idx += 1

        return self.__extensions__[self.idx - 1]

    next = __next__


def install_extension(module):
    """Installs a VS Code Extension using the provided module name.

    Optionally, the module can also be a path to a vsix object.
    """
    cmd = ['code', '--force', '--install-extension', module]

    return exec_command(cmd)


def remove_extension(module):
    """Installs a VS Code Extension using the provided module name.

    Optionally, the module can also be a path to a vsix object.
    """
    cmd = ['code', '--force', '--uninstall-extension', module]

    return exec_command(cmd)


def list_extensions(**kwargs):
    """Lists currently installed VSCode extensions, with versions."""
    cmd = ['code', '--list-extensions']

    if kwargs.get('show_versions', True):
        cmd.append('--show-versions')

    return [a for a in exec_command(cmd).split('\n') if not a == '']


class VsCodeExtensionManager:

    EXT_CLAZZ=VsCodeExtensionSet

    def __init__(self, **kwargs):
        e = kwargs.get('installed_extensions', [])
        self.installed_extensions = self.EXT_CLAZZ(e)

    def install(self, name, version=None):
        """Installs a VS Code Extension, using a version if supplied."""
        ext = name
        if version:
            ext = "{}@{}".format(name, version)

        return install_extension(ext)

    def remove(self, name):
        """Installs a VS Code Extension, using a version if supplied."""

        return remove_extension(name)


def read_extension_file(file_path, clazz=VsCodeExtensionSet):
    """Read data from file descriptor as VS Code extension file.

    Passes data from the response as the first argument to the constructor of
    clazz.
    """
    logging.debug("Extension File {}".format(file_path))
    v = []
    if os.path.isfile(file_path):
        with open(file_path) as f:
            [v.append([b.rstrip() for b in line.split('@')]) for line in f]

    logging.debug(v)

    return clazz(v)


def get_extension_file(env_var=VSCODE_EXT_FILE_ENV_VAR):
    config_file = os.environ.get(VSCODE_EXT_FILE_ENV_VAR)

    logging.debug("Environ {} Value: {}".format(VSCODE_EXT_FILE_ENV_VAR, config_file))

    return os.path.abspath(config_file)


def query_yes_no(question, default="yes", force=None):
    """Ask a yes/no question via raw_input() and return their answer.

    If the user passes an invalid answer, it will continue to ask until killed.

    Args:
        question (str): The question string to ask the user.
        default (str): Default answer, yes or no. It is the presumed answer if
            the user just hits <Enter>. It must be "yes" (the default), "no" or
            None (meaning an answer is required of the user).
        force (bool): Overloads the request and returns true or the value.

    Returns:
        (bool): The "answer" return value is True for "yes" or False for "no".
    """
    if force:
        return force

    choice = None
    valid = {"yes": True, "y": True, "ye": True, "no": False, "n": False}

    if default is None:
        prompt = " [y/n] "
    elif default.lower() == "yes":
        prompt = " [Y/n] "
    elif default.lower() == "no":
        prompt = " [y/N] "
    else:
        raise ValueError("invalid default answer: '%s'" % default)

    while choice not in valid.keys():
        sys.stdout.write(question + prompt)
        choice = input().lower()
        if default is not None and choice == '':
            response = valid[default.lower()]
            break
        elif choice in valid:
            response = valid[choice]
            break
        else:
            sys.stdout.write(
                "Please respond with 'yes' or 'no' (or 'y' or 'n').\n")

    return response


def main():
    changes = False

    logging.basicConfig(level=logging.INFO, format='%(levelname)s\t%(message)s')

    manager = VsCodeExtensionManager(
        installed_extensions=[e.split('@') for e in list_extensions()],
    )
    logging.debug("Extensions (Currently Installed):")
    for ext in manager.installed_extensions:
        logging.debug('{{ Name: "{e.name}", Version: "{e.version}" }}'.format(e=ext))

    sync_extensions = read_extension_file(get_extension_file())
    logging.debug("Extensions (From File):")
    for rext in sync_extensions:
        logging.debug('{{ Name: "{e.name}", Version: "{e.version}" }}'.format(e=rext))

    for k in manager.installed_extensions:
        if k.name not in sync_extensions:
            changes = True
            if query_yes_no("Uninstall {l.name}?".format(l=k), "No"):
                logging.warning("Removing extension {ext.name} @ {ext.version}".format(ext=k))
                manager.remove(k.name)

    for j in sync_extensions:
        if j.name not in manager.installed_extensions:
            if query_yes_no("Install {ext.name} @ {ext.version}?".format(ext=j), "Yes"):
                changes = True
                logging.warning("Installing extension {ext.name} @ {ext.version}".format(ext=j))
                manager.install(j.name, j.version)

    if changes and query_yes_no("Update configuration file? {}".format(get_extension_file()), "Yes"):
        copyfile(get_extension_file(), "{}.bak".format(get_extension_file()))
        with open(get_extension_file(), "w") as fw:
            logging.info(list_extensions())
            [fw.write(line + '\n') for line in list_extensions()]


if __name__ == '__main__':
    main()
