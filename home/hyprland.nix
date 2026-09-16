{ inputs, ... }:
{ config, pkgs, ... }:

let
  smwSrc = pkgs.fetchFromGitHub {
    owner = "zjeffer";
    repo = "split-monitor-workspaces";
    rev = "v0.56.0";
    hash = "sha256-XVm8Bi8XasjMP2VOisrPAuJvrB6+rQZW+/TL9kr2Ogs=";
  };
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    xwayland.enable = true;
    systemd.enable = false;

    extraConfig = ''
      		package.path = package.path .. ";" .. os.getenv("HOME") .. "./config/hypr/?.lua;" .. os.getenv("HOME") .. "/.config/hypr/?/init.lua"
      		local smw = require("plugins.split-monitor-workspaces")
      		${builtins.readFile ./hyprland/hyprland.lua}
      		'';

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars
    ];
  };

  xdg.configFile."hypr/plugins/split-monitor-workspaces".source = smwSrc;

  services.hypridle = {
    enable = true;
    package = inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      general.disable_loading_bar = false;
      background = [
        {
          path = "screenshot";
          blur_passes = 3;
        }
      ];
      input-field = [
        {
          size = "250, 60";
          placeholder_text = "Password";
          fade_on_empty = false;
        }
      ];
    };
  };
}
