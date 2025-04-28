{ inputs, ... }: { config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      exec-once = [
        "ags"
        "swaync"
        "systemctl --user start plasma-polkit-agent"
      ];

      monitor = [
        "DP-1, 2560x1440@165, auto, 1"
        "HDMI-A-1, 1920x1080, auto-left, 1"
        "Unknown-1, disable"
      ];

      env = [
        "LIBVA_DRIVER_NAME, nvidia"
        "XDG_SESSION_TYPE, wayland"
        "GBM_BACKEND, nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME, nvidia"
        "WLR_NO_HARDWARE_CURSORS, 1"
        "AQ_DRM_DEVICES, /dev/dri/card1"
        "TERM, wezterm"
        "XCURSOR_THEME, everforest-cursors"
        "MOZ_ENABLE_WAYLAND, 0"
      ];

      "$mod" = "SUPER";
      bind = [
        "$mod, B, exec, firefox"
        "$mod, Return, exec, wezterm"
        "$mod, C, killactive"
        "$mod, Tab, focuscurrentorlast"
        "$mod, Left, split-workspace, r-1"
        "$mod, Right, split-workspace, r+1"
        "$mod, F, fullscreen"
        "$mod, X, togglefloating"
        "$mod, A, exec, ags"
        "$mod Shift, S, exec, grim -g \"$(slurp)\" - | satty --filename -"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ]
      ++ (
        # binds $mod + {1..9} to move to workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, split-workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, split-movetoworkspace, ${toString ws}"
          ]
        )
        9) 
      );

      bindm = [
        "$mod, mouse:273, resizewindow"
        "$mod, mouse:272, movewindow"
      ];

      bindr = [
        "SUPER, SUPER_L, exec, anyrun"
        # "SUPER, SUPER_L, exec, rofi -show drun -modi 'exp:~/.config/rofi/scripts/expand.sh' -kb-custom-1 'ctrl+x' -theme ~/.config/rofi/style-6.rasi"
      ];

      layerrule = [
        "blur, rofi"
      ];
    };

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];
  };
}
