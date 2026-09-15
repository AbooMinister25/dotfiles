{ pkgs }:

pkgs.stdenv.mkDerivation {
	pname = "oblique-cursor";
	version = "1.0.0";

	src = pkgs.fetchFromGitHub {
		owner = "kayxean";
		repo = "oblique-cursor";
		rev = "main";
		hash = "sha256-3NiFBsKAGoZx9fuQK4TjiKZ6NKSLK5RHFFIB3Pkwrbc=";
	};

	nativeBuildInputs = [
		pkgs.hyprcursor
	];

	installPhase = ''
	mkdir -p $out/share/icons

	hyprcursor-util \
		--create themes/oblique-cursor \
		--output $out/share/icons
	
	mv $out/share/icons/theme_oblique-cursor \
		$out/share/icons/oblique-cursor
	'';
}
