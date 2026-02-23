#!/usr/bin/env bash
set -euo pipefail

echo "=== Jarvis Bootstrap ==="
echo ""

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Ensure we're on NixOS
if [[ ! -f /etc/NIXOS ]]; then
  echo "Error: This script must run on NixOS."
  exit 1
fi

# Check for age key (needed for sops-nix)
AGE_KEY="$HOME/.config/sops/age/keys.txt"
if [[ ! -f "$AGE_KEY" ]]; then
  echo "Warning: age key not found at $AGE_KEY"
  echo "Secrets decryption will fail until you copy your key."
  echo ""
  echo "From your Mac:"
  echo "  scp ~/.config/sops/age/keys.txt jarvis:~/.config/sops/age/keys.txt"
  echo ""
fi

# Apply NixOS config
echo "Applying NixOS configuration..."
cd "$REPO_DIR"
sudo nixos-rebuild switch --flake .#jarvis

echo ""
echo "=== Bootstrap complete ==="
echo ""
echo "Next steps:"
echo "  1. Connect Tailscale: sudo tailscale up --auth-key=tskey-auth-XXXX --advertise-tags=tag:homelab"
echo "  2. Clone dotfiles:    git clone <your-dotfiles-url> ~/dotfiles && cd ~/dotfiles && ./install.sh"
echo "  3. Start containers:  make docker-up"
echo ""
