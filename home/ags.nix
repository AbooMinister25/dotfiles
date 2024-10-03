{ config, pkgs, ... }:

{
  home.file.".config/ags" = {
    source = ./ags;
    recursive = true;
  };
}
