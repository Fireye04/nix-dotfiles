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
			gupdate = "sudo nixos-rebuild switch;git add --all;git commit -m 'rev';git push";
			gaa = "git add --all";
			gc = "git commit";
			gp = "git push";
			gst = "git status";
			arch = "docker run -it archlinux:latest sh";
		};
	};
}
