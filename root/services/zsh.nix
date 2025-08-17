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
			gaa = "git add --all";
			gc = "git commit";
			gp = "git push";
			gst = "git status";
		};
	};
}
