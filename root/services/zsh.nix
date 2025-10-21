{
	config,
	pkgs,
	...
}: {
	environment.pathsToLink = ["/share/zsh"];
	users.defaultUserShell = pkgs.zsh;
	programs.zsh = {
		enable = true;
		shellAliases = {
			ninit = "cd /etc/nixos;nvim .";
			update = "sudo nixos-rebuild switch";
			gupdate = "git add --all;git commit -m 'rev';git push;sudo nixos-rebuild switch";
			gaa = "git add --all";
			gc = "git commit";
			gp = "git push";
			gst = "git status";

			# Games
			no-mans-sky = "gamemoderun gamescope -- steam steam://rungameid/275850 | tee Runtime-logs.txt";
		};
	};
}
