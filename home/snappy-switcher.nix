{ config, pkgs, ... }:

{
  home.file.".config/snappy-switcher" = {
    source = ./snappy-switcher;
    recursive = true;
  }
}