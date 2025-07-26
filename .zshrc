# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



#      )  (        )  (           
#   ( /(  )\ )  ( /(  )\ )   (    
#   )\())(()/(  )\())(()/(   )\   
#  ((_)\  /(_))((_)\  /(_))(((_)  
#   _((_)(_))   _((_)(_))  )\___  
#  |_  / / __| | || || _ \((/ __| 
#   / /  \__ \ | __ ||   / | (__  
#  /___| |___/ |_||_||_|_\  \___| 
#                             
# #################################################
#
# Basic .zshrc that shows top3 news from techcrunch 
# and adds some essential plugins
#
# #################################################

# Disable .zshrc update checks as they take some time
DISABLE_AUTO_UPDATE=true
# Other omz improvements as per https://scottspence.com/posts/speeding-up-my-zsh-shell#oh-my-zsh-5573--20
DISABLE_MAGIC_FUNCTIONS=true
DISABLE_COMPFIX=true

# Use time ZSH_PROFILE_STARTUP=true zsh -i -c exit for profiling
if [ "$ZSH_PROFILE_STARTUP" = true ]; then zmodload zsh/zprof && echo "profiling"; fi

ssh-add --apple-use-keychain ~/.ssh/id_ecdsa &>/dev/null

# PLUGINS ##############################


# Use ssh for git
#zstyle ':antidote:gitremote' url git@github.com
export ZSH="$HOME/.oh-my-zsh"
source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
antidote load "$HOME/.zsh_plugins.txt"
source ~/.aliases 
[ $(command -v pygmentize) ] || pip3 install Pygments # used by common-aliases
#[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
eval $(thefuck --alias)
#antidote init #>/dev/null # idk, some plugins seem to need this?

# fzf: General purpose command line fuzzy finder
if [ ! $(command -v fzf) ] && [ "$(uname -s)" = "Darwin" ]; then
    brew install fzf
    $(brew --prefix)/opt/fzf/install
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # 

# OHMYZSH ###############################
ZSH_THEME="robbyrussell" # will be overridden by powerlevel10k  
#zstyle ':omz:update' mode reminder  # just remind me to update when it's time
#source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
# INITS #################################

# Setup for broot
if [ $(command -v broot) ]; then
    source /$HOME/.config/broot/launcher/bash/br
fi


# NVM setup: not using it right now, costs a lot of startup time
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if which jenv > /dev/null; then eval "$(jenv init - &>/dev/null)"; fi 

# FUNCTIONALITY #################

getnews () {
    file="/tmp/hacker-news-cached"
    fetch_or_cached "$file" 10 fetch_hacker_news >/dev/null
    longestLine=$(cat "$file" | $WC_BIN -L)
    if [ $(command -v cowsay) ]; then
        cat "$file" | cowsay -W$longestLine
    else
        cat "$file"
    fi
}

# STARTUP #################

# show hackernews
getnews 
if [ "$ZSH_PROFILE_STARTUP" = true ]; then zprof; fi

###############################################################################

if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# but override them with ours
source ~/.aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
