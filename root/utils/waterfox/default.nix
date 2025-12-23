{
	stdenv,
	fetchurl,
}:
stdenv.mkDerivation {
	version = "6.6.7";
	name = "waterfox";
	src =
		fetchurl {
			url = "https://cdn.waterfox.com/waterfox/releases/6.6.7/Linux_x86_64/waterfox-6.6.7.tar.bz2";
			hash = "sha256-/R2rQkYPJ8boC/hHK39UuIkKyAHjaW+t7s5aaWZYTTI=";
		};
	installPhase = ''
		mkdir -p $out/bin
		chmod +x $out
		    echo '#!/bin/bash' > $out
		    echo 'echo "Hello, World!"' >> $out
	'';
}
