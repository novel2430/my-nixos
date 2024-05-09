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
    # Neovim Vscode ColorScheme
    nvim-vscode-color = {
      url = "github:Mofiqul/vscode.nvim";
      flake = false;
    };
    # NUR
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, nur, ... }@inputs:
  let
    system = "x86_64-linux";
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
    allowed-insecure-packages = [
      "electron-11.5.0"
      "openssl-1.1.1w"
    ];
    # host = "LENOVO-Torronto-5C2";
    # host = "Timi-TM1701";
    LO = (import ./hosts/LENOVO-Torronto-5C2/options.nix).opt-config;
  in
  {
    nixosConfigurations.LENOVO-Torronto-5C2 = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit allowed-unfree-packages;
        inherit allowed-insecure-packages;
        # inherit (import ./hosts/LENOVO-Torronto-5C2/options.nix) opt-config;
        opt-config = LO;
      };
      modules = [
        # Add NUR
        { nixpkgs.overlays = [ nur.overlay ]; }
        # Add Unstable Nixpkg
        ({
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                inherit system;
                config.allowUnfreePredicate = allowed-unfree-packages;
                config.permittedInsecurePackages = allowed-insecure-packages;
              };
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
          home-manager.users.novel2430 = import ./home;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            # inherit (import ./hosts/LENOVO-Torronto-5C2/options.nix) opt-config;
            opt-config = LO;
          };
        }
      ];
    };
  };
}
