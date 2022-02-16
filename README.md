## VIM, Python 3 and MacOS

### Remove old VIM and MacVim

```
brew remove vim
brew remove macvim
brew cleanup
brew install vim --with-python3
brew install macvim
```

### Link MacVim to Applications 

Link to applications. Will need to change when MacVim is updated.
`ln -s /usr/local/Cellar/macvim/8.0-130/MacVim.app/ /Applications/MacVim.app`

Launch with `mvim foo.txt` from cmdline


### Create symlink to vimrc

```bash
ln -s /Users/daleh/Documents/GitHub/dotfiles/vimrc /Users/daleh/.vimrc
```

By linking, when vimrc is updated the changes can be committed to git, or pulled from git if I change elsewhere.

On first launch, Plug will be installed, as well as the plugins configured.
