# vedo-flake
Nix flake for the Python module vedo

Vedo likes VTK version 8, so that's what I used. VTK 8 doesn't like Python 3.8, so I used 3.7. If you need 3.8, then check the VTK expressions in nixpkgs and change to VTK 9.

## Usage

`nix run github:marcus7070/vedo-flake` will drop you into a Python interpreter with vedo available. Or you can use it in your own flakes with something like:
```nix
inputs = {
  vedo.url = "github:marcus7070/vedo";
};
```
