{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "aboominister@gmail.com";
    userName = "AbooMinister25";
    delta.enable = true;
  };
}