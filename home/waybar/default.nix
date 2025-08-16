{
	config,
	pkgs,
	...
}: {
	programs.waybar = {
		enable = true;
		style = ./style.css;
		settings = {
			mainBar = {
				name = "dom";
				layer = "top";
				position = "right";
				modules-left = [
					"battery"
					"wireplumber"
					"clock"
					"custom/down1"
				];
				modules-center = [
					"custom/up2"
					"niri/workspaces"
					"custom/down2"
				];
				modules-right = [
					"custom/up1"
					# "gamemode"
					"custom/power"
					"backlight"
					"cpu"
					"tray"
				];
				"custom/power" = {
					return-type = "json";
					#ONCE PATCH IS PUSHED CAN BE CHANGED TO ONCE
					interval = 1;
					format = "{}";
					exec-on-event = true;
					exec = "~/.config/waybar/bin/tuned/display.sh";
					on-click = "~/.config/waybar/bin/tuned/change.sh";
					justify = "center";
				};

				"network" = {
					justify = "center";
					format = "{icon}";
					format-wifi = "{icon}";
					format-ethernet = "󰊗";
					format-disconnected = "{icon}";
					tooltip-format = "{ifname} via {gwaddr}";
					tooltip-format-wifi = "{essid} at {signalStrength}% Strength";
					tooltip-format-ethernet = "{ifname} {ipaddr}/{cidr} ";
					tooltip-format-disconnected = "Disconnected";
					format-icons = {
						wifi = [
							"󰤯"
							"󰤟"
							"󰤢"
							"󰤥"
							"󰤨"
						];
						disconnected = "󰤭";
					};
					max-length = 50;
					on-click = "kitty nmtui";
				};
				"wireplumber" = {
					format = "{volume}%\n{icon}";
					#NOT YET ADDED
					format-bluetooth = "{volume}\n{icon} ";
					format-muted = "{volume}\n";
					format-icons = {
						headphone = "";
						hands-free = "";
						headset = "";
						phone = "";
						phone-muted = "";
						portable = "";
						car = "";
						default = [
							""
							""
							""
							""
							""
						];
					};
					justify = "center";
					scroll-step = 2;
					reverse-scrolling = true;
					on-click = "bluetoothctl connect 80:99:E7:1D:46:E5";
					on-click-right = "pwvucontrol";
					on-click-middle = "helvum";
				};
				"battery" = {
					interval = 5;
					states = {
						warning = 30;
						"critical" = 15;
					};
					justify = "center";
					format = "{capacity}%\n{icon}";
					format-icons = [
						""
						""
						""
						""
						""
					];
					format-charging = "{capacity}%\n";
					on-click = "kitty sudo powertop";
				};
				"clock" = {
					format = "{:%I\n%M\n%p}";
					justify = "center";
					format-alt = "{:%a\n%d\n%b\n%I\n%M\n%p}";
					tooltip-format = "{:%a; %d. %b %I:%M %p}";
					on-click-right = "zen-browser https://calendar.google.com/calendar/u/0/r";
				};
				"backlight" = {
					reverse-scrolling = true;
					device = "intel_backlight";
					format = "{icon}";
					format-icons = [
						"○"
						"◔"
						"◑"
						"◕"
						"●"
					];
				};
				"gamemode" = {
					format = "{glyph}";
					glyph = "";
					justify = "center";
					hide-not-running = false;
					use-icon = true;
					icon-name = "input-gaming-symbolic";
					icon-spacing = 0;
					icon-size = 20;
					tooltip-format = "Games running: {count}";
				};
				"tray" = {
					icon-size = 20;
					spacing = 10;
				};
				"cpu" = {
					interval = 10;
					format = "{usage} ";
				};
				"custom/up1" = {
					format = "◢◣";
					tooltip = false;
				};
				"custom/down1" = {
					format = "◥◤";
					tooltip = false;
				};
				"custom/up2" = {
					format = "◢◣";
					tooltip = false;
				};
				"custom/down2" = {
					format = "◥◤";
					tooltip = false;
				};
			};
		};
	};
}
