# My personal dotfiles

## How to use
Use the stow program to create the symbolic links, like this:

```bash
$ stow -t $HOME vim
```

## Manual actions

### vim

- Install Vundle
- Install ``powerline-status`` (can be installed with pip)
- Make ``CommandT`` extension
```bash
$ cd ~/.vim/bundle/command-t/ruby/command-t/ext/command-t && ruby extconf.rb && make
```
- Make ``vimproc`` extension
```bash
$ cd ~/.vim/bundle/vimproc.vim && make
```

### i3

- install the fonts

### alacritty

- install the fonts

### polybar

- install the fonts
