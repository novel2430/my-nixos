{lib, opt-config, ... }:
{
  imports = 
    [
    ]
    ++
    lib.optionals (opt-config.use-clash == true) [
      ./mihomo.nix
    ]
    ++
    lib.optionals (opt-config.use-zju-rvpn == true) [
      ./zju-connect.nix
    ]
  ;

}

