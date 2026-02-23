{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };

  # Docker Compose services are defined in ../docker/compose.yml
  # Managed outside Nix for flexibility — easy to add/remove containers
  # without rebuilding the whole system.
  #
  # Start: cd ~/homelab/docker && docker compose up -d
  # Or use the systemd service below for auto-start:

  systemd.services.homelab-docker = {
    description = "Homelab Docker Compose stack";
    after = [ "docker.service" "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      WorkingDirectory = "/home/phall/homelab/docker";
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose up -d --remove-orphans";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose down";
      User = "phall";
      Group = "docker";
    };
  };
}
