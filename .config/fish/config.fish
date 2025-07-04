# startx
[ -z "$DISPLAY" ] && [ $XDG_VTNR -eq 1 ] && exec startx

# Bring the aliases from bash
source ~/.bash_aliases

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DOWNLOAD_DIR "$HOME/gdrive-pessoal/downloads"
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.scripts /usr/local/bin /usr/bin $fish_user_paths
set -gx EDITOR "/usr/bin/nvim"
set -gx VISUAL "/usr/bin/nvim"
set -gx HISTFILE "$XDG_STATE_HOME/bash/history"
set -gx AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials"
set -gx AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -gx SCREENRC "$XDG_CONFIG_HOME/screen/screenrc"
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
set -gx IPYTHONDIR "$XDG_CONFIG_HOME/ipython"
set -gx JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -gx KDEHOME "$XDG_CONFIG_HOME/kde"
set -gx LESSHISTFILE "$XDG_CACHE_HOME"/less/history
set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
set -gx PYTHONSTARTUP "$XDG_CONFIG_HOME/python/pythonrc"
set -gx ANSIBLE_HOME "$XDG_CONFIG_HOME/ansible"
set -gx PYTHON_BIN ".env/bin"
set -gx MANPAGER "nvim +Man!"
set -gx MBSYNCRC "$XDG_CONFIG_HOME"/isync/mbsyncrc
set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME"/pass
set -gx GTK_THEME "Arc-Dark"
set -gx BC_ENV_ARGS "$XDG_CONFIG_HOME/bc/config"

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
if [ $fish_key_bindings = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end


# Remove the fish gretting message
set fish_greeting

# Enable vi mode
fish_vi_key_bindings

# Allow ctrl + f to autocomplete to work in vi mode and ctrl + g to forward a word
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
        bind -M $mode \cg forward-word
		#enable fzf key bindings
		fzf_key_bindings
    end
end

# Change the vim prompt
function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold blue
      echo '|n| '
    case insert
      set_color normal
      echo '|i| '
    case replace_one
      set_color --bold green
      echo '|R| '
    case visual
      set_color --bold brmagenta
      echo '|V| '
    case '*'
      set_color --bold red
      echo '|?| '
  end
  set_color normal
end

bind -M insert \ch 'cd $(pwd | fd -Htd . |fzf -e)'

if test -n "$NVIM_LISTEN_ADDRESS"
  set -x MANPAGER "/usr/local/bin/nvr -c 'Man!' -o -"
end

function __autols_hook --description "Auto ls" --on-event fish_prompt
  if test "$NO_AUTO_LS" != ""
    return
  end

  if test "$__autols_last" != (pwd)
    echo; ls
  end
  set  -g __autols_last (pwd)
end

zoxide init fish | source
