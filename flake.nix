{
  description = "Dendritic Hyprland Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    wrappers.url = "github:nix-community/nix-wrapper-modules";
  };

  outputs = {
    self,
    nixpkgs,
    wrappers,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    runtimePkgs = with pkgs; [
      foot
      waybar
    ];

    mkWrapper = {
      pkgs,
      package,
      runtimePkgs,
      env,
      flags,
    }: (wrappers.lib.wrapPackage ({...}: {
      inherit pkgs package runtimePkgs env flags;
    }));
  in {
    lib.runtimePkgs.${system} = runtimePkgs;
    packages.${system} = {
      default = pkgs.lib.makeOverridable mkWrapper {
        inherit pkgs;
        package = pkgs.hyprland;
        runtimePkgs = runtimePkgs;
        env."HYPRLAND_ROOT" = ./.;
        flags."--config" = ./hyprland.lua;
      };
    };
  };
}
