# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages;
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "nvidia-drm.fbdev=1"
      "pci=realloc"
      "nvidia-drm.modeset=1"
    ];
    blacklistedKernelModules = [ "nouveau" ];
  };

  networking = {
    hostName = "rayyanc-desktop";
    networkmanager.enable = true;
  };

  zramSwap.enable = true;

  time.timeZone = "America/New_York";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      #    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #      version = "615.71.09";
      #      sha256_64bit = lib.fakeHash;
      #      openSha256 = lib.fakeHash;
      #      settingsSha256 = lib.fakeHash;
      #      persistencedSha256 = lib.fakeHash;
      #    };
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General = {
        Experimental = true;
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services = {
      hyprlock = { };
    };
  };

  services = {
    pulseaudio.enable = false;
    udisks2.enable = true;
    gvfs.enable = true;
    devmon.enable = true;
    accounts-daemon.enable = true;
    fstrim.enable = true;
    printing.enable = true;
    xserver = {
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  programs = {
    fish.enable = true;
    dconf.enable = true;
    gamemode.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    noctalia = {
      enable = true;
      systemd.enable = true;
      package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
      recommendedServices.enable = true;
    };
    noctalia-greeter = {
      enable = true;
      greeter-args = "--session hyprland-uwsm";
      settings = {
        keyboard.layout = "us";
      };
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
        pkgs.proton-cachyos
      ];
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = [
        "hyprland"
        "gtk"
      ];
    };
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      nerd-fonts.symbols-only
      inter
      roboto
      nerd-fonts.fira-code
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font" ];
        sansSerif = [ "Inter" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget

    mangohud
    protonup-qt
  ];

  users.users."rayyanc" = {
    isNormalUser = true;
    description = "Rayyan Cyclegar";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [ vim ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
