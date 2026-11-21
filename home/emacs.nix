{ config, pkgs-unstable, ... }:

{
	programs.emacs = {
		enable = true;
		package = pkgs-unstable.emacs-pgtk;
		extraPackages = epkgs: [
			epkgs.treesit-grammars.with-all-grammars
		];
	};

	xdg.configFile."emacs".source =
		config.lib.file.mkOutOfStoreSymlink config.home.homeDirectory + "/nixos-config/home/emacs";
}
