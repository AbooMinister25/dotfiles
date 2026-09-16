{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "Gruvbox Material Dark";
      font-size = 10;
      window-padding-x = 10;
    };
  };
}