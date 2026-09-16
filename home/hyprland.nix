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
}
