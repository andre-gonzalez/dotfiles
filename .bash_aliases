# ~/.bash_aliases

alias lf="/usr/local/bin/lfub"
alias l="ls --color -h --group-directories-first"
alias tar="tar -xf"
alias p="python3"
alias f='fzf --preview="bat --color=always {}"'
# making some command interactive
alias mv="mv -i"
alias rm="trash -i"
alias cp="cp -i"
# doas alises
alias sudo="doas"
alias sudoedit="doas rvim"
# git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push -u origin"
alias gd="git diff"
# pacman aliases
alias mirror="doas reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist" #get fastest mirrors
alias pms="doas pacman -S"
alias pmu="yay -Syyu --askremovemake --noconfirm; kill -47 $(pidof dwmblocks)"
alias pmr="doas pacman -Rns"
alias orphans="doas pacman -Qtdq | doas pacman -Rns -"
# vim
alias v="nvim"
# Dotfiles in git
alias dotfiles="/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME"
# ansible
alias ansible-local="ansible-playbook --connection=local --inventory 127.0.0.1, --limit 127.0.0.1 --ask-become"
