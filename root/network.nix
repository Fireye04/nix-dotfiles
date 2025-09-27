{
	config,
	pkgs,
	...
}: {
	# Enable networking
	networking.networkmanager.enable = true;

	networking.hostName = "nixlaptop"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Pipewire
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true; # if not already enabled
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		# If you want to use JACK applications, uncomment the following
		jack.enable = true;
	};

	#bluetooth
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		settings = {
			General = {
				Experimental = true; # Show battery charge of Bluetooth devices
			};
		};
	};
	services.blueman.enable = true;
}
