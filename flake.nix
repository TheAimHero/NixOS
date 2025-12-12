{
  description = "Init";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    catppuccin.url = "github:catppuccin/nix/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, catppuccin, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        LaptopNix = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix catppuccin.nixosModules.catppuccin ];
        };
      };
      homeConfigurations = {
        vedant = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix catppuccin.homeModules.catppuccin ];
        };
      };
    };
}
