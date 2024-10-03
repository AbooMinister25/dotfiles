{ config, pkgs, ... }:

{
  home.file.".config/satty" = {
    source = ./satty;
    recursive = true;
  };
}
