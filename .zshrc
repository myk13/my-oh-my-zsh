# ~/.zshrc

# Oh-My-ZSH -------------------------------------------------------------------
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

DISABLE_AUTO_TITLE="true"
DISABLE_CORRECTION="true"

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh


# Clear Pre-Loaded PATH -------------------------------------------------------
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    eval `/usr/libexec/path_helper -s`
fi

# Rebuild PATH
export PATH="$HOME/.rbenv/bin"      # rbenv
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
eval "$(rbenv init -)"              # enable shims and auto-completion


# OS checks -------------------------------------------------------------------
if [[ $(uname) = 'Linux' ]]; then
    IS_LINUX=1
fi

if [[ $(uname) = 'Darwin' ]]; then
    IS_MAC=1
fi

if [[ -x `which brew` ]]; then
    HAS_BREW=1
fi

if [[ -x `which apt-get` ]]; then
    HAS_APT=1
fi

if [[ -x `which yum` ]]; then
    HAS_YUM=1
fi


# Options ---------------------------------------------------------------------
setopt auto_cd                      # cd if not a command
setopt no_beep                      # no error beeps
setopt pushd_ignore_dups            # don't push duplicates into stack
  
# History 
setopt append_history               # multiple sessions share history
setopt hist_ignore_dups             # don't write duplicates to history
setopt hist_ignore_space            # don't write commands prefixed with a space
setopt hist_reduce_blanks           # remove extra blank lines from history
setopt inc_append_history           # add commands as they are typed
    
# Completion    
setopt always_to_end                # move to end of word on completion
setopt auto_list                    # list choices on ambiguous completion
setopt auto_menu                    # show competion menu on successive tabs
setopt auto_name_dirs               # any directory match becomes it's name
setopt complete_in_word             # completion from within word
setopt correct                      # spelling correction for commands
setopt correctall                   # spelling correction for arguments
setopt auto_remove_slash            # remove trailing slash from directory completion
unsetopt menu_complete              # no auto selection for completion menu


# Aliases ---------------------------------------------------------------------
alias c=' clear'
alias zi=' $EDITOR ~/.zshrc'

# Directory Movement
alias ..=' cd ..'
alias ...=' cd ../..'
alias ....=' cd ../../..'
alias bk=' cd $OLDPWD'

alias pu=' pushd'
alias po=' popd'

alias p=" cd ~/Documents/Projects"
alias g=" cd ~/Documents/git"

alias keylog=" sudo logKextClient"

# Directory Info
alias lh=' ls -ld .*'               # list hidden files
alias ll=' ls -l'                   # list file details
alias lz=' du -sckx * | sort -nr'   # sort by size

# Tools
alias grep='grep -in'
alias hist='fc -l 1'

# Mac Only
if [[ $IS_MAC -eq 1 ]]; then
  alias o='open'                    # open Finder
  alias oo='open .'                 # open current directory in Finder
  alias sub='/opt/homebrew-cask/Caskroom/sublime-text3/3047/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
  alias freshbrew='brew outdated | while read cask; do brew upgrade $cask; done'
fi


# Remote Machines -------------------------------------------------------------
alias hades='ssh 146.185.171.159'


# Git -------------------------------------------------------------------------
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gpl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'
alias gv='git log --pretty=format:'%s' | cut -d " " -f 1 | sort | uniq -c | sort -nr'
alias gh='git hist'
alias gt='git today'


# Functions -------------------------------------------------------------------
# Display Formatted Path
path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}

# List Interface Addresses
function myip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}

# Add Spacer to the Dock
function dockspace() {
  defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}' |
  killall Dock
}


# Bind Keys -------------------------------------------------------------------
# Insert sudo at Beginning of Line
run-with-sudo () { LBUFFER="sudo $LBUFFER" }
zle -N run-with-sudo
bindkey '^S' run-with-sudo
