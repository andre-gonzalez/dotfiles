# ~/.bash_aliases

alias lf="/usr/local/bin/lfub"
alias l="ls --color -h --group-directories-first"
alias tar="tar -xf"
alias p="python3"
# making some command interactive
alias mv="mv -i"
alias rm="trash -i"
alias cp="cp -i"
# cd..ing around
# alias salesops="cd ~/eureciclo/salesops"
# alias pessoal="cd ~/gdrive-pessoal/pessoal"
# alias trabalho="cd ~/gdrive-pessoal/trabalho"
# alias estudo="cd ~/gdrive-pessoal/estudo"
alias ~="cd ~"
# alias arch-setup="cd ~/gdrive-pessoal/pessoal/programação/arch-setup"
# alias dotfiles="cd ~/gdrive-pessoal/pessoal/programação/arch-setup/dotfiles"
# alias downloads="cd ~/gdrive-pessoal/downloads"
# alias fotos="cd ~/gdrive-pessoal/pessoal/fotos"
# alias hubspot="cd ~/eureciclo/salesops/hubspot"
# alias pipefy="cd ~/eureciclo/salesops/pipefy"
# alias slack="cd ~/eureciclo/salesops/slack-bot"
# alias ..="cd .."
# alias edownloads="cd ~/eureciclo/downloads"
# alias database="cd ~/eureciclo/salesops-dw/"
# alias utils="cd ~/eureciclo/utils"
# alias organizar="cd /home/frank/gdrive-pessoal/pessoal/obsidian/_organizar"
# alias scripts="cd /home/frank/gdrive-pessoal/pessoal/programação/arch-setup/scripts-dmenu"
# doas alises
alias sudo="doas"
alias sudoedit="doas rvim"
# git aliases
alias ga="git add"
alias gc="git commit -m"
alias gp="git push -u origin"
alias gam="git commit -am"
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
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# Moving with fuzzy finder
alias gi='file=$(pwd | fd -H -td . | fzf -e) && cd "$file"'
alias g='file=$(pwd | fd -td . | fzf -e) && cd "$file"'
alias gh='file=$(fd  -td . ~ | fzf -e) && cd "$file"'
alias gr='file=$(fd -td . / | fzf -e) && cd "$file"'
