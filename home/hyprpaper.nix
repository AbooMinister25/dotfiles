{ config, pkgs, ... }:

{
  home.file.".config/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };
  
  services.hyprpaper = {
    enable = true;
    settings = {      
      preload = [
        "~/.config/wallpapers/jeff-ostberg-cozy-autumn-rain.jpg"
      ];

      wallpaper = [
        ",~/.config/wallpapers/jeff-ostberg-cozy-autumn-rain.jpg" 
      ];
    };
  };
}
