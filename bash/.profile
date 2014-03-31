# Ensure profile is sourced only once
[ -n "$PROFILE_SOURCED" ] && return
export PROFILE_SOURCED="true"
source $HOME/.bashrc
