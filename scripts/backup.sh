#!/usr/bin/env bash
set -euo pipefail

echo "=== Jarvis Backup ==="
echo ""

BACKUP_DIR="${BACKUP_DIR:-/tmp/jarvis-backup-$(date +%Y%m%d)}"
mkdir -p "$BACKUP_DIR"

# Docker volumes
echo "Backing up Docker volumes..."
for vol in $(docker volume ls -q 2>/dev/null); do
  echo "  $vol"
  docker run --rm \
    -v "$vol":/source:ro \
    -v "$BACKUP_DIR":/backup \
    alpine tar czf "/backup/docker-vol-$vol.tar.gz" -C /source . 2>/dev/null || \
    echo "  Warning: failed to backup $vol"
done

# Home Assistant data (if running natively)
if [[ -d /var/lib/hass ]]; then
  echo "Backing up Home Assistant..."
  sudo tar czf "$BACKUP_DIR/home-assistant.tar.gz" -C /var/lib hass
fi

# Secrets (encrypted — safe to backup)
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
if [[ -d "$REPO_DIR/secrets" ]]; then
  echo "Backing up secrets..."
  cp -r "$REPO_DIR/secrets" "$BACKUP_DIR/secrets"
fi

echo ""
echo "Backup complete: $BACKUP_DIR"
echo ""
echo "To restore on a fresh system:"
echo "  1. nixos-rebuild switch --flake .#jarvis"
echo "  2. Copy backup dir to server"
echo "  3. For Docker volumes: docker run --rm -v <vol>:/target -v /backup:/backup alpine tar xzf /backup/docker-vol-<vol>.tar.gz -C /target"
echo ""
ls -lh "$BACKUP_DIR"
