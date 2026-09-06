# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration, if it is installed. Guarded because omf is
# an imperative install that does not exist on every machine (NixOS hosts
# have no ~/.local/share/omf), and an unguarded source errors on every
# single shell start.
test -f $OMF_PATH/init.fish; and source $OMF_PATH/init.fish
