{ lib, stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "everforest-cursors";
  version = "3212590527";

  src = fetchurl {
    url = "https://github.com/talwat/everforest-cursors/releases/download/${version}/everforest-cursors-variants.tar.bz2";
    sha256 = "1rcabdbnacjzmck8xjrx9g23vs0s0iiwm6215p3bm38vvhvjsy65";
  };

  sourceRoot = ".";

  installPhase = ''
  runHook preInstall
  mkdir -p $out/share/icons
  cp -r ./everforest-cursors* $out/share/icons
  runHook postInstall
  '';
}
