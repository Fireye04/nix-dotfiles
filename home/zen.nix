{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		inputs.zen-browser.homeModules.beta
	];

	programs.zen-browser = {
		enable = true;

		profiles."fireye".settings = {
			"zen.tabs.vertical.right-side" = true;
			"zen.urlbar.replace-newtab" = false;
			"zen.view.sidebar-expanded" = false;
			"zen.view.show-newtab-button-top" = false;
			"zen.workspaces.continue-where-left-off" = true;
		};

		policies = {
			Preferences = {
				"browser.aboutConfig.showWarning" = true;
			};
		};
	};
}
