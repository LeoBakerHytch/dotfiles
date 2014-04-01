# Bash sources this for non-login shells

# If not running interactively, do nothing
[ -z "$PS1" ] && return


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
export HISTIGNORE="&:[ ]*:l:ls:la:ll:[bf]g:ps:cd *:cs *"

# Append to history file, don't overwrite it
shopt -s histappend

# Set history file length and size
export HISTSIZE=1000
export HISTFILESIZE=2000


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


# Colour codes
# ============

    l_red="\[\033[0;31m\]"
  l_green="\[\033[0;32m\]"
 l_yellow="\[\033[0;33m\]"
   l_blue="\[\033[0;34m\]"
l_magenta="\[\033[0;35m\]"
   l_cyan="\[\033[0;36m\]"
  l_white="\[\033[0;37m\]"

    black="\[\033[1;30m\]"
      red="\[\033[1;31m\]"
    green="\[\033[1;32m\]"
   yellow="\[\033[1;33m\]"
     blue="\[\033[1;34m\]"
  magenta="\[\033[1;35m\]"
     cyan="\[\033[1;36m\]"
    white="\[\033[1;37m\]"
 no_color="\[\e[0m\]"


# Prompt
# ======

export PROMPT_COMMAND=prompt

function prompt()
{
    # Check that terminal supports color
    if [ -x /usr/bin/tput ] && tput setaf 1 &> /dev/null
    then
        local titlebar="\[\e]2;\w\a\]"
        local user="${red}\u${blue}\$"

        PS1="${titlebar}${user} $(git_prompt)${no_color}"

    else
        PS1='\u\$ '
    fi
}

function git_prompt()
{
    local prompt s

    # Check whether we're in a repository
    if (git rev-parse --quiet --verify HEAD &> /dev/null)
    then

        # Check if we're in a .git directory
        if [ $(basename $(pwd)) == ".git" ]
        then
            prompt="${black}●"

        else
            # Get status (has stable output format)
            s=$(git status --porcelain 2> /dev/null)

            # Check for conflicts
            echo "$s" | grep -q "^.U" && prompt="${red}●"

            # Indexed files
            echo "$s" | grep -q "^[ADMR]" && prompt="${prompt}${cyan}●"

            # Modified files
            echo "$s" | grep -q "^.[M]" && prompt="${prompt}${yellow}●"

            # Untracked files
            echo "$s" | grep -q "^??" && prompt="${prompt}${blue}●"

            # Anything in the stash
            (git stash show &> /dev/null) && prompt="${prompt}${magenta}●"

            # Fallback if none of the above are true
            [ -z "$prompt" ] && prompt="${white}●"

        fi

        # Add a space
        prompt="$prompt "

    else
        # We're in a normal directory
        prompt=""
    fi

    printf "$prompt"
}
