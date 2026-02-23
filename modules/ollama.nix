{ config, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    # acceleration = "cuda";  # Uncomment when GPU is installed
    # acceleration = "rocm";  # For AMD GPUs
    host = "0.0.0.0";
    port = 11434;
  };

  # Open port on tailnet only (firewall trusts tailscale0)
  # If you need LAN access too:
  # networking.firewall.allowedTCPPorts = [ 11434 ];
}
