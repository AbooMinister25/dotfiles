{ config, pkgs-unstable, ... }:

{
	programs.emacs = {
		enable = true;
		package = pkgs-unstable.emacs-pgtk;
	};

	xdg.configFile."emacs".source =
		config.lib.file.mkOutOfStoreSymlink config.home.homeDirectory + "/nixos-config/home/emacs";
}
