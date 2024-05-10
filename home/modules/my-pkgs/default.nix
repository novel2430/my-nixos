{pkgs, ... }:
let
  wechat-universal-bwrap = pkgs.unstable.callPackage ./wechat-universal-bwrap { };
  wemeet-bin-bwrap = pkgs.callPackage ./wemeet-bin-bwrap { };
in
{
  home.packages = [
   # wemeet-bin-bwrap
   # wechat-universal-bwrap
  ];
}
