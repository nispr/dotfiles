. "$HOME/.cargo/env"

pushd . > '/dev/null';
SRC="${(%):-%N}"
SCRIPT_PATH="${SRC:-$0}";

while [ -h "$SCRIPT_PATH" ];
do
    cd "$( dirname -- "$SCRIPT_PATH"; )";
    SCRIPT_PATH="$( readlink -f -- "$SCRIPT_PATH"; )";
done

cd "$( dirname -- "$SCRIPT_PATH"; )" > '/dev/null';
SCRIPT_PATH="$( pwd; )";
popd  > '/dev/null';


# EXPORTS ##########################

WC_BIN=wc
DATE_BIN=date
if [ "$(uname -s)" = "Darwin" ]; then
    WC_BIN=gwc
    DATE_BIN=gdate
fi

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'
export NVM_DIR="$HOME/.nvm"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export ANDROID_HOME="/Users/$USER/Library/Android/sdk"
export ANDROID_SDK="$ANDROID_HOME"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_351.jdk/Contents/Home"
# export JAVA_HOME="/opt/homebrew/opt/openjdk"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
export FZF_DEFAULT_COMMAND='find .'

export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
export PATH="$PATH:/opt/homebrew/opt/openjdk/bin"
export PATH="$PATH:~/.cargo/bin"
export PATH="$PATH:~/scripts"
export PATH="$PATH:$GEM_HOME/bin"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
######### functionality 

source ~/.aliases

#########

# Usage: do_async command
do_async () {
    msg=$1
    if [ -z $msg ]; then msg="Fetching..."; fi
    set +m
    { zsh -c "$(printf ' %q' "${@:2}")" & } &>/dev/null

    pid=$!

    spin[1]="-"
    spin[2]="\\"
    spin[3]="|"
    spin[4]="/"

    while kill -0 $pid 2>/dev/null; do
        for i in "${spin[@]}"
        do
            echo -ne "\r--$i $msg...\r"
            sleep 0.1
        done
    done
    set -m
}

fetch_or_cached () {
    cacheFile=$1
    mkdir -p $(dirname "$cacheFile")
    now=$($DATE_BIN +%s)
    cached=$($DATE_BIN +%s -r "$cacheFile" 2>/dev/null)
    cacheMaxAge=$2
    cmd=$3
    age=$cacheMaxAge
    if [ -f "$cacheFile" ]; then
        age=$(expr $(expr $now - $cached) / 60)
    fi
    if [ $age -ge $cacheMaxAge ]; then
        zsh -c "$(printf ' %q' "${@:3}")" > $cacheFile 
    fi

    cat "$cacheFile"
}

source "$SCRIPT_PATH/fetch_hacker_news.sh"
