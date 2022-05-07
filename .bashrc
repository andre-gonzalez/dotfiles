# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Bash aliases file
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# Funcition used to show my branch in the PS1
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1="\W\033[00;32m\]\$(git_branch)\[\033[00m\] > "
########
#ALCI
########
export EDITOR='/usr/bin/nvim'
export VISUAL='/usr/bin/nvim'
export PATH='$HOME/.scripts:$HOME/.local/bin:/usr/local/bin:/usr/bin:$PATH'
export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

#Change directories using fuzzy finder
gi() {
		file=$(pwd | fd -H -td . | fzf -e) && cd "$file"
}
g() {
		file=$(pwd | fd -td . | fzf -e) && cd "$file"
}
gh() {
    file=$(fd  -td . ~ | fzf -e) && cd "$file"
}
gr() {
    file=$(fd -td . / | fzf -e) && cd "$file"
}


#auto cd. Moving around without the need to type cd
shopt -s autocd
shopt -s cdspell #aurocorrects cd misspellings
shopt -s expand_aliases #expand aliases

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/frank/.config/google-cloud-sdk/path.bash.inc' ]; then . '/home/frank/.config/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/frank/.config/google-cloud-sdk/completion.bash.inc' ]; then . '/home/frank/.config/google-cloud-sdk/completion.bash.inc'; fi

# enable lf to change directories
LFCD="$GOPATH/src/github.com/gokcehan/lf/etc/lfcd.sh"  # source
LFCD="/home/frank/.config/lf/lfcd.sh"                                #  pre-built binary, make sure to use absolute path
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi
bind '"\C-o":"lfcd\C-m"'
bind '"\C-e":"$(pwd | fd -td . | fzf -e) && cd "$file"\C-m"'
bind '"\C-u":"$pwd |fd -tf . | fzf | xargs -r $EDITOR"\C-m"'
#To reload .bashrc use ->  source ~/.bashrc
