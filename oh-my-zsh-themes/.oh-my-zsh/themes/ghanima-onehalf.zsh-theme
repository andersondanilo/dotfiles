### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ -z "$PRIMARY_FG" ]]; then
  PRIMARY_FG=black
fi

# Used by vim plugin
MODE_INDICATOR=""

# Characters
SEGMENT_SEPARATOR=""
USEGMENT_SEPARATOR=""
RSEGMENT_SEPARATOR=""
URSEGMENT_SEPARATOR=""
PLUSMINUS="\u00b1"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
BOMB="✘"
LIGHTNING="\u26a1"
GEAR="\u2699"
DELTA="➤"
DELTA_NORMAL="◆"

SEGMENT_NUM=0
# Begin a segment
# prompt_segment bg fg content
prompt_segment() {
  local bg fg segment
  # when empty strings, these revert the custom color
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  #vary segment vertical
  [[ $((SEGMENT_NUM % 2 == 0)) -gt 0 ]] && segment=$SEGMENT_SEPARATOR || segment=$USEGMENT_SEPARATOR
  SEGMENT_NUM=$((SEGMENT_NUM+1))
  # if not the first segment and
  # current background is not request background
  # this is to make the next separator's color (a foreground color)
  # in line with the previous background
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    # start using new background
    # start using stored previous bg as new foreground
    # prefix separator
    # start using fg color
    print -n "%{%F{$CURRENT_BG}$bg%}$segment%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$BOMB%{%f%}"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$LIGHTNING%{%f%}"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}$GEAR%{%f%}"

  [[ -n "$symbols" ]] && prompt_segment '239' $PRIMARY_FG " $symbols "
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`
  local delta_context
  local colorfg="default"
  local colorbg="background"

  if [[ $KEYMAP = 'viins' ]] || [[ $KEYMAP = 'main' ]]; then
    delta_context=$DELTA
  else
    delta_context=$DELTA_NORMAL
    colorfg="#e5c07b"
  fi

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment $colorbg $colorfg "%(!.%{%F{yellow}%}.)$user@%m $delta_context"
  else
    prompt_segment $colorbg $colorfg "%(!.%{%F{red}%}.)$delta_context"
  fi
}

# Dir: current working directory
prompt_dir() {
  #local ref
  #local wd="$(pwd | sed -e "s,^$HOME,~,")"
  #local dir="$(basename $wd)"
  #local pd="$(basename $(dirname $wd))"
  #local wdl="$(printf $wd | wc -c)"
  #if [[ wdl -lt 14  ]]; then
  #  ref=" $wd "
  #else
  #  ref=" ./$pd/$dir "
  #fi
  #prompt_segment "#313640" green $ref
  local part_size=2
  local ref=$(echo $PWD | sed "s:$HOME:~:g" | sed "s:\([^/]\{1,$part_size\}\)[^/]*/:\1/:g")
  prompt_segment "#313640" green " $ref "
}

prompt_vim() {
  local fgr bk ref
  if [[ $KEYMAP = 'viins' ]] || [[ $KEYMAP = 'main' ]]; then
    bk="#61afef"
    fgr="#272c33"
    ref=" %{%B%}I %{%b%}"
  elif [[ $KEYMAP = 'vicmd' ]]; then
    bk="#e5c07b"
    fgr="#272c33"
    ref=" %{%B%}N %{%b%}"
  elif [[ $KEYMAP = 'viopp' ]]; then
    bk="#56b6c2"
    fgr="#272c33"
    ref=" %{%B%}O %{%b%}"
  else
    bk=red
    ref=" $KEYMAP "
  fi
  prompt_segment $bk $fgr $ref
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%} "
  CURRENT_BG=''
}

# start the right prompt
prompt_right_start() {
  print -n "%{%k%F{$1}%}$RSEGMENT_SEPARATOR"
}
# Git: branch/detached head, dirty status
prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi

  local color ref
  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  ref="$vcs_info_msg_0_"
  fgcolor=$PRIMARY_FG
  if [[ -n "$ref" ]]; then
    local mode dirty staged_count
    ref="${ref}"
    dirty=$(parse_git_dirty)
    unstaged_count="$(git diff --name-only | wc -l)"
    staged_count="$(git diff --name-only --cached | wc -l)"

    color="#5d677a"
    fgcolor=white

    if [[ -n $dirty ]]; then
      color="#e5c07b"
      fgcolor=$PRIMARY_FG
    fi

    if [[ "$unstaged_count" != "0" ]]; then
      ref="${ref} $PLUSMINUS"
    fi

    if [[ "$staged_count" != "0" ]]; then
      ref="${ref} ●"
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi
    ref="${ref}${mode}"

    if [[ "${ref/.../}" == "$ref" ]]; then
      ref="$ref $BRANCH"
    else
      ref="${ref/.../} $DETACHED"
    fi
    prompt_right_start $color
    print -n "%{%K{$color}%F{$fgcolor}%} $ref "
  fi
}

prompt_right_end() {
  print -n "%{%k%f%}"
  CURRENT_BG=''
}

prompt_top_left() {
  CURRENT_BG='NONE'
  prompt_vim
  prompt_dir
  prompt_git
  prompt_end
}

prompt_bottom_left() {
  CURRENT_BG='NONE'
  prompt_context
  prompt_end
}

prompt_bottom_right() {
  RETVAL=$?
  CURRENT_BG='NONE'
  prompt_status
  prompt_right_end
}

prompt_ghanima_precmd() {
  vcs_info
  # Make sure KEYMAP is initial set to insert
  # otherwise this is empty
  KEYMAP="viins"
  TOP_PROMPT='%{%f%b%k%}$(prompt_top_left)'
  #PROMPT=$TOP_PROMPT$'\n''$(prompt_bottom_left)'
  PROMPT=$TOP_PROMPT'$(prompt_bottom_left)'

  RPROMPT='%{%f%b%k%}$(prompt_bottom_right)'
  #RPROMPT=''
}

prompt_ghanima_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  prompt_opts=(cr subst percent)

  add-zsh-hook precmd prompt_ghanima_precmd

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' check-for-changes false
  zstyle ':vcs_info:git*' formats '%b'
  zstyle ':vcs_info:git*' actionformats '%b (%a)'
}

prompt_ghanima_setup "$@"

# vim:ft=zsh
