{ inputs, ... }: { config, pkgs, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];
  programs.ags = {
    enable = true;
    configDir = ./ags;

    extraPackages = with pkgs; [
      libnotify
    ];
  };
}
