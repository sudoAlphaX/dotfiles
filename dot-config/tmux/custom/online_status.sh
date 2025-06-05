# Requires https://github.com/tmux-plugins/tmux-online-status


show_online_status() { # This function name must match the module name!
  local index icon color text module

  index=$1 # This variable is used internally by the module loader in order to know the position of this module

  icon="$( get_tmux_option "@catppuccin_online_status_icon"  "" )"
  color="$( get_tmux_option "@catppuccin_online_status_color" "$thm_pink" )"
  text="$(  get_tmux_option "@catppuccin_online_status_text"  "#{online_status} " )"

  module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}
