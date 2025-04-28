{ config, pkgs, pkgs-unstable, inputs, ... }:

let
  everforest-cursors = pkgs.callPackage ../packages/everforest-cursors.nix { };
in
{
  imports = [
    (import ./hyprland.nix  { inherit inputs; })
    (import ./ags.nix  { inherit inputs; })
    (import ./firefox.nix  { inherit inputs; })
    ./hyprlock.nix
    ./hyprpaper.nix
    ./wezterm.nix
    ./rofi.nix
    ./fish.nix
    ./hypridle.nix
    ./satty.nix
    ./playerctl.nix
    ./git.nix
    ./direnv.nix
    inputs.anyrun.homeManagerModules.default
    inputs.walker.homeManagerModules.default
  ];
  
  home.username = "rcyclegar";
  home.homeDirectory = "/home/rcyclegar";

  home.sessionVariables = {
    TERM = "wezterm";
    BROWSER = "firefox";
    XCURSOR_THEME = "everforest-cursors";
    XCURSOR_SIZE = "28";
    SSH_AUTH_SOCK = "/run/user/$(id -u)/keyring/ssh";
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

  # home.file.".config/nwg-dock-hyprland" = {
  #   source = ./nwg-dock-hyprland;
  #   recursive = true;
  # };

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
    playerctl
    xdg-utils

    # Applications
    discord
    spotify
    vial
    bitwarden-desktop
    easyeffects
    #google-chrome
    via

    # Development
    nil
    dart-sass
    devenv

    hyprpanel

    chezmoi

    # Fonts
    ( nerdfonts.override { fonts = [ "FiraCode" "Iosevka" "JetBrainsMono" ]; })
  ] ++ [
    pkgs-unstable.satty
    pkgs-unstable.nwg-dock-hyprland
    inputs.astal.packages.${system}.default
    inputs.anyrun.packages.${system}.anyrun
  ];

  programs.kitty.enable = true;
  services.gnome-keyring.enable = true;
  services.gnome-keyring.components = [
    "ssh"
    "secrets"
  ];

  programs.anyrun = {
    enable = true;
    config = {
      x = {fraction = 0.5;};
      y = {fraction = 0.2;};
      hidePluginInfo = true;
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.dictionary
        inputs.anyrun.packages.${pkgs.system}.rink
        inputs.anyrun.packages.${pkgs.system}.shell
        inputs.anyrun.packages.${pkgs.system}.translate
        inputs.anyrun.packages.${pkgs.system}.websearch
        inputs.anyrun.packages.${pkgs.system}.kidex
      ];
      showResultsImmediately = true;
      width = { absolute = 600; };
      maxEntries = 8;
    };

    extraCss = ''
/* GTK Vars */
@define-color bg-color #232A2E;
@define-color fg-color #D3C6AA;
@define-color primary-color #475258;
@define-color secondary-color #A7C080;
@define-color border-color @primary-color;
@define-color selected-bg-color @primary-color;
@define-color selected-fg-color @fg-color;

* {
  all: unset;
  font-family: JetBrainsMono Nerd Font;
}

#window {
  background: transparent;
}

box#main {
  border-radius: 10px;
  background-color: alpha(@bg-color, 0.9);
  border: 0.5px solid alpha(@fg-color, 0.25);
}

entry#entry {
  background: transparent;
  box-shadow: none;
  border: none;
  border-radius: 16px;
  padding: 16px 24px;
  min-height: 30px;
  caret-color: @primary-color;
}

list#main {
  background-color: transparent;
}

#plugin {
  background-color: transparent;
  padding-bottom: 4px;
}

#match {
  font-size: 1.1rem;
  padding: 2px 4px;
}

#match:selected,
#match:hover {
  background-color: @selected-bg-color;
  color: @selected-fg-color;
}

#match:selected label#info,
#match:hover label#info {
  color: @selected-fg-color;
}

#match:selected label#match-desc,
#match:hover label#match-desc {
  color: alpha(@selected-fg-color, 0.9);
}

#match label#info {
  color: transparent;
  color: @fg-color;
}

label#match-desc {
  font-size: 1rem;
  color: @fg-color;
}

label#plugin {
  font-size: 16px;
}
    '';

    extraConfigFiles = {
      "applications.ron".text = ''
      Config(
        desktop_actions: true
        terminal: Some("wezterm")
      )
      '';
    };
  };

  programs.walker = {
    enable = true;
    runAsService = true;
  };

  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode.fhs;
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
