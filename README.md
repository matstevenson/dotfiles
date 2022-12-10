# Dotfiles

My personal dotfile setup.

## Installation

Requires Rake

```sh
$ git clone https://github.com/matstevenson/dotfiles ~/dotfiles
$ cd ~/dotfiles
$ rake install
```

## What it does

### Symlinking
Any files at the root level that end in `.symlink` will be symlinked to the home directory. So will any files in `private/` that end in `.symlink`.

### zsh and bash
The .zshrc will automatically source (include):
- files in `source/zsh/`
- files in `source/system/`

The .bashrc will automatically source (include):
- files in `source/bash/`
- files in `source/system/`

allowing for shared scripts under `source/system/`.

The same rules are applied by .bashrc and .zshrc for any corresponding files under `private/source/`.

### git
The `gitconfig` file includes `~/.gitconfig.local` if it exists, allowing for a global `gitconfig` that isn't committed.

## Note on Private and Local Files
The directory `private` is gitignored, and can be used for files local to that system, or that you don't want committed.

## Uninstalling
The command `rake uninstall` will remove any symlinks in the home directory that have a corresponding `.symlink` file. It will also reinstate any `.backup` files that were created during installation.


