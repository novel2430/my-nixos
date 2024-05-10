{pkgs, unstable-pkgs, ... }:
{
  wemeet-bin-bwrap = pkgs.callPackage ./wemeet-bin-bwrap { };
  wechat-universal-bwrap = unstable-pkgs.callPackage ./wechat-universal-bwrap { };
  vscode-nvim = import ./vscode-nvim { pkgs=pkgs; };
}