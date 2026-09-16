{ inputs, pkgs, ... }:
let
  # No patch needed — current Hyprland's CMakeLists.txt already does a bare
  # find_package(glaze QUIET) with no version constraint, so nixpkgs' glaze
  # satisfies it regardless of version. The old "glaze 7...<8" substitution
  # (both nixpkgs' and gloview's own) is stale against this revision.
  hyprlandPkg = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

  gloview = (pkgs.hyprlandPlugins.override { hyprland = hyprlandPkg; }).mkHyprlandPlugin {
    pluginName = "gloview";
    version = "0.3.0";
    src = inputs.gloview-src;

    nativeBuildInputs = [
      pkgs.cmake
      pkgs.pkg-config
    ];
    buildInputs = [ pkgs.luajit ];

    postInstall = ''
      ln -sf gloview.so "$out/lib/libgloview.so"
    '';

    meta = {
      description = "macOS Mission Control-style overview for Hyprland";
      homepage = "https://github.com/fedsfarm/gloview";
      license = pkgs.lib.licenses.gpl3Plus;
      platforms = pkgs.lib.platforms.linux;
    };
  };
in
{
  wayland.windowManager.hyprland.plugins = [ gloview ];
}
