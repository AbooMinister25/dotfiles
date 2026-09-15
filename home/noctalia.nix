{ inputs, ... }:
{ config, pkgs, ... }:

{
  programs.noctalia = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catpuccin";
      };
    };
  };
}
