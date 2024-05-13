{ pkgs, ... }:
{
  # Tmux
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 5000;
    keyMode = "vi";
    mouse = true;
    terminal = "xterm-256color";
    extraConfig = ''
      set -g pane-base-index 1
      set -g renumber-window on
      set -as terminal-features ",*:RGB"
    '';
    plugins = with pkgs.tmuxPlugins; [
      nord 
    ];
  };
}
