{ config, lib, pkgs, modify-pkgs, inputs, opt-config, ... }:
{
  home.username = "${opt-config.username}";
  home.homeDirectory = "/home/${opt-config.username}";

  imports = [
    ./modules
  ];

  home.packages = 
    (with pkgs;[
      neofetch
      socat
      nerdfonts
      upower
      obs-studio
      glxinfo
      wqy_zenhei
      noto-fonts-color-emoji
      papirus-icon-theme
      pavucontrol
      celluloid
      gedit
      cinnamon.nemo-with-extensions
      gsettings-desktop-schemas
      gtk3
      amberol
      zathura
      image-roll
      shotcut
      spotify
      motrix
      gnome.file-roller
      wl-clipboard
      # Unstable
      # NUR
      nur.repos.novel2430.zju-connect
      nur.repos.novel2430.wpsoffice-cn
      nur.repos.xddxdd.baidunetdisk
      nur.repos.xddxdd.dingtalk
      nur.repos.xddxdd.qq

      modify-pkgs.hmcl
    ])
    ;

  # XDG_DATA_DIRS
  xdg.systemDirs.data = [
    "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
    # flatpak
    # "/var/lib/flatpak/exports/share"
    # "$HOME/.local/share/flatpak/exports/share"
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
