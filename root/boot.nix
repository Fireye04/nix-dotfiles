{
	config,
	pkgs,
	...
}: {
	boot.loader = {
		grub = {
			enable = true;
			efiSupport = true;
			devices = ["nodev"];
			useOSProber = false;
			memtest86.enable = true;
			extraEntries = ''					
				menuentry "UEFI Settings" {fwsetup}'';

			#  extraEntries = ''menuentry "ARCH" {
			# set root=(hd0,gpt2)
			# linux /boot/vmlinuz-linux root=/dev/nvme0n1p2
			# initrd /boot/initramfs-linux.img
			# boot
			#
			#  }'';
		};

		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot";
		};
	};
}
