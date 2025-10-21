{pkgs}:
pkgs.writeShellScript "bash-gamemode" ''gamescope -e --adaptive-sync -- steam -gamepadui"''
