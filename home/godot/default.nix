{
	config,
	pkgs,
	...
}: {
	home.file = {
		".config/godot/custom" = {
			source = ./bin/randomize_multi.sh;
			executable = true;
		};

		".local/share/godot/export_templates/${builtins.replaceStrings ["-"] ["."] pkgs.godotPackages.export-template-mono.version}.mono".source = "${pkgs.godotPackages.export-template-mono.outPath}/share/godot/export_templates/${builtins.replaceStrings ["-"] ["."] pkgs.godotPackages.export-template-mono.version}.mono";
	};
}
