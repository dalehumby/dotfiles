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
