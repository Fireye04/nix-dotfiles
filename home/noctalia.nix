{
	config,
	pkgs,
	inputs,
}: {
	# import the home manager module
	imports = [
		inputs.noctalia.homeModules.default
	];

	# configure options
	programs.noctalia-shell = {
		enable = true;
		settings = {
			# configure noctalia here
			bar = {
				density = "compact";
				position = "right";
				showCapsule = false;
				widgets = {
					left = [
						{
							id = "ControlCenter";
							useDistroLogo = true;
						}
						{
							id = "Network";
						}
						{
							id = "Bluetooth";
						}
					];
					center = [
						{
							hideUnoccupied = false;
							id = "Workspace";
							labelMode = "none";
						}
					];
					right = [
						{
							alwaysShowPercentage = false;
							id = "Battery";
							warningThreshold = 30;
						}
						{
							formatHorizontal = "HH:mm";
							formatVertical = "HH mm";
							id = "Clock";
							useMonospacedFont = true;
							usePrimaryColor = true;
						}
					];
				};
			};
			colorSchemes.predefinedScheme = "Monochrome";
			general = {
				avatarImage = "/home/fireye/Projects/Art/Aseprite/pfp.png";
				radiusRatio = 0.2;
			};
			location = {
				monthBeforeDay = true;
				name = "Phoenix";
			};
		};
		# this may also be a string or a path to a JSON file.
	};
}
