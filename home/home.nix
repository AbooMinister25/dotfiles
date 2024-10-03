{ config, pkgs, pkgs-unstable, inputs, ... }:

let
  everforest-cursors = pkgs.callPackage ../packages/everforest-cursors.nix { };
in
{
  imports = [
    (import ./hyprland.nix  { inherit inputs; })
    (import ./firefox.nix  { inherit inputs; })
    ./hyprlock.nix
    ./hyprpaper.nix
    ./ags.nix
    ./wezterm.nix
    ./rofi.nix
    ./fish.nix
    ./hypridle.nix
    ./satty.nix
    ./playerctl.nix
    ./git.nix
    ./direnv.nix
  ];
  
  home.username = "rcyclegar";
  home.homeDirectory = "/home/rcyclegar";

  home.sessionVariables = {
    TERM = "wezterm";
    XCURSOR_THEME = "everforest-cursors";
    XCURSOR_SIZE = "28";
  };

  home.pointerCursor = {
    name = "everforest-cursors";
    package = everforest-cursors;
    size = 28;
    gtk.enable = true;
  };

  fonts.fontconfig.enable = true;
  gtk.font = {
    name = "Ubuntu Nerd Font";
    package = pkgs.nerdfonts.override { fonts = [ "Ubuntu" ]; };
    size = 12;
  };
  gtk.theme.name = "adw-gtk3-dark";
  gtk.theme.package = pkgs.adw-gtk3;

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  home.packages = with pkgs; [
    # Utilities
    eza
    ripgrep
    bat
    procs
    du-dust
    tokei
    bottom
    broot
    delta
    jq
    fzf
    grex
    xh
    neofetch
    rofi-wayland
    brightnessctl
    wl-clipboard
    grim
    slurp

    # Applications
    discord
    vscode
    spotify
    vial
    bitwarden-desktop

    # Development
    nil
    dart-sass

    # AGS
    ags

    # Fonts
    ( nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
  ] ++ [
    pkgs-unstable.satty
    pkgs-unstable.nwg-dock-hyprland
  ];

  programs.kitty.enable = true;
  services.ssh-agent.enable = true;

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
