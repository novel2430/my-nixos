{ pkgs, ...}:
{
  xdg.portal = {
    enable = true;
    config.common.default = "gtk";
    extraPortals = [ 
      pkgs.unstable.xdg-desktop-portal-gtk
      pkgs.unstable.xdg-desktop-portal-wlr
    ];
  };
}
