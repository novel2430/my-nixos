{ pkgs, ... }:
{
  hmcl = (import ./hmcl.nix { pkgs=pkgs; }).hmcl;
}
