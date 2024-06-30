{pkgs, unstable-pkgs, ... }:
{
  wemeet-bin-bwrap = pkgs.callPackage ./wemeet-bin-bwrap { };
  wechat-universal-bwrap = unstable-pkgs.callPackage ./wechat-universal-bwrap { };
  vscode-nvim = import ./vscode-nvim { pkgs=pkgs; };
  wpsoffice = pkgs.libsForQt5.callPackage ./wpsoffice { };
  gtk4-12-5 = pkgs.callPackage ./gtk4-12-5 { };
}
