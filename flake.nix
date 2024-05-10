{
  description = "My NixOS flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # Unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # HomeManager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NUR
    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nur, ... }@inputs:
  let
    system = "x86_64-linux";
    # Host Config
    # List:
    #   Default
    #   LENOVO-Torronto-5C2
    #   Timi-TM1701
    Default-conf = rec {
      name = "Default";
      config = (import ./hosts/${name}/options.nix).opt-config;
    };
    LENOVO-5C2-conf = rec {
      name = "LENOVO-Torronto-5C2";
      config = (import ./hosts/${name}/options.nix).opt-config;
    };
    Timi-TM1701-conf = rec {
      name = "Timi-TM1701";
      config = (import ./hosts/${name}/options.nix).opt-config;
    };

    # Superset of the default unfree packages
    allowed-unfree-packages = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-persistenced"
      "spotify"
      "wpsoffice-cn"
      "baidunetdisk"
      "dingtalk"
      "qq"
      "wechat-universal-bwrap"
      "wemeet-bin-bwrap"
    ];
    # Superset of the default insecure packages
    allowed-insecure-packages = [
      "electron-11.5.0"
      "openssl-1.1.1w"
    ];

    unstable-pkgs = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfreePredicate = allowed-unfree-packages;
      config.permittedInsecurePackages = allowed-insecure-packages;
    };

  in
  rec {
    # Generate Function
    system-gen = {host-conf}: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit allowed-unfree-packages;
        inherit allowed-insecure-packages;
        opt-config = host-conf.config;
        hostname = host-conf.name;
      };
      modules = [
        # Add NUR
        { nixpkgs.overlays = [ nur.overlay ]; }
        # Add Unstable Nixpkg
        ({
          nixpkgs.overlays = [
            (final: prev: {
              unstable = unstable-pkgs;
            })
          ];
        })
        # Basic Configuration
        ./nixos/configuration.nix
        # Service
        ./services/default.nix
        # Home Manager
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${host-conf.config.username} = import ./home;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            opt-config = host-conf.config;
          };
        }
      ];
    };
    # Main Config Fuction
    nixosConfigurations = {
      "${Default-conf.name}" = system-gen { host-conf = Default-conf; };
      "${LENOVO-5C2-conf.name}" = system-gen { host-conf = LENOVO-5C2-conf; };
      "${Timi-TM1701-conf.name}" = system-gen { host-conf = Timi-TM1701-conf; };
    };
  };
}
