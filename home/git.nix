{ config, pkgs, ... }:

{
	programs.git = {
		enable = true;
		userEmail = "aboominister@gmail.com";
		userName = "AbooMinister25";
		delta.enable = true;
		signing = {
			key = "~/.ssh/id_ed25525.pub";
			signByDefault = true;
		};
		extraConfig = {
			gpg.format = "ssh";
			init.defaultBranch = "main";
		};
	};
}
