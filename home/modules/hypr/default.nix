{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
    };
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, foot" 
        "$mod, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"
        "$mod, D, exec, wofi --show drun"
      ];
    };
  };
}
