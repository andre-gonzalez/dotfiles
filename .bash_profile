#
# ~/.bash_profile
#

export CM_OUTPUT_CLIP=1
export CM_IGNORE_WINDOW="Bitwarden"

[[ -f ~/.bashrc ]] && . ~/.bashrc

[ -z "$DISPLAY" ] && [ $XDG_VTNR -eq 1 ] && exec startx
