export EDITOR='nvim'
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_AVD_HOME=$HOME/.android/avd
export PATH="/var/lib/snapd/snap/bin:$PATH:$HOME/.local/bin:$HOME/go/bin:$HOME/Workspace/utils/bin"

export FZF_DEFAULT_OPTS="
--height=50%
--layout=reverse
--prompt='➤ '
--tabstop=4
"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source $HOME/.asdf/asdf.sh
