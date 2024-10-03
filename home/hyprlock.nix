{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
      };

      background = {
        monitor = "";
        path = "~/.config/wallpapers/jeff-ostberg-cozy-autumn-rain.jpg";
        blur_passes = 2;
      };

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%A\")\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 90;
          font_family = "Iosevka Nerd Font";
          position = "0, 350";
          halign = "center";
          valign = "center";
        }

        {
          monitor = "";
          text = "cmd[update:1000] echo -e \"$(date +\"%d %B\")\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 40;
          font_family = "Iosevka Nerd Font";
          position = "0, 250";
          halign = "center";
          valign = "center";
        }

        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date +\"- %I:%M -\")</span>\"";
          color = "rgba(216, 222, 233, 0.70)";
          font_size = 20;
          font_family = "Iosevka Nerd Font";
          position = "0, 190";
          halign = "center";
          valign = "center";
        }

        {
          monitor = "";
          text = "    $USER";
          color = "rgba(216, 222, 233, 0.80)";
          font_size = 18;
          font_family = "Iosevka Nerd Font";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];

      shape = {
        monitor = "";
        size = "300, 60";
        color = "rgba(255, 255, 255, .1)";
        rounding = -1;
        border_size = 0;
        border_color = "rgba(255, 255, 255, 0)";
        rotate = 0;
        xray = false;
        position = "0, -130";
        halign = "center";
        valign = "center";
      };

      input-field = {
        monitor = "";
        size = "300, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = false;
        outer_color = "rgba(255, 255, 255, 0)";
        inner_color = "rgba(255, 255, 255, 0.1)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        placeholder_text = "<i>Enter Password...</i>";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";

        position = "0, -210";
        halign = "center";
        valign = "center";
      };
    };
  };
}
