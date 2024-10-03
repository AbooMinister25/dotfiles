{
  config, pkgs, ...
}:

{
  programs.wezterm.enable = true;
  home.file.".config/wezterm" = {
    source = ./wezterm;
    recursive = true;
  };
}
