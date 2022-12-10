###############################################################################
# PURPOSE: Configuration for the zsh shell prompt
###############################################################################

autoload -Uz vcs_info      # for prompt somehow
autoload -U colors         # zsh coloring, different from bash
colors

if [[ -e $DOTFILES/source/git-prompt.sh ]]; then
  source $DOTFILES/source/git-prompt.sh
fi

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=2

# default color for the hostname:
HOST_COLOR="green"
#if [[ -n "$SSH_CLIENT" ]]; then
  #HOST_COLOR="yellow"
#fi

# Setup the prompt appearance
zstyle ':vcs_info:*'              enable            git svn svk cvs hg
zstyle ':vcs_info:*'              actionformats    ' (%F{red}%s%f %F{cyan}%b%f%F{yellow}|%F{1}%a%F{cyan} %B%F{yellow}%c%F{red}%u%%b)'
zstyle ':vcs_info:*'              formats          ' (%F{red}%s%f %F{cyan}%b%f)'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat     '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*'              check-for-changes true
zstyle ':vcs_info:*'              get-revision      true

precmd() {
  psvar=()
  vcs_info
  [[ -n $vcs_info_msg_0_ ]] && psvar[1]=" $vcs_info_msg_0_"
}

PROMPT=$'%F{white}[%n@%f%F{$HOST_COLOR}%m%f %c]${vcs_info_msg_0_}%b%F%f%# '
