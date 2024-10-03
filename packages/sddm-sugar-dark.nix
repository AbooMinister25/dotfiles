# {
#   lib,
#   stdenv,
#   fetchFromGithub,
#   wrapQtAppsHook,
#   qtquickcontrols2,
#   qtgraphicaleffects,
#   qtsvg
# }:

# stdenv.mkDerivation rec {
#   pname = "sddm-sugar-dark";
#   version = "v1.2";

  # src = fetchFromGithub {
  #   owner = "MarianArlt";
  #   repo = "sddm-sugar-dark";
  #   rev = "v1.2";
  #   sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
  # };

#   nativeBuildInputs = [
#     wrapQtAppsHook
#   ];
#   dontBuild = true;
#   propagatedUserEnvPkgs = [
#     qtsvg
#     qtgraphicaleffects
#     qtquickcontrols2
#   ];

#   installPhase = ''
#     mkdir -p $out/share/sddm/themes/sugar-dark
#     cp -r * $out/share/sddm/themes/sugar-dark/
#   '';
# }

{
  stdenv,
  fetchFromGitHub,
  wrapQtAppsHook,
  qtquickcontrols2,
  qtgraphicaleffects,
  qtsvg,
}:

stdenv.mkDerivation rec {
  pname = "sddm-sugar-dark";
  version = "1.2";

  src = fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "v1.2";
    sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
  };

  propagatedUserEnvPkgs = [
    qtgraphicaleffects
    qtquickcontrols2
    qtsvg
  ];

  buildInputs = [ wrapQtAppsHook ];

  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/sddm/themes/sugar-dark
    cp -r * $out/share/sddm/themes/sugar-dark/
  '';

  # meta = with lib; {
  #   description = "Catppuccin SDDM theme";
  #   homepage = "https://github.com/TiagoDamascena/sddm-sugar-catppuccin";
  #   license = licenses.gpl3Only;
  #   platforms = platforms.all;
  # }; 
}
