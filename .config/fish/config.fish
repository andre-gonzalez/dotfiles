if status is-interactive
    # Commands to run in interactive sessions can go here
source ~/.bash_aliases
fish_vi_key_bindings
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end
end
