# Dotfiles

Personal dotfiles project.

## File load order

1. `${HOME}/.zshenv`
1. `${HOME}/.zshrc`
    1. `${DOTFILES_DIR}/main.zsh`
        1. `${DOTFILES_DIR}/config.zsh`
        1. `${DOTFILES_DIR}/*/config.zsh`
        1. `${DOTFILES_DIR}/post-config.zsh`
        1. `${DOTFILES_DIR}/init.zsh`
        1. `${DOTFILES_DIR}/*/init.zsh`
        1. `${DOTFILES_DIR}/post-init.zsh`

Zsh will load `.zshenv` and then `.zshrc` at the begining of startup, depending on how they are invoked (with interactive terminal, etc.)

`.zshrc` will call `${DOTFILES_DIR}/main.zsh` and load the Azimuth library to call `-dot-main $`. This will begin sourcing files from the following format:

* Beginning with the configuration settings, `config.zsh` files should not make changes or attempt to call methods (outside of a few examples). During this step, autoloaded functions are generally not available and not all configuration is available.
  
  It will begin by sourcing the `config.zsh` in the root of the project, followed by the `config.zsh` in each subdirectory. After that config has been loaded, `post-config.zsh` will run at the end.
  1. `${DOTFILES_DIR}/config.zsh`
  1. `${DOTFILES_DIR}/*/config.zsh`
  1. `${DOTFILES_DIR}/post-config.zsh`
* Second, Azimuth will begin "initializing" the project. During this step, tools can begin initializing (moving files to `$HOME`, calling setup/login methods, starting agents, load dynamic configuration).
  
  Azimuth will start with the root `init.zsh`, traverse all subdirectories, and follow up with `post-init.zsh` in the project root. Once all of that has run, Azimuth will yield to the user for input.
  1. `${DOTFILES_DIR}/init.zsh`
  1. `${DOTFILES_DIR}/*/init.zsh`
  1. `${DOTFILES_DIR}/post-init.zsh`

## Upgrading

To upgrade Homebrew and all associated projects, call `-dot-azimuth-update`. This will:

1. Update Homebrew repos
2. Upgrade all homebrew recipes and casks
3. Pull latest repos for all ZSH plugins
4. Find and invoke upgrade files `$DOTFILES_DIR/*/upgrade.zsh`
5. Upgrade all repos in `$DOT_CACHE_DIR` not denylisted by `DOT_UPGRADE_IGNORE` in `config.zsh`
6. Recompile all `$DOTFILES_DIR/*/functions` and `$DOTFILES_DIR/*/completions` directories

## Secrets

### Create New Secret

Pull value from MacOS Keychain

All args are optional, but require "" to avoid moving them positionally if an argument
is blank.

Usage:
  1 - Service Name. Usually URL.
  2 - Account name. Usually username.
  3 - Comment. Additional filtering description.
  4 - Label

```Shell
$ keychain_set_value "URL" "USERNAME" "NOTE" "ADDL_LABEL"
```
