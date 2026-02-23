{ config, pkgs, ... }:

{
  # Native Home Assistant via NixOS module
  # Benefits: direct access to USB dongles (Zigbee/Z-Wave), lower latency
  #
  # Alternative: run via Docker in docker/compose.yml

  # services.home-assistant = {
  #   enable = true;
  #   config = {
  #     homeassistant = {
  #       name = "Home";
  #       unit_system = "imperial";
  #       time_zone = config.time.timeZone;
  #     };
  #     default_config = {};
  #   };
  #   extraPackages = python3Packages: with python3Packages; [
  #     # Add integrations here
  #   ];
  # };

  # networking.firewall.allowedTCPPorts = [ 8123 ];
}
