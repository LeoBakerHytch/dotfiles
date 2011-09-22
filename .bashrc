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
#[ -r $HOME/.bash_bindings ] && source $HOME/.bash_bindings

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
			arrow="${colour}≡ "
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
[ -r $HOME/.git-completion ] && source $HOME/.git-completion

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Environment variables
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Locally installed program directory
export LOCAL=$HOME/Local

# Path
LOCALPATH=$LOCAL/bin:$HOME/.ec2/bin:$HOME/.rvm/bin
export PATH=$LOCALPATH:$(echo $PATH | sed -e "s|$LOCALPATH:||g")

# Default editor
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# Less options
# -R Send raw control characters (for proper colour output)
# -g Highlight search results while typing
export LESS="-R -g -x4"

# Pouldinator
export roy='leo@144.32.218.194'

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Functions
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Change to a directory and list its contents
function cs()
{
	cd $1
	ls
}

# Create an alias to a named instance of GVim
function vimalias()
{
	alias $1="gvim --servername $1 --remote-tab-silent"
}

# Alert for long-running commands (for example 'sleep 10; alert')
function alert()
{
	if [ $? == 0 ]; then
		icon=terminal
		result=successfully
	else
		icon=error
		result=erroneously
	fi

	notify-send --urgency=low --icon=$icon "Command terminated $result" \
		"$( history | tail -n1 | sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//' )"
}

# Prompt to run a given command
function run()
{
	printf "About to execute:\n\n    $*\n\n"
	read -p "Continue? "
	if [ $REPLY != "y" ]; then
		exit
	else
		echo "Executing..."
		eval "$*"
	fi
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

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# ISO 8601 date
alias isodate="date '+%Y-%m-%d %H:%M %Z'"

# Kill all processes on current server
alias suicide="kill \$(echo \$(ps -u $UID --format pid --no-heading))"

# Process tree for current user
alias pstreeme="pstree -p -u $USER"

# Process listing for current user
alias psme="ps -u $USER --format='pid %cpu %mem command'"

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Java
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Ant contrib
ant=$LOCAL/ant/ant-contrib.jar
[ ]

# JCSP
jcsp=$LOCAL/jcsp/jcsp.jar

# Java Class Path
export CLASSPATH=.:$ant:$jcsp

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Amazon AWS
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# EC2

export EC2_HOME=$HOME/.ec2
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

function ec2new()
{
	[ -n "$1" ] && run ec2run -g $group -k $key -t $type -z $zone $1
}

# S3

[ -r $HOME/.aws ] && source $HOME/.aws

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#SSH
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SSH_ENV="$HOME/.ssh/environment"

# Start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo succeeded
    chmod 600 "$SSH_ENV"
    source "$SSH_ENV" > /dev/null
    ssh-add
}

# Test for identities
function test_identities {
    # Test whether standard identities have been added to the agent already
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $? -eq 0 ]; then
        ssh-add
        # $SSH_AUTH_SOCK broken so we start a new proper agent
        if [ $? -eq 2 ];then
            start_agent
        fi
    fi
}

# Check for running ssh-agent with proper $SSH_AGENT_PID
if [ -n "$SSH_AGENT_PID" ]; then
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent > /dev/null
    if [ $? -eq 0 ]; then
		test_identities
    fi

# If $SSH_AGENT_PID is not properly set, we can try loading one from $SSH_ENV
else
	if [ -f "$SSH_ENV" ]; then
		source "$SSH_ENV" > /dev/null
	fi
	ps -ef | grep "$SSH_AGENT_PID" | grep -v grep | grep ssh-agent > /dev/null
	if [ $? -eq 0 ]; then
		test_identities
	else
		start_agent
	fi
fi

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Ruby
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
