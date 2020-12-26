{
  description = "Python package vedo";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = "github:numtide/flake-utils";
    vedo = {
      url = "github:marcomusy/vedo";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... } @ inputs:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] ( system:
      let pkgs = nixpkgs.legacyPackages.${system}; in rec {
        packages = {
          python37 = let packageOverrides = python-self : python-super: {
            vedo = python-self.callPackage ./vedo.nix {
              src = inputs.vedo;
            };
            vtk = python-super.toPythonModule (pkgs.vtk.override {
              enablePython = true;
              python = packages.python37;
            });
          }; in pkgs.python37.override { inherit packageOverrides; };
        };
        defaultPackage = packages.python37.withPackages (
          ps: with ps; [ vedo matplotlib ]
        );
      }
    );
}
