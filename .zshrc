# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme before sourcing oh-my-zsh
ZSH_THEME="avit"

source $ZSH/oh-my-zsh.sh

# User configuration
# auto suggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"

# nvm config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Choose ONE z implementation:
# Option 1: If using traditional z
. /usr/local/etc/profile.d/z.sh

# Option 2: If using zsh-z plugin (comment out Option 1 if using this)
# This should be handled by the plugins section above

#-------- Global Alias {{{
globalias() {
    if [[ $LBUFFER =~ '[a-zA-Z0-9]+$' ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle self-insert
}
zle -N globalias
bindkey " " globalias                 # space key to expand globalalias
bindkey "^[[Z" magic-space            # shift-tab to bypass completion
bindkey -M isearch " " magic-space    # normal space during searches
#}}}

# Turn off power status when using spaceship prompt
export SPACESHIP_BATTERY_SHOW=false
export PATH=~/.npm-global/bin:$PATH
