#
# This gets read fourth after zshrc for login shells
# Let's put stuff in here that's only used by human/login shells,
# which is most of my stuff
#
# default prompt - use Starship later on
PS1='zsh> '

# history-related settings
HISTSIZE=10000
SAVEHIST=2500
APPEND_HISTORY=1
# set up ESC-v to edit (multi-line) commands in vim
export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -v
export KEYTIMEOUT=1
bindkey -M vicmd v edit-command-line

###  job control commands
#	j ------ list current jobs in long format
#       f ------ put named job into foreground
#	fj ----- foreground selected job (prompts with list of jobs)
# BUG: want jobs list to include the working directory
alias	j='jobs -l'
function	f	{ fg %"$*"; }
function	fj {
    jobs -l
    print -n "Select Job #: "
    typeset jn="job"
    read jn
    fg %"$jn"
}
alias f1='fg %1'
alias f2='fg %2'
alias f3='fg %3'
alias f4='fg %4'
alias f5='fg %5'


### forms of ls
if type exa > /dev/null ; then
    alias ll='exa --long --bytes --git'
    alias lwd='ll --sort=modified --reverse'
    alias lrd='ll --accessed --sort=accessed --reverse'
    # lhd should be a function to take args
    alias lhd='lwd --color=always | head'
else
    alais ll='ls -l'
    alias lwd='ls -t -l'
    alias lrd='ls -t -l -u'
    # lhd should be a function to take args
    alias lhd='ls -t -l | head'
fi

# fancy directory stack
source "$ZDOTDIR/dirs.zsh"

# fancy prompt
if starship --version > /dev/null 2>&1 ; then
    export STARSHIP_CONFIG=$DOT/starship.toml
    eval "$(starship init zsh)"
fi

### git stuff
zstyle ':completion:*:*:git:*' script $DOT/git-completion.bash
alias ga='git add'
alias gb='git branch'
alias gd='git diff'
alias gs='git status'
alias gfo='git fetch origin --no-tags'
alias gfu='git fetch upstream --no-tags'
function	gpf {
    # this could look for remote and branch parameters, I only do this
    # for origin and the current branch
    # in git 1.8, don't need awk: git symbolic-ref --short -q HEAD
    if branch=$(git symbolic-ref -q HEAD)
    then
        branch=$(echo $branch | awk -F / '{print $NF}')
        echo "git pull --ff-only origin $branch"
        git pull --ff-only origin $branch
    else
        echo "not on any branch - can't fast-forward"
    fi
}

### ruby stuff
# Prefer rbenv over rvm
if [ -d "$HOME/.rbenv" ] ; then
    eval "$(rbenv init -)"
else
    if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
        source "$HOME/.rvm/scripts/rvm"
    fi
fi
alias be='bundle exec'

### miscellaneous aliases
alias a='alias'
alias clr='clear'
alias cp='cp -i'
alias ge='env | grep -i'
alias mv='mv -i'
alias m='more'
alias ping=`whence ping`
alias p8='ping 8.8.8.8'
alias rm='rm -i'
alias U='uptime'
alias vm='vi [Mm]akefile'
alias vt='vi -t'

# Specifically only autoload functions in login shells
autoload -Uz compinit && compinit
