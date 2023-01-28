{
  description = "Nick's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
    kmonad.url = "github:kmonad/kmonad?dir=nix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, kmonad, rust-overlay }:
    let
      user = "nixolas";
    in {
      nixosConfigurations = import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager user kmonad rust-overlay;
      };
   };
}
