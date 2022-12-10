###############################################################################
# PURPOSE: For bash configuration settings
###############################################################################

# SET OPTIONS AND PREFERENCES
shopt -s histappend                         # Append to history instead

export HISTCONTROL="erasedups:ignoreboth"   # Duplicates & Commands starting with spaces not included in history
export HISTFILESIZE=5000000
export HISTSIZE=1000000
export HISTIGNORE="exit:pwd:history"        # Specifies commands to exclude from history

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PS1="\[\e[36;1m\]\u[\w]: \[\e[0m\]"  # Prompt?
