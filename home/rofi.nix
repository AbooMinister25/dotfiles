{ config, pkgs, ... }:

{
  home.file.".config/rofi/" = {
    source = ./rofi;
    recursive = true;
  };
}
