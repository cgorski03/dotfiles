# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme before sourcing oh-my-zsh
ZSH_THEME="avit"

#Vcpkg config
export VCPKG_ROOT=/Users/colingorski/dev/vcpkg

source $ZSH/oh-my-zsh.sh
alias ll='lsd -l --date "+%I:%M %p %m/%d/%y" --color=auto'
alias la='lsd -la --date "+%I:%M %p %m/%d/%y" --color=auto'
# User configuration
# auto suggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"

# nvm config
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Zoxide
eval "$(zoxide init zsh)"

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
git() {
    local original_subcommand="$1"
    local corrected_subcommand="$1"
    # Capture all arguments from the second one onwards
    local rest_args=("${@:2}")

    case "$original_subcommand" in
        # status
        statu|sattus|statuss|staus|stauts|statsu|sattsu|satatus)
            corrected_subcommand="status"
            ;;
        # commit
        comit|commmit|commiit|cmmit|commt)
            corrected_subcommand="commit"
            ;;
        # add
        addd|ad) # 'ad' might be too short/ambiguous, use with care or remove
            corrected_subcommand="add"
            ;;
        # push
        psuh|psh|pusj)
            corrected_subcommand="push"
            ;;
        # pull
        pll|pul|pull)
            corrected_subcommand="pull"
            ;;
        # branch
        brnach|branc|barnch|brnch)
            corrected_subcommand="branch"
            ;;
        # checkout
        chekcout|checout|chcekout|checkou|co)
            # Note: 'co' is a very common alias for checkout.
            # If you use 'alias co=git checkout', this case might be redundant
            # or you might want to handle it differently.
            corrected_subcommand="checkout"
            ;;
        # diff
        dif|dff)
            corrected_subcommand="diff"
            ;;
        # log
        lg|lgo)
            corrected_subcommand="log"
            ;;
        # You can add many more common typos here
        # Example:
        # rebase)
        #   rebse|rebas)
        #     corrected_subcommand="rebase"
        #     ;;
        *)
            # No correction needed for the subcommand itself, or it's not one we're targeting
            ;;
    esac

    if [[ "$original_subcommand" != "$corrected_subcommand" ]]; then
        # Notify the user about the correction (optional, but helpful)
        echo "zsh: correcting git typo '$original_subcommand' to '$corrected_subcommand'" >&2
    fi

    # Execute the real git command with the (potentially corrected) subcommand
    # and the rest of the arguments
    command git "$corrected_subcommand" "${rest_args[@]}"
}

# Turn off power status when using spaceship prompt
export SPACESHIP_BATTERY_SHOW=false
export PATH=~/.npm-global/bin:$PATH