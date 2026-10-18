{
  inputs,
  hyprlandPkg,
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  imports = [
    (import ./noctalia.nix { inherit inputs; })
    (import ./hyprland.nix { inherit inputs hyprlandPkg; })
    ./fish.nix
    ./vscode.nix
    ./git.nix
    ./ghostty.nix
    ./snappy-switcher.nix
    ./emacs.nix
    ./ssh.nix
    ./mangohud.nix
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
    PROTON_ENABLE_NVAPI = 1;
    NIXOS_OZONE_WL = "1";
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
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
    inputs.snappy-switcher.packages.${pkgs.system}.default
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
    prismlauncher
    cloudflare-warp
    pkgs-unstable.protonplus
    pkgs-unstable.super-productivity
    inputs.self.packages.${pkgs.system}.nuvio-desktop

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
    koboldcpp
    pkgs-unstable.codex
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
  ];

  home.stateVersion = "26.11";

  programs.home-manager.enable = true;
}
