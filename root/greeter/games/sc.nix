{
	stdenv,
	pkgs,
}:
pkgs.writeShellScriptBin "star-citizen" ''gamescope -e -r 165 --adaptive-sync --hdr-enabled -W 2560 -H 1600 --force-grab-cursor -- rsi-launcher''
