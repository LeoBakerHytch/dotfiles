#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Bash sources this for non-login shells
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# If not running interactively, do nothing
[ -z "$PS1" ] && return

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# History
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Ignore duplicates, lines beginning with spaces and more
export HISTIGNORE="&:[ ]*:ls:l:[bf]g:ps:cd *:cs *"

# Append to history file, don't overwrite it
shopt -s histappend

# Set history file length and size
export HISTSIZE=1000
export HISTFILESIZE=2000

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Terminal
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Check and update window size
shopt -s checkwinsize

# Undefine 'stop' so forward-search-history works
stty stop undef

# Enable completion
#if [ -r /etc/bash_completion ] && ! shopt -oq posix; then 
#    source /etc/bash_completion
#fi

# Enable bash vi-mode bindings
#[ -r .bash_bindings ] && source ~/.bash_bindings

# Prompt in colour

      red="\[\033[1;31m\]"
    green="\[\033[1;32m\]"
   yellow="\[\033[1;33m\]"
     blue="\[\033[1;34m\]"
  magenta="\[\033[1;35m\]"
     cyan="\[\033[1;36m\]"
    white="\[\033[1;37m\]"
no_colour="\[\e[0m\]"

__git_arrow()
{
	local colour

	# Check whether we're in a repository
	if git rev-parse --quiet --verify HEAD &> /dev/null; then

		# Start with a white arrow
		colour="$white"

		# Check whether working directory is dirty
		git diff --no-ext-diff --ignore-submodules --quiet --exit-code || colour="$yellow"

		# Check whether anything is cached
		git diff-index --cached --quiet --ignore-submodules HEAD -- || colour="$cyan"


		# Check whether anything is stashed
		if $(git stash show &> /dev/null); then
			arrow="${colour}★ "
		else
			arrow="${colour}● "
		fi

	else
		arrow=""
	fi

	# Check that terminal supports colour
	if [ -x /usr/bin/tput ] && tput setaf 1 &> /dev/null; then

		titlebar="\[\e]2;\w\a\]"
		PS1="${titlebar}${red}\u${blue}\$ ${arrow}${no_colour}"

	else
		PS1='\u\$ '
	fi
}

export PROMPT_COMMAND=__git_arrow

# Output of ls and grep in colour
if [ -x /usr/bin/dircolors ]; then

    # Set directory colours
    eval "$(dircolors -b)"

    alias ls='ls --color=always'
    alias grep='grep --color=always'
    alias fgrep='fgrep --color=always'
    alias egrep='egrep --color=always'
	alias less='less -R'
fi

# Git completions
source ~/.git-completion

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Miscellaneous
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Make less more friendly for non-text input files (see lesspipe(1))
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Alert for long-running commands (for example 'sleep 10; alert')
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Environment variables
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Default editor
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# Less options
# -R Send raw control characters (for proper colour output)
# -g Highlight search results while typing
export LESS="-R -g -x4"

# Path
LOCALPATH=$HOME/Local/bin:$HOME/.gem/ruby/1.9.1/bin:$HOME/.ec2/bin:$HOME/.rvm/bin:$HOME/.gems/bin
export PATH=$LOCALPATH:$(echo $PATH | sed -e "s|$LOCALPATH:||g")

# Path for cd
# export CDPATH=.:~

# Ruby
export GEM_HOME=$HOME/.gems

# Pouldinator
export pould='leo@144.32.218.194'

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Functions
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cs()
{
	cd $1
	ls
}

vimalias()
{
	alias $1="gvim --servername $1 --remote-tab-silent"
}

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Aliases
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Directory listings

alias   l='ls'          # Normal
alias  ll='ls -lh'      # Long-listing (human-readable)
alias  la='ls -A'       # With hidden files
alias lla='ls -lhA'     # Long-listing with hidden files
alias  l1='ls -1'       # One item per line
alias  lc='clear; ls'   # Clear screen first
alias  lf='ls -F'       # Append type indicator

# Directory traversal
alias d='dirs -v'
alias r='pushd +1'
alias p='pushd'
alias o='popd'

# Bash history reexecution
alias re='fc -s'
alias rl='fc -l'

# pstree
alias pstreeme='pstree -p -u lbh500'

# ps
alias psme="ps -u lbh500 --format='pid %cpu %mem command'"

# ISO 8601 date
#alias date="date '+%Y-%m-%d %H:%M %Z'"

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Application aliases

# JabRef
alias jabref="java -jar ~/.jar/JabRef &> /dev/null &"

# Beanshell
alias bsh="java bsh.Interpreter"

# Kill all processes on current server
alias suicide="kill \$(echo \$(ps -u $UID --format pid --no-heading))"

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Java
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Location of all libraries
local=~/Local

# Java 3D
j3d=

# j3d=~/$local/j3d
# j3d_root=$j3d
# j3d=$j3d/j3dcore.jar:$j3d/j3dutils.jar:$j3d/vecmath.jar

# Library path
# export LD_LIBRARY_PATH=$j3d_root/i386

# Mason
mason=$local/mason

# Java Media Framework
jmf=$local/jmf/lib/jmf.jar

# JCSP
jcsp=$local/jcsp/jcsp.jar

# Ant Contrib
ant=$local/ant/ant-contrib.jar

# Own code
own=$local/own-code

# Beanshell
bsh=$local/beanshell/bsh.jar

# Java Class Path
export CLASSPATH=.:$own:$mason:$j3d:$jmf:$jcsp:$ant:$bsh

# Clean-up
unset local j3d mason jmf jcsp bsh

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Amazon EC2
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

export EC2_HOME=~/.ec2
export KEY=$EC2_HOME/keys/key-1.pem
export EC2_KEY=$KEY
export EC2_PRIVATE_KEY=$(ls $EC2_HOME/keys/pk-*.pem)
export EC2_CERT=$(ls $EC2_HOME/keys/cert-*.pem)
export EC2_URL=https://eu-west-1.ec2.amazonaws.com

export group=open-access
export key=key-1
export type=t1.micro
export user=ec2-user
export zone=eu-west-1a

alias ec2inst="source $(which ec2inst)"
alias ec2image="source $(which ec2image)"

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
