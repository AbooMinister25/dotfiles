{ inputs, hyprlandPkg, ... }:
{ config, pkgs, ... }:

let
  smwSrc = pkgs.fetchFromGitHub {
    owner = "zjeffer";
    repo = "split-monitor-workspaces";
    rev = "v0.56.0";
    hash = "sha256-XVm8Bi8XasjMP2VOisrPAuJvrB6+rQZW+/TL9kr2Ogs=";
  };
  hyprbarsPkg =
    inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprbars.overrideAttrs
      (old: {
        buildInputs = map (
          input: if (input.pname or null) == "hyprland" then hyprlandPkg.dev else input
        ) old.buildInputs;
      });
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
      hyprbarsPkg
      inputs.gloview.packages.${pkgs.system}.gloview
    ];
  };

  xdg.configFile."hypr/plugins/split-monitor-workspaces".source = smwSrc;
}
