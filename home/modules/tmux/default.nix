{ pkgs, ... }:
{
  # Tmux
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 5000;
    keyMode = "vi";
    mouse = true;
    extraConfig = ''
      set -g pane-base-index 1
      set -g renumber-window on
      set -g default-terminal xterm-256color
      set -as terminal-features ",*:RGB"
    '';
    plugins = with pkgs.tmuxPlugins; [
      nord 
    ];
  };
}
