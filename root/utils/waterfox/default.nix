{
	stdenv,
	fetchurl,
}:
stdenv.mkDerivation rec {
	name = "waterfox-${version}";
	version = "6.6.7";
	src =
		fetchurl {
			url = "https://cdn.waterfox.com/waterfox/releases/6.6.7/Linux_x86_64/waterfox-6.6.7.tar.bz2";
			hash = "";
		};
}
