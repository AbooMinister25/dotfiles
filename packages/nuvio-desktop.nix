{ pkgs }:

let
  pname = "nuvio-desktop";
  version = "0.1.24-alpha";

  src = pkgs.fetchurl {
    url = "https://github.com/NuvioMedia/NuvioDesktop/releases/download/${version}/Nuvio-Linux-x86_64-${version}.AppImage";
    hash = "sha256-ZyXTDMhtD2XLsoK58qjGI9XP7iXHuHrTuvsVhAeNN2A=";
  };

  appimageContents = pkgs.appimageTools.extractType2 {
    inherit pname version src;
  };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs =
    pkgs: with pkgs; [
      alsa-lib
      brotli
      bzip2
      expat
      fontconfig
      freetype
      stdenv.cc.cc.lib
      glib-networking
      glibc
      gst_all_1.gst-libav
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-base
      libbsd
      libglvnd
      libpng
      xorg.libX11
      xorg.libXcomposite
      xorg.libXext
      xorg.libXi
      xorg.libXrender
      xorg.libXtst
      mpv
      webkitgtk_4_1
      xdg-utils
    ];

  extraInstallCommands = ''
    install -Dm644 \
      ${appimageContents}/Nuvio.desktop \
      $out/share/applications/nuvio-desktop.desktop

    install -Dm644 \
      ${appimageContents}/Nuvio.png \
      $out/share/icons/hicolor/512x512/apps/Nuvio.png

    substituteInPlace $out/share/applications/nuvio-desktop.desktop \
      --replace-fail 'Exec=AppRun %u' 'Exec=nuvio-desktop %u'
  '';
  meta = with pkgs.lib; {
    description = "Nuvio Desktop — alpha media client";
    homepage = "https://github.com/NuvioMedia/NuvioDesktop";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
