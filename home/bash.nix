{
	config,
	pkgs,
}: {
	programs.bash = {
		enable = true;
		# bashrcExtra = "amixer sset Master unmute\n
		# 	amixer sset Speaker unmute\n
		# 	amixer sset Headphone unmute";
		shellAliases = {
			GS = "gamescope -e --adaptive-sync -- steam -gamepadui";
			ninit = "cd /etc/nixos;nvim .";
			update = "sudo nixos-rebuild switch";
			gupdate = "git add --all;git commit -m 'rev';git push;sudo nixos-rebuild switch";
			nixupdate = "git branch -D update;git checkout -b update;git add --all;git commit -m 'update';git push;nix flake update;sudo nixos-rebuild switch";
			gaa = "git add --all";
			gc = "git commit";
			gp = "git push";
			gst = "git status";
			gco = "git checkout";
			gcb = "git checkout -b";
			g = "git";
			grb = "git rebase";
			gl = "git pull";
			v = "nvim .";
		};
	};
}
