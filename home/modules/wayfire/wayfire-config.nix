{lib, ...}:
with lib;
let
  wayfire-config = {
    alpha = {
      min_value = "0.100000";
      modifier = "<alt> <super>";
    };
    animate = {
      close_animation = "zoom";
      duration = "400";
      enabled_for = ''(type equals "toplevel" | (type equals "x-or" & focusable equals true))'';
      fade_duration = "400";
      fade_enabled_for = ''type equals "overlay"'';
      fire_color = "\\#B22303FF";
      fire_duration = "300";
      fire_enabled_for = "none";
      fire_particle_size = "16.000000";
      fire_particles = "2000";
      open_animation = "zoom";
      random_fire_color = "false";
      startup_duration = "600";
      zoom_duration = "500";
      zoom_enabled_for = "none";
    };
    autostart = {
      autostart_wf_shell = "false";
      gamma = "wlsunset";
      idle = "my-swayidle";
      my_autostart = "my-wf-autostart";
      notifications = "dunst";
      outputs = "kanshi";
    };
    blur = {
      blur_by_default = ''type is "toplevel"'';
      bokeh_degrade = "1";
      bokeh_iterations = "15";
      bokeh_offset = "5.000000";
      box_degrade = "1";
      box_iterations = "2";
      box_offset = "1.000000";
      gaussian_degrade = "1";
      gaussian_iterations = "2";
      gaussian_offset = "1.000000";
      kawase_degrade = "3";
      kawase_iterations = "2";
      kawase_offset = "1.700000";
      method = "kawase";
      saturation = "1.000000";
      toggle = "none";
    };
    command = {
      binding_clipboard = "<super> KEY_C";
      binding_launcher = "<super> KEY_D";
      binding_lock = "<super> <shift> KEY_L";
      binding_mute = "KEY_MUTE";
      binding_run_launcher = "<super> KEY_R";
      binding_screenshot = "KEY_SYSRQ";
      binding_screenshot_interactive = "<super> KEY_SYSRQ";
      binding_terminal = "<super> KEY_ENTER";
      binding_web_browser = "<super> <shift> KEY_F";
      binding_waybar = "<super> <shift> KEY_B";
      command_clipboard = "my-show-clipboard";
      command_launcher = "wofi --show drun";
      command_lock = "my-swaylock manual";
      command_mute = "my-volume mute";
      command_run_launcher = "wofi --show run";
      command_screenshot = "my-screenshot full";
      command_screenshot_interactive = "my-screenshot select";
      command_terminal = "foot";
      command_volume_down = "my-volume down";
      command_volume_up = "my-volume up";
      command_web_browser = "brave -enable-features=UseOzonePlatform -ozone-platform=wayland --gtk-version=4";
      command_waybar = "killall waybar; ~/.config/wayfire/bar-run.sh";
      repeatable_binding_volume_down = "KEY_VOLUMEDOWN";
      repeatable_binding_volume_up = "KEY_VOLUMEUP";
    };
    core = {
      background_color = "\\#1A1A1AFF";
      close_top_view = "<super> KEY_Q | <alt> KEY_F4";
      focus_button_with_modifiers = "false";
      focus_buttons = "BTN_LEFT | BTN_MIDDLE | BTN_RIGHT";
      focus_buttons_passthrough = "true";
      max_render_time = "-1";
      plugins = "alpha   animate   autostart   command   cube   decoration   expo   fast-switcher   fisheye   foreign-toplevel   grid   gtk-shell   idle   invert   move   oswitch   place   resize   switcher   vswitch   wayfire-shell   window-rules   wm-actions   wobbly   wrot   input-method-v1   zoom scale";
      preferred_decoration_mode = "client";
      transaction_timeout = "100";
      vheight = "3";
      vwidth = "3";
      xwayland = "true";
    };
  };
in
{
  home.file."outout.ini".text = 
  let
    renderSection = name: section:
      let
        renderOption = key: value: ''${key} = ${value}'';
      in
      "[${name}]\n" + (concatStringsSep "\n" (mapAttrsToList renderOption section));
  in
  concatStringsSep "\n\n" (mapAttrsToList renderSection wayfire-config);
}
