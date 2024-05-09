{ config, lib, pkgs, inputs, opt-config, ... }:
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
    ])
    ;

  # git
  # programs.git = {
  #   enable = true;
  #   userName = "novel2430";
  #   userEmail = "novel2430@163.com";
  # };
  # Bash
  # programs.bash = {
  #   enable = true;
  #   enableCompletion = true;
  #   # TODO 在这里添加你的自定义 bashrc 内容
  #   bashrcExtra = lib.mkMerge [
  #     (lib.mkIf (opt-config.use-proxy == true) ''
  #       export http_proxy="${opt-config.http-proxy}"
  #       export https_proxy="${opt-config.https-proxy}"
  #     '')
  #     # Other Stuff
  #     (''
  #     '')
  #   ];
  #   #shellAliases = {
  #   #};
  # };
  # Zsh
  # programs.zsh = {
  #   enable = true;
  #   enableAutosuggestions = true;
  #   oh-my-zsh.enable = true;
  #   oh-my-zsh.plugins = [ "git" ];
  #   oh-my-zsh.theme = "robbyrussell";
  #   syntaxHighlighting.enable = true;
  #   initExtra = lib.mkMerge [
  #     (lib.mkIf (opt-config.use-proxy == true) ''
  #       export http_proxy="${opt-config.http-proxy}"
  #       export https_proxy="${opt-config.https-proxy}"
  #     '')
  #     # Other Stuff
  #     (''
  #       export EDITOR="nvim"
  #     '')
  #     # FZF Stuff
  #     (''
  #       export FZF_COMPLETION_TRIGGER='\'
  #       # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
  #       # - The first argument to the function ($1) is the base path to start traversal
  #       # - See the source code (completion.{bash,zsh}) for the details.
  #       _fzf_compgen_path() {
  #         fd --follow --exclude ".git" . "$1"
  #       }
  #
  #       # Use fd to generate the list for directory completion
  #       _fzf_compgen_dir() {
  #         fd --type d --follow --exclude ".git" . "$1"
  #       }
  #     '')
  #   ];
  # };
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
