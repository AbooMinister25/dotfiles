{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      "ls" = "eza --icons";
      "blah" = "eza";
    };
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellInit = ''
    tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Sparse --icons='Many icons' --transient=No
    '';
    shellInitLast = ''
    direnv hook fish | source
    '';
    plugins = [
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    ];
  };
}