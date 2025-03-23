{config, pkgs, lib, ...}:
{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      mariadb = {
        image = "mariadb:latest";
        autoStart = false;
        ports = [
          "3306:3306"  # MySQL
        ];
        environment = {
          MARIADB_ALLOW_EMPTY_ROOT_PASSWORD = "yes";  # TODO: ALTER IN FUTURE
        };
        volumes = [ "mariadb_data:/var/lib/mysql" ];
        extraOptions = [ "--network=lamp_network" ];
      };

      phpmyadmin = {
        image = "phpmyadmin/phpmyadmin:latest";
        autoStart = false;
        ports = [
          "8081:80"  # phpMyAdmin
        ];
        environment = {
          PMA_HOST = "mariadb";
          PMA_USER = "root";
          PMA_PASSWORD = "";  # TODO: ALTER IN FUTURE
        };
        dependsOn = [ "mariadb" ];  # LAMP must launch first
        extraOptions = [ "--network=lamp_network" ];
      };
    };
  };
}
