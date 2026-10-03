{ config, pkgs, ... }:

{
	services.ssh-agent.enable = true;
	programs.ssh = {
		enable = true;
		addKeysToAgent = "yes";
		matchBlocks = {
			"github.com" = {
				identityFile = "~/.ssh/id_ed25525";
				extraOptions = {
					StrictHostKeyChecking = "accept-new";
				};
			};
		};
	};
}
