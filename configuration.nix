{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "rayyanc-desktop";
    networkmanager.enable = true;
  };

  time.timeZone = "America/New_York";

  services = {
    xserver.videoDrivers = ["nvidia"];
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --issue --user-menu --remember --cmd Hyprland --remember-user-session --asterisks";
          user = "greeter";
        };
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    udev.packages = [ pkgs.via ];
    gnome.gnome-keyring.enable = true;
    #desktopManager = {
     # cosmic = {
      #  enable = true;
      #};
    #};
    #displayManager = {
     # cosmic-greeter = {
      #  enable = true;
      #};
    #};
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    xwayland = {
      enable = true;
    };
    fish = {
      enable = true;
    };
    seahorse = {
      enable = true;
    };
    virt-manager.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "555.58.02";
      #   sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      #   sha256_aarch64 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      #   openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      #   settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      #   persistencedSha256 = lib.fakeSha256;
      # };
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
  
  security = {
    pam.services = {
      hyprlock = {};
      greetd.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
    rtkit = {
      enable = true;
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://hyprland.cachix.org" "https://cosmic.cachix.org/" "https://anyrun.cachix.org" "https://walker.cachix.org" "https://walker-git.cachix.org"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
        "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };  
  };

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
    libvirtd = {
      enable = true;
    };
    spiceUSBRedirection = {
      enable = true;
    };
  };

  users.users.rcyclegar = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" ];
    shell = pkgs.fish;
  };

  users.groups.libvirtd.members = ["rcyclegar"];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # Hyprland stuff
    hyprlock
    hyprpaper
    hyprcursor
  
    vim
    wget
    git
    helix

    # Notifications
    swaynotificationcenter

    # Authentication Agent
    polkit-kde-agent

    vulkan-tools
  ];

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
  system.stateVersion = "24.05"; # Did you read the comment?

}

