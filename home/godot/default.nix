{
	config,
	pkgs,
	...
}: {
	home.file = {
		".config/godot/custom/run.sh" = {
			source = ./run.sh;
			executable = true;
		};

		".local/share/godot/export_templates/${builtins.replaceStrings ["-"] ["."] pkgs.godotPackages.export-template-mono.version}.mono".source = "${pkgs.godotPackages.export-template-mono.outPath}/share/godot/export_templates/${builtins.replaceStrings ["-"] ["."] pkgs.godotPackages.export-template-mono.version}.mono";
	};
}
