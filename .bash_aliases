# ~/.bash_aliases

alias lf="/usr/local/bin/lfub"
alias l="ls --color -h --group-directories-first"
alias tar="tar -xf"
alias p="python3"
alias cat="bat"
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
alias gam="git commit -am"
alias gd="git diff"
# pacman aliases
alias mirror="doas reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist" #get fastest mirrors
alias pms="doas pacman -S"
alias pmu="doas pacman -Syyu; kill -47 $(pidof dwmblocks)"
alias pmr="doas pacman -Rns"
alias orphans="doas pacman -Qtdq | doas pacman -Rns -"
# vim
alias v="nvim"
# alias cnvim="nvim ~/.config/nvim/init.vim"
# alias vobsidian="cd ~/gdrive-pessoal/pessoal/obsidian"
alias vo="pwd |fd -tf . | fzf | xargs -r $EDITOR"
alias notas="cd /home/frank/gdrive-pessoal/pessoal/obsidian && nvim"
# systemctl
alias sytemctl="systemctl"
# Dotfiles in git
alias dotfiles="/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME"
# ansible
alias ansible-local="ansible-playbook --connection=local --inventory 127.0.0.1, --limit 127.0.0.1 --ask-become"
# Moving with fuzzy finder
# alias gi="file=$(pwd | fd -H -td . | fzf -e) && cd "$file""
# alias g="file=$(pwd | fd -td . | fzf -e) && cd "$file""
# alias gh="file=$(fd  -td . ~ | fzf -e) && cd "$file""
# alias gr="file=$(fd -td . / | fzf -e) && cd "$file""
