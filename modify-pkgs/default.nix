{ pkgs, unstable-pkgs, nix23-pkgs, custom-pkgs, ... }:
{
  hmcl = (import ./hmcl.nix { pkgs=pkgs; }).hmcl;
  openttd = (import ./openttd.nix { pkgs=pkgs; }).openttd;
  brave = (import ./brave.nix { 
    pkgs = pkgs; 
    unstable-pkgs = unstable-pkgs;
    nix23-pkgs = nix23-pkgs;
    custom-pkgs = custom-pkgs;
  }).brave;
}
