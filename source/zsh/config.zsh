###############################################################################
# PURPOSE: For zsh configuration settings
###############################################################################

HISTSIZE=200000
SAVEHIST=200000
HISTFILE=~/.zhistory

export HISTCONTROL="erasedups:ignoreboth"   # Duplicates & Commands starting with spaces not included in history
export HISTIGNORE="exit:pwd:history"        # Specify which commands to ignore in history

setopt prompt_subst               # needed for prompt custimization below
setopt append_history             # append history, not replace
setopt no_hist_beep               # don't beep on failed history access
setopt share_history              # ??
