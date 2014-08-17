# Bash sources this for non-login shells

# If not running interactively, do nothing
[ -z "$PS1" ] && return

# Set the path to include programs installed by Homebrew
PATH="$HOME/Library/bin:/usr/local/bin:${PATH}"

# RVM
# ===

# Add RVM to path
PATH="${PATH}:~/.rvm/bin"

# Load RVM as a function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"



# Python autoenv
# ==============

# Activates Python virtual environments on entering a directory with a .env
source /usr/local/opt/autoenv/activate.sh


# Aliases
# =======

# Use ls in colour
if (hash gls 2> /dev/null)
then
    # Use GNU ls if available ('brew install coreutils' to get it)
    alias ls='gls --color=auto --group-directories-first'
else
    # Otherwise use Mac ls
    alias ls='ls -G'
fi

# Directory listings
alias   l='ls'          # Normal
alias  ll='ls -lh'      # Long-listing (human-readable file sizes)
alias  la='ls -A'       # With hidden files
alias lla='ls -lhA'     # Long-listing with hidden files
alias  l1='ls -1'       # One item per line
alias  lc='clear; ls'   # Clear screen first
alias  lf='ls -F'       # Append type indicator

# History re-execution
alias r='fc -s'
alias rl='fc -l'

# URL encoding / decoding
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

# Virtual environment activation
alias activate='source env/bin/activate'


# Functions
# =========

function cs()
{
    cd $1; ls
}

# Create an alias to a named instance of GVim
function vimalias()
{
    alias $1="gvim --servername $1 --remote-tab-silent"
}

# Create a repository on GitHub
function github-create()
{
    local invalid_credentials=0
    local repo_name=$1
    local dir_name=$(basename $(pwd))
     
    if [ "$repo_name" = "" ]; then
	echo "Repo name (hit enter to use '$dir_name')?"
	read repo_name
    fi
     
    if [ "$repo_name" = "" ]; then
	repo_name=$dir_name
    fi
     
    local username=$(git config github.user)
    if [ "$username" = "" ]; then
	echo "Could not find username, run 'git config --global github.user <username>'"
	invalid_credentials=1
    fi
     
    local token=$(git config github.token)
    if [ "$token" = "" ]; then
	echo "Could not find token (github.token), run 'mkdir -p ~/.config/git; git config --file ~/.config/git/config github.token <token>'"
	invalid_credentials=1
    fi
     
    if [ "$invalid_credentials" == "1" ]; then
	return 1
    fi
     
    echo -n "Creating Github repository '$repo_name' ..."
    curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
    echo " done."
     
    echo -n "Pushing local code to remote ..."
    git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
    git push -u origin master > /dev/null 2>&1
    echo " done."
}


# History
# =======

# Ignore duplicates, lines beginning with spaces and more
HISTIGNORE="&:[ ]*:l:ls:la:ll:[bf]g:ps:cd *:cs *"

# Append to history file, don't overwrite it
shopt -s histappend

# Set history file length and size
HISTSIZE=1000
HISTFILESIZE=2000


# Terminal
# ========

# Ensure lines wrap properly after resizing terminal
shopt -s checkwinsize

# Undefine 'stop' so forward-search-history works
stty stop undef

# Default editor
export EDITOR=vim
export VISUAL=vim

# Less options
# -R  Send raw control characters (for proper color output)
# -g  Highlight search results while typing
# -x4 Tab stop position
export LESS="-R -g -x4"


# Colour output
# =============

# Output of grep in colour
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Set colours to be used by ls and tree
[ -f "~/.dircolors" ] && eval $("gdircolors -b ~/.dircolors 2> /dev/null")


# Prompt
# ======

# Check that terminal supports color
if (hash tput 2>/dev/null) && tput setaf 1 &> /dev/null
then
    # If git is available, add status of current repo to prompt
    if (hash git 2>/dev/null)
    then
	# Set the function to be executed for each prompt
        PROMPT_COMMAND=_set_git_prompt
    else
        _set_color_prompt
    fi
else
    _set_plain_prompt
fi

function _set_git_prompt()
{
    _set_color_prompt
    _append_git_status
}

function _set_plain_prompt()
{
    PS1='\u\$ '
}


function _set_color_prompt()
{
    local red="\[\033[1;31m\]"
    local blue="\[\033[1;34m\]"
    local green="\[\033[1;32m\]"
    local no_color="\[\e[0m\]"
    local titlebar="\[\e]2;\w\a\]"
    local user="${red}\u${blue}\$"

    if [ -n "$VIRTUAL_ENV" ]
    then
	local user="${green}\u${blue}\$"
    else
	local user="${red}\u${blue}\$"
    fi

    PS1="${titlebar}${user}${no_color} "
}

# Appends status of current repo to PS1
function _append_git_status()
{
    local prompt
    local s
    local c="●"
    local red="\[\033[1;31m\]"
    local cyan="\[\033[1;36m\]"
    local blue="\[\033[1;34m\]"
    local black="\[\033[1;30m\]"
    local white="\[\033[1;37m\]"
    local yellow="\[\033[1;33m\]"
    local magenta="\[\033[1;35m\]"
    local no_color="\[\e[0m\]"

    # Check whether we're in a repository
    if (git rev-parse --quiet --verify HEAD &> /dev/null)
    then

        # Check if we're in a .git directory
        if [ $(basename $(pwd)) == ".git" ]
        then
            prompt="${black}${c}"

        else
            # Get status (has stable output format)
            s=$(git status --porcelain 2> /dev/null)

            # Check for conflicts
            echo "$s" | grep -q "^.U" && prompt="${red}${c}"

            # Indexed files
            echo "$s" | grep -q "^[ADMR]" && prompt="${prompt}${cyan}${c}"

            # Modified files
            echo "$s" | grep -q "^.[M]" && prompt="${prompt}${yellow}${c}"

            # Untracked files
            echo "$s" | grep -q "^??" && prompt="${prompt}${blue}${c}"

            # Anything in the stash
            (git stash show &> /dev/null) && prompt="${prompt}${magenta}${c}"

            # Fallback if none of the above are true
            [ -z "$prompt" ] && prompt="${white}${c}"

        fi

        # Reset colour and add a space
        prompt="${prompt}${no_color} "

    else
        # We're in a normal directory
        prompt=""
    fi

    PS1="${PS1}${prompt}"
}
