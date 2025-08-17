{
	system,
	pkgs,
	...
}: {
	services.tuned = {
		enable = true;

		ppdSettings = {
			main = {
				default = "balanced";
			};
			profiles = {
				balanced = "balanced";
				performance = "accelerator-performance";
				power-saver = "powersave";
			};
		};
		settings = {
			daemon = true;
		};
	};
}
