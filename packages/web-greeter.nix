{
  stdenv,
  pkgs,
}:

stdenv.mkDerivation {
  # nodeDependencies = (pkgs.callPackage ./n2nix/nody-greeter/default.nix {}).nodeDependencies;
  pname="web-greeter";
  version="3.4.1";

  src = pkgs.fetchFromGitHub {
    owner = "JezerM";
    repo = "web-greeter";
    rev = "3.4.1";
    sha256 = "Udvr6TjLYeQw5WGBMHMcKQo8OL1rOMcCMNj+mIpcs+k=";
  };

  nativeBuildInputs = [pkgs.pkg-config pkgs.qt5.wrapQtAppsHook pkgs.rsync pkgs.typescript];
  buildInputs = with pkgs; [
    gobject-introspection
    libsForQt5.qt5.qtwebengine
    lightdm
    xorg.libX11
    xorg.libxcb
    python39Packages.pygobject3
    python39Packages.pyinotify
    python39Packages.pyqt5
    python39Packages.pyqtwebengine
    python39Packages.ruamel-yaml
  ];

  makeFlags = [ "PREFIX=" "DESTDIR=${placeholder "out"}" ];
  installFlags = [ "sysconfdir=${placeholder "out"}/etc" ];

  postInstall = ''
    substituteInPlace "$out/share/xgreeters/web-greeter.desktop" \
        --replace "Exec=web-greeter" "Exec=$out/bin/web-greeter"
  '';

  passthru.xgreeters = pkgs.linkFarm "lightdm-web-greeter-xgreeters" [{
    path = "${pkgs.lightdm-web-greeter}/share/xgreeters/web-greeter.desktop";
    name = "web-greeter.desktop";
  }];
}
