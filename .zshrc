# ~/.zshrc

# ---------------------------------------------------------
# oh-my-zsh
# ---------------------------------------------------------
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

DISABLE_AUTO_TITLE="true"
DISABLE_CORRECTION="true"

# plugins -------------------
plugins=( git )

source $ZSH/oh-my-zsh.sh


# ---------------------------------------------------------
# OS checks (ls
# ---------------------------------------------------------
if [[ $(uname) = 'Linux' ]]; then
    IS_LINUX=1
fi
if [[ $(uname) = 'Darwin' ]]; then
    IS_MAC=1
fi
if [[  ]]; then
    HAS_BREW=1
fi
if [[ -x `which apt-get` ]]; then
    HAS_APT=1
fi


# ---------------------------------------------------------
# options
# ---------------------------------------------------------
setopt auto_cd              # cd if not a command
setopt no_beep              # no error beeps
setopt pushd_ignore_dups    # don't push duplicates into stack

# history--------------------
setopt append_history       # multiple sessions share history
setopt hist_ignore_dups     # don't write duplicates to history
setopt hist_ignore_space    # don't write commands prefixed with a space to history
setopt hist_reduce_blanks   # remove extra blank lines from history
setopt inc_append_history   # add commands as they are typed

# completion ----------------
setopt always_to_end        # move to end of word on completion
setopt auto_list			# list choices on ambiguous completion
setopt auto_menu            # show competion menu on successive tabs
setopt auto_name_dirs       # any match of absolute name of directory becomes a name for that directory
setopt complete_in_word     # completion from within word
setopt correct 	            # spelling correction for commands
setopt correctall           # spelling correction for arguments
setopt auto_remove_slash	# remove trailing slash from directory completion
unsetopt menu_complete      # no auto selection for completion menu


# ---------------------------------------------------------
# exports
# ---------------------------------------------------------
export PATH= !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

export PAGER='less'

if [[ $IS_MAC -eq 1 ]]; then
  export EDITOR='subl -w'
else
  export EDITOR='vi'
fi


# ---------------------------------------------------------
# aliases
# ---------------------------------------------------------
alias c     =' clear'
alias zi    =' $EDITOR ~/.zshrc'

# directory movement --------
alias ..    =' cd ..'
alias ...   =' cd ../..'
alias ....  =' cd ../../..'
alias bk    =' cd $OLDPWD'

alias pu 	=' pushd'
alias po 	=' popd'
alias -- 	=' cd -'

alias p     =" cd ~/Projects"

# directory info ------------
alias lh    =' ls -ld .*'    # list hidden files
alias ll 	=' ls -l'		 # list file details
alias lz    =' du -sckx * | sort -nr'   # sort by size

# tools ---------------------
alias g 	='grep -in'
alias hist  ='fc -l 1'


# ---------------------------------------------------------
# mac only
# ---------------------------------------------------------
if [[ $IS_MAC -eq 1 ]]; then
  alias o     =' open'      # open Finder
  alias oo    =' open .'    # open current directory in Finder

# brew ----------------------
  alias freshbrew ='brew outdated | while read cask; do brew upgrade $cask; done'
fi


# ---------------------------------------------------------
# remote machines
# ---------------------------------------------------------
alias hades   ='ssh 178.79.135.76'


# -------------------------------------------------------------------
# git
# -------------------------------------------------------------------
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


# -------------------------------------------------------------------
# functions
# -------------------------------------------------------------------

# display formatted path ----
path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}

# list interface addresses --
function myip() {
  ifconfig lo0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "lo0       : " $2}'
  ifconfig en0 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en0 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en0 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en0 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet ' | sed -e 's/:/ /' | awk '{print "en1 (IPv4): " $2 " " $3 " " $4 " " $5 " " $6}'
  ifconfig en1 | grep 'inet6 ' | sed -e 's/ / /' | awk '{print "en1 (IPv6): " $2 " " $3 " " $4 " " $5 " " $6}'
}


# -------------------------------------------------------------------
# bind keys
# -------------------------------------------------------------------

# insert sudo at beginning of line
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo
