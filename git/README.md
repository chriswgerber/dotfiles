# Git Init Template

Base `.git/` directory for `git init`.

## Installation

### Set init-template as git init template directory

To install repo and set as the template directory for `.git/`, run:

```
mkdir -p ~/.git && git clone git@bitbucket.org:periscopedev/git-init-template.git ~/.git/init-template
git config --global init.templatedir '~/.git/init-template/template'
```

On the first `git commit`, it will install the pre-commit python package, copy
the sample `.pre-commit-config.yaml` template from `template/files/` into the
base directory for a git repo, and then update pre-commit to use the installed
hooks.

#### .pre-commit-config.yaml

By default, `.pre-commit-config.yaml` is not committed to the repo is added to
the gitignore. This is purposeful: Some people may choose to only use it locally
and do not want to commit the file to the repo.

To begin committing the file and changes to the repo (and require all users with
pre-commit installed to run the hooks), delete `/.pre-commit-config.yaml` from
`.git/info/exclude` or run `sed -i '' '/.pre-commit-config.yaml/d' .git/info/exclude`.

### Merge template with current git repo

To update the repo of the current project you're in to the current template,
overriding files that currently exist with new files, run:

```
$(git config --path --get init.templatedir)/../scripts/update_repo.sh
```

# License and Maintainer

Maintainer:: Chris Gerber (<cgerber@periscope.com>)

License:: All rights reserved
