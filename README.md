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
- pip install i3ipc

### alacritty

- install the fonts

### polybar

- install the fonts

### gtk themes
Themes generated with oomox, after the stow we can also create a snap to also apply this theme on snapcraft apps
- https://gist.github.com/andersondanilo/85b5f470d294ec360d3498a06e534158


## Post Setup
- Configure PulseEffects with Pipeware (replacement of pulseaudio) (https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Extreme)

