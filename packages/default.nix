let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
  web-greeter = pkgs.callPackage ./web-greeter.nix { };
  sea-greeter = pkgs.callPackage ./sea-greeter.nix { };
  sddm-sugar-dark = pkgs.libsForQt5.callPackage ./sddm-sugar-dark.nix { };
  everforest-cursors = pkgs.callPackage ./everforest-cursors.nix { };
}
