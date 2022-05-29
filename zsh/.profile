export EDITOR='nvim'
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_AVD_HOME=$HOME/.android/avd
export PATH="/var/lib/snapd/snap/bin:$PATH:$HOME/.local/bin:$HOME/go/bin:$HOME/Workspace/tools/bin"

export FZF_DEFAULT_OPTS="
--height=50%
--layout=reverse
--prompt='➤ '
--tabstop=4
--color=dark
--color=fg:-1,bg:-1,hl:#98c379,fg+:#ffffff,bg+:#313640,hl+:#A8E989
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
"

source $HOME/.asdf/asdf.sh

alias sd="NEW_DIR=\$(fd --type directory | fzf --bind 'tab:replace-query+reload(fd --type directory --search-path {})') && cd \$NEW_DIR"
