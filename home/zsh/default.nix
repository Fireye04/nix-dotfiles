{
	lib,
	config,
	pkgs,
	...
}: {
	home.file = {
		".p10k.zsh" = {
			source = ./p10k.zsh;
			executable = true;
		};
	};
	home.file = {
		".config/zsh/bin/post.sh" = {
			source = ./bin/post.sh;
			executable = true;
		};
	};
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		defaultKeymap = "viins";
		history.size = 10000;
		shellAliases = {
			ginit = "nvim . --listen ./godothost";
			post = "~/.config/zsh/bin/post.sh";
		};
		plugins = [
			{
				name = pkgs.zsh-autosuggestions.pname;
				src = pkgs.zsh-autosuggestions.src;
			}
			{
				name = pkgs.zsh-syntax-highlighting.pname;
				src = pkgs.zsh-syntax-highlighting.src;
			}
			{
				name = pkgs.zsh-powerlevel10k.pname;
				src = pkgs.zsh-powerlevel10k.src;
			}
		];
		oh-my-zsh = {
			enable = true;
			plugins = [
				"git"
				"autojump"
			];
		};
		initContent = let
			zshConfigEarlyInit =
				lib.mkOrder 500 ''							
					awk '{if ($1 > 2*24*3600)
					print "PC has been running for over 2 days, might wanna restart"}' /proc/uptime
					if [[ -r "$\{XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$\{(%):-%n}.zsh" ]]; then
					  source "$\{XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$\{(%):-%n}.zsh"
					fi'';
			zshConfig =
				lib.mkOrder 1500 ''
					[[ ! -f ~/.p10k.zsh ]] || source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
					source ~/.p10k.zsh
				'';
		in
			lib.mkMerge [zshConfigEarlyInit zshConfig];
		setOptions = [
		];
	};
}
