# startx
[ -z "$DISPLAY" ] && [ $XDG_VTNR -eq 1 ] && exec startx
# Bring the aliases from bash
source ~/.bash_aliases

# Remove the fish gretting message
set fish_greeting

# Enable vi mode
fish_vi_key_bindings

# Allow ctrl + f to autocomplete to work in vi mode and ctrl + g to forward a word
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
        bind -M $mode \cg forward-word
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
