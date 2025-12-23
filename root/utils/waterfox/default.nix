{
	stdenv,
	fetchurl,
	makeDesktopItem,
	autoPatchelfHook,
}:
stdenv.mkDerivation rec {
	pname = "waterfox";
	version = "6.6.7";
	src =
		fetchurl {
			url = "https://cdn.waterfox.com/waterfox/releases/${version}/Linux_x86_64/waterfox-${version}.tar.bz2";
			hash = "sha256-/R2rQkYPJ8boC/hHK39UuIkKyAHjaW+t7s5aaWZYTTI=";
		};

	nativeBuildInputs = [
		autoPatchelfHook
	];
	sourceRoot = ".";
	installPhase = ''
		install -m755 $out/waterfox
	'';
	# desktopItems = [
	# 	(makeDesktopItem {
	# 			name = "waterfox";
	# 			desktopName = "waterfox";
	# 			exec = "";
	# 		})
	# ];
}
