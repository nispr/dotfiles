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

ZSH_PROFILE_STARTUP=false # set to true to analyze startup time
if [ "$ZSH_PROFILE_STARTUP" = true ]; then zmodload zsh/zprof; fi

# PLUGINS ##############################

# fzf: General purpose command line fuzzy finder
if [ ! $(command -v fzf) ] && [ "$(uname -s)" = "Darwin" ]; then
    brew install fzf
    $(brew --prefix)/opt/fzf/install
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # 

ANTIGEN=$HOME/.antigen/
[ ! -f "$ANTIGEN.lock" ] || rm "$ANTIGEN.lock"
[ -f $ANTIGEN/antigen.zsh ] || git clone \
    https://github.com/zsh-users/antigen.git $ANTIGEN
    if [[ -f $ANTIGEN/antigen.zsh ]]; then
        source $ANTIGEN/antigen.zsh
        antigen use oh-my-zsh
        antigen bundle gitfast # git completions
        antigen bundle zsh-users/zsh-autosuggestions # fish-like completions
        antigen bundle web-search # 'google mything'

        antigen bundle thefuck # saying 'fuck' will fix your faulty input
        eval $(thefuck --alias)

        if [ ! $(command -v autojump) ]; then
            echo "Autojump needs to be installed before it can be used."
        else 
            antigen bundle autojump # 'j dir', a cd that learns. need to install via homebrew first
            [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && \
                . /opt/homebrew/etc/profile.d/autojump.sh
        fi

        antigen bundle adb # adb completions
        antigen bundle copydir # copy current directory to clipboard
        antigen bundle copyfile # copy file contents to clipboard
        antigen bundle gradle # gradle completions

  # navigate directory history using ALT-LEFT/RIGHT, 
  # file hierarchy with ALT-UP/DOWN. 
  # "Use option as meta key" must be enabled for MacOS bundled Terminal. Or just use iTerm
  antigen bundle dirhistory 

  antigen bundle Aloxaf/fzf-tab # fzf for tabs

  # syntax-highlighting makes your input interesting
  antigen bundle zsh-users/zsh-syntax-highlighting

  # Left out for performance, you need to tap homebrew/command-not-found
  # [ $(brew tap | grep 'homebrew/command-not-found' &>/dev/null) ] || \
  #   brew tap homebrew/command-not-found
  antigen bundle command-not-found # Searches for missing commands

  # Add common aliases (needs Pygments)
  [ $(command -v pygmentize) ] || pip3 install Pygments # used by common-aliases
  antigen bundle common-aliases # Adds common aliases

  antigen apply
    fi

# OHMYZSH ###############################

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="crunch-custom" # I feel like antigen setup for custom themes is slower
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
source $ZSH/oh-my-zsh.sh

# INITS #################################

# Setup for broot
if [ $(command -v broot) ]; then
    source /$HOME/.config/broot/launcher/bash/br
fi

ssh-add --apple-use-keychain ~/.ssh/id_ecdsa &>/dev/null

# NVM setup: not using it right now, costs a lot of startup time
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# FUNCTIONALITY #################

# Wrapper for NewsAPI - https://newsapi.org/ 
getnews () {
    file="/tmp/hacker-news-cached"
    do_async "Fetching latest hacker-news..." fetch_or_cached "$file" 10 fetch_hacker_news
    longestLine=$(cat "$file" | $WC_BIN -L)
    if [ $(command -v cowsay) ]; then 
        cat "$file" | cowsay -W$longestLine
    else
        cat "$file"
    fi
}

# STARTUP #################

# Display top 3 news from TechCrunch
newsapiKey=$(cat ~/.apikeys/newsapi)
getnews "hacker-news" 4 "$newsapiKey"
if [ "$ZSH_PROFILE_STARTUP" = true ]; then zprof; fi

###############################################################################

