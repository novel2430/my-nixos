{lib, opt-config, modify-pkgs, ...}:
{
  imports = [
    ./ssh
    ./git
    ./bash
    ./brave
    ./zsh
    ./fcitx5
    ./wayfire
    ./theme
    ./foot
    ./dunst
    ./wofi
    ./neovim
    ./tmux
    ./mimetype
    ./fzf
    ./hypr
  ]
  ;
}
