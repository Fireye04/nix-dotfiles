{pkgs, ...}: {
	packages = let
		src = ./.;
		php = pkgs.php;
	in
		{self}: {
			app =
				php.buildComposerProject {
					inherit src;

					pname = "app-demo";
					version = "1.0.0";

					vendorHash = "sha256-SrE51k3nC5idaDHNxiNM7NIbIERIf8abrCzFEdxOQWA=";
				};

			oci-image = let
				nginxPort = "8000";
				nginxWebRoot = "${self.packages.app}/share/php/app-demo/public";

				nginxConf =
					pkgs.writeText "nginx.conf" ''
						user nobody nobody;
						daemon off;
						error_log /dev/stdout info;
						pid /dev/null;
						events {}
						http {
						  access_log /dev/stdout;
						  server {
						    listen ${nginxPort};
						    index index.php index.html;
						    charset utf-8;

						    add_header X-Frame-Options "SAMEORIGIN";
						    add_header X-Content-Type-Options "nosniff";
						    location / {
						      root ${nginxWebRoot};
						      try_files $uri $uri/ /index.php?$query_string;
						    }
						    location ~ \.php$ {
						      root ${nginxWebRoot};
						      fastcgi_pass 127.0.0.1:9000;
						      fastcgi_split_path_info ^(.+\.php)(/.+)$;
						      include ${pkgs.nginx}/conf/fastcgi_params;
						      include ${pkgs.nginx}/conf/fastcgi.conf;
						    }
						  }
						}
					'';
			in
				pkgs.dockerTools.buildLayeredImage {
					name = "app-demo";
					tag = "latest";

					contents = [
						php
						pkgs.nginx
						pkgs.fakeNss
						(pkgs.writeScriptBin "start-server" ''
								#!${pkgs.runtimeShell}
								php-fpm -y /etc/php-fpm.d/www.conf.default & nginx -c ${nginxConf};
							'')
					];

					extraCommands = ''
						mkdir -p var/log/nginx
						mkdir -p var/cache/nginx
						mkdir -p tmp
						chmod 1777 tmp
					'';

					config = {
						Cmd = ["start-server"];
						ExposedPorts = {
							"${nginxPort}/tcp" = {};
						};
					};
				};
		};
}
