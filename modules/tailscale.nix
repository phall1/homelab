{ config, pkgs, ... }:

{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  # Tailscale SSH — enables key-free SSH over tailnet
  # Actual auth is handled by Tailscale ACLs, not sshd
  # After first boot, run:
  #   sudo tailscale up --auth-key=tskey-auth-XXXX --advertise-tags=tag:homelab
}
