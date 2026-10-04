{ config, pkgs-unstable, ... }:

{
	programs.mangohud = {
		enable = true;
		settings = {
			fps = true;
			vram = true;
			ram = true;
			font_size = 12;
#			position = "top-right";
			frame_timing = false;
			horizontal = true;
			hud_compact = true;
			background_alpha = 0;
			no_display = true;
		};
	};
}
