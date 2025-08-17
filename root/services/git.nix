{
	config,
	pkgs,
	...
}: {
	programs.git = {
		enable = true;
		config = {
			init = {
				defaultBranch = "main";
			};
			user.name = "Fireye";
			user.email = "codekai16@gmail.com";
			core.editor = "nvim";
		};
	};
}
