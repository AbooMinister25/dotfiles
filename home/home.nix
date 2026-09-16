{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    (import ./noctalia.nix { inherit inputs; })
    (import ./hyprland.nix { inherit inputs; })
    ./fish.nix
    ./vscode.nix
    ./git.nix
    ./ghostty.nix
  ];

  home.username = "rayyanc";
  home.homeDirectory = "/home/rayyanc";

  home.pointerCursor = {
    enable = true;
    package = inputs.self.packages.${pkgs.system}.oblique-cursors;
    name = "oblique-cursor";
    size = 24;
    gtk.enable = true;
  };

  home.sessionVariables = {
    TERM = "ghostty";
    BROWSER = "firefox";
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.packages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Desktop Utilities
    inputs.hyprpolkitagent.packages.${pkgs.stdenv.hostPlatform.system}.default
    grim
    slurp
    wl-clipboard
    cliphist
    playerctl
    brightnessctl
    qt6Packages.qt6ct

    # Applications
    firefox
    discord
    bitwarden-desktop
    obsidian
    darktable
    stremio-linux-shell

    # Tools
    neovim
    eza
    ripgrep
    bat
    procs
    dust
    tokei
    bottom
    broot
    delta
    jq
    fzf
    grex
    xh
    fastfetch
    nixfmt
  ];

  home.stateVersion = "26.11";

  programs.home-manager.enable = true;
}
