# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

source $ZSH/oh-my-zsh.sh

# User configuration

# auto suggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"
ZSH_THEME="avit"

# nvm config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# z jump integration
. /usr/local/etc/profile.d/z.sh
eval "$(zsh-z --init)"

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
# bindkey "^ " magic-space            # control-space to bypass completion
bindkey "^[[Z" magic-space            # shift-tab to bypass completion
bindkey -M isearch " " magic-space    # normal space during searches
#}}}

# Turn off power status when using spaceship prompt
export SPACESHIP_BATTERY_SHOW=falseexport PATH=~/.npm-global/bin:$PATH
