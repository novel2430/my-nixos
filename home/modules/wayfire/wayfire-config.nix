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
    cube = {
      activate = "<alt> <ctrl> BTN_LEFT";
      background = "\\#1A1A1AFF";
      background_mode = "simple";
      cubemap_image = "";
      deform = "0";
      initial_animation = "350";
      light = "true";
      rotate_left = "none";
      rotate_right = "none";
      skydome_mirror = "true";
      skydome_texture = "";
      speed_spin_horiz = "0.020000";
      speed_spin_vert = "0.020000";
      speed_zoom = "0.070000";
      zoom = "0.100000";
    };
    decoration = {
      active_color = "\\#222222AA";
      border_size = "4";
      button_order = "minimize maximize close";
      font = "sans-serif";
      ignore_views = "none";
      inactive_color = "\\#333333DD";
      title_height = "30";
    };
    expo = {
      background = "\\#1A1A1AFF";
      duration = "500";
      inactive_brightness = "0.700000";
      keyboard_interaction = "true";
      offset = "10";
      select_workspace_1 = "KEY_1";
      select_workspace_2 = "KEY_2";
      select_workspace_3 = "KEY_3";
      select_workspace_4 = "KEY_4";
      select_workspace_5 = "KEY_5";
      select_workspace_6 = "KEY_6";
      select_workspace_7 = "KEY_7";
      select_workspace_8 = "KEY_8";
      select_workspace_9 = "KEY_9";
      toggle = "<super>";
      transition_length = "200";
    };
    extra-gestures = {
      close_fingers = "20";
      move_delay = "500";
      move_fingers = "3";
    };
    fast-switcher = {
      activate = "<alt> KEY_ESC";
      activate_backward = "<alt> <shift> KEY_ESC";
      inactive_alpha = "0.700000";
    };
    fisheye = {
      radius = "450.000000";
      toggle = "<ctrl> <super> KEY_F";
      zoom = "7.000000";
    };
    grid = {
      duration = "300";
      restore = "<super> KEY_DOWN | <super> KEY_KP0";
      slot_b = "<super> KEY_KP2";
      slot_bl = "<super> KEY_KP1";
      slot_br = "<super> KEY_KP3";
      slot_c = "<super> KEY_UP | <super> KEY_KP5";
      slot_l = "<super> KEY_LEFT | <super> KEY_KP4";
      slot_r = "<super> KEY_RIGHT | <super> KEY_KP6";
      slot_t = "<super> KEY_KP8";
      slot_tl = "<super> KEY_KP7";
      slot_tr = "<super> KEY_KP9";
      type = "crossfade";
    };
    idle = {
      cube_max_zoom = "1.500000";
      cube_rotate_speed = "1.000000";
      cube_zoom_speed = "1000";
      disable_initially = "false";
      disable_on_fullscreen = "true";
      dpms_timeout = "-1";
      screensaver_timeout = "3600";
      toggle = "none";
    };
    input = {
      click_method = "default";
      cursor_size = "15";
      cursor_theme = "default";
      disable_touchpad_while_mouse = "false";
      disable_touchpad_while_typing = "false";
      drag_lock = "false";
      gesture_sensitivity = "1.000000";
      kb_capslock_default_state = "false";
      kb_numlock_default_state = "false";
      kb_repeat_delay = "400";
      kb_repeat_rate = "40";
      left_handed_mode = "false";
      middle_emulation = "false";
      modifier_binding_timeout = "400";
      mouse_accel_profile = "default";
      mouse_cursor_speed = "0.000000";
      mouse_scroll_speed = "1.000000";
      natural_scroll = "false";
      scroll_method = "default";
      tablet_motion_mode = "default";
      tap_to_click = "true";
      touchpad_accel_profile = "default";
      touchpad_cursor_speed = "0.000000";
      touchpad_scroll_speed = "1.000000";
      xkb_layout = "us";
      xkb_model = "";
      xkb_options = "";
      xkb_rules = "evdev";
      xkb_variant = "";
    };
    input-device = {
      output = "";
    };
    invert = {
      preserve_hue = "false";
      toggle = "<super> KEY_I";
    };
    move = {
      activate = "<super> BTN_LEFT";
      enable_snap = "true";
      enable_snap_off = "true";
      join_views = "false";
      preview_base_border = "\\#404080CC";
      preview_base_color = "\\#8080FF80";
      preview_border_width = "3";
      quarter_snap_threshold = "50";
      snap_off_threshold = "10";
      snap_threshold = "10";
      workspace_switch_after = "-1";
    };
    oswitch = {
      next_output = "<super> KEY_O";
      next_output_with_win = "<shift> <super> KEY_O";
      prev_output = "";
      prev_output_with_win = "";
    };
    output = {
      depth = "8";
      mode = "auto";
      position = "auto";
      scale = "1.0";
      transform = "normal";
      vrr = "false";
    };
    "output:eDP-1" = {
      depth = "8";
      mode = "off";
      position = "auto";
      scale = "1.0";
      transform = "normal";
      vrr = "false";
    };
    place = {
      mode = "center";
    };
    preserve-output = {
      last_output_focus_timeout = "10000";
    };
    resize = {
      activate = "<super> BTN_RIGHT";
      activate_preserve_aspect = "none";
    };
    scale = {
      allow_zoom = "false";
      bg_color = "\\#1A1A1AE6";
      duration = "500";
      inactive_alpha = "0.750000";
      include_minimized = "true";
      middle_click_close = "false";
      minimized_alpha = "0.450000";
      outer_margin = "0";
      spacing = "30";
      text_color = "\\#CCCCCCFF";
      title_font_size = "20";
      title_overlay = "all";
      title_position = "center";
      toggle = "<alt> KEY_SPACE | hotspot right-top 10x10 250";
      toggle_all = "";
    };
    scale-title-filter = {
      bg_color = "\\#00000080";
      case_sensitive = "false";
      font_size = "30";
      overlay = "true";
      share_filter = "false";
      text_color = "\\#CCCCCCCC";
    };
    shortcuts-inhibit = {
      break_grab = "none";
      ignore_views = "none";
      inhibit_by_default = "none";
    };
    simple-title = {
      animation_duration = "0";
      button_move = "<super> BTN_LEFT";
      button_resize = "<super> BTN_RIGHT";
      inner_gap_size = "5";
      keep_fullscreen_on_adjacent = "true";
      key_focus_above = "<super> KEY_K";
      key_focus_below = "<super> KEY_J";
      key_focus_left = "<super> KEY_H";
      key_focus_right = "<super> KEY_L";
      key_toggle = "<super> KEY_T";
      outer_horiz_gap_size = "0";
      outer_vert_gap_size = "0";
      preview_base_border = "\\#404080CC";
      preview_base_color = "\\#8080FF80";
      preview_border_width = "3";
      tile_by_default = "all";
    };
    switcher = {
      next_view = "<alt> KEY_TAB";
      prev_view = "<alt> <shift> KEY_TAB";
      speed = "500";
      view_thumbnail_rotation = "30";
      view_thumbnail_scale = "1.000000";
    };
    vswipe = {
      background = "\\#1A1A1AFF";
      delta_threshold = "24.000000";
      duration = "180";
      enable_free_movement = "false";
      enable_horizontal = "true";
      enable_smooth_transition = "false";
      enable_vertical = "true";
      fingers = "4";
      gap = "32.000000";
      speed_cap = "0.050000";
      speed_factor = "256.000000";
      threshold = "0.350000";
    };
    vswitch = {
      background = "\\#1A1A1AFF";
      binding_down = "<ctrl> <super> KEY_DOWN";
      binding_last = "";
      binding_left = "<ctrl> <super> KEY_LEFT";
      binding_right = "<ctrl> <super> KEY_RIGHT";
      binding_up = "<ctrl> <super> KEY_UP";
      duration = "300";
      gap = "20";
      send_win_down = "";
      send_win_last = "";
      send_win_left = "";
      send_win_right = "";
      send_win_up = "";
      with_win_down = "<ctrl> <shift> <super> KEY_DOWN";
      with_win_last = "";
      with_win_left = "<ctrl> <shift> <super> KEY_LEFT";
      with_win_right = "<ctrl> <shift> <super> KEY_RIGHT";
      with_win_up = "<ctrl> <shift> <super> KEY_UP";
      wraparound = "false";
    };
    wayfire-shell = {
      toggle_menu = "<super>";
    };
    wm-actions = {
      minimize = "none";
      send_to_back = "none";
      toggle_always_on_top = "<super> KEY_X";
      toggle_fullscreen = "<super> KEY_F";
      toggle_maximize = "none";
      toggle_showdesktop = "none";
      toggle_sticky = "none";
    };
    wobbly = {
      friction = "3.000000";
      grid_resolution = "6";
      spring_k = "8.000000";
    };
    workarounds = {
      all_dialogs_modal = "true";
      app_id_mode = "stock";
      discard_command_output = "true";
      dynamic_repaint_delay = "false";
      enable_input_method_v2 = "false";
      enable_so_unloading = "false";
      force_preferred_decoration_mode = "false";
      remove_output_limits = "false";
      use_external_output_configuration = "false";
    };
    wrot = {
      activate = "<ctrl> BTN_RIGHT";
      activate-3d = "<shift> <super> BTN_RIGHT";
      invert = "false";
      reset = "<ctrl> <super> KEY_R";
      reset-one = "<super> KEY_R";
      reset_radius = "25.000000";
      sensitivity = "24";
    };
    wsets = {
      label_duration = "2000";
    };
    zoom = {
      interpolation_method = "0";
      modifier = "<super>";
      smoothing_duration = "300";
      speed = "0.010000";
    };
  };
in
{
  home.file.".config/wayfire.ini".text = 
  let
    renderSection = name: section:
      let
        renderOption = key: value: ''${key} = ${value}'';
      in
      "[${name}]\n" + (concatStringsSep "\n" (mapAttrsToList renderOption section));
  in
  concatStringsSep "\n\n" (mapAttrsToList renderSection wayfire-config);
}
