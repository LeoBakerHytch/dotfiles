# Bash sources this for non-login shells

# If not running interactively, do nothing
[ -z "$PS1" ] && return

# Set the path to include programs installed by Homebrew
PATH="/usr/local/bin:${PATH}"


# Aliases
# =======

# Directory listings
alias  ls='ls -G'       # Always use color
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
[ -f "~/.dircolors" ] && eval $("dircolors -b ~/.dircolors 2> /dev/null")


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
    local no_color="\[\e[0m\]"
    local titlebar="\[\e]2;\w\a\]"
    local user="${red}\u${blue}\$"

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
