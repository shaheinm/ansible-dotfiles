#!/usr/bin/env bash
# =============================================================================
# Test Linux Playbook in Container (Docker or Podman)
# =============================================================================
# Usage: ./test-linux.sh [distro]
#   distro: fedora (default), ubuntu, arch
#
# Examples:
#   ./test-linux.sh           # Test on Fedora
#   ./test-linux.sh ubuntu    # Test on Ubuntu
#   ./test-linux.sh arch      # Test on Arch
# =============================================================================

set -e

DISTRO="${1:-fedora}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Set image and install command based on distro
case "$DISTRO" in
  fedora)
    IMAGE="fedora:latest"
    INSTALL_CMD="dnf install -y ansible git sudo"
    ;;
  ubuntu)
    IMAGE="ubuntu:24.04"
    INSTALL_CMD="apt-get update && apt-get install -y ansible git sudo"
    ;;
  arch)
    IMAGE="archlinux:latest"
    INSTALL_CMD="pacman -Sy --noconfirm ansible git sudo"
    ;;
  *)
    echo "Unknown distro: $DISTRO"
    echo "Available: fedora, ubuntu, arch"
    exit 1
    ;;
esac

echo "============================================="
echo "Testing playbook on $DISTRO"
echo "Image: $IMAGE"
echo "============================================="

# Prefer podman, fall back to docker
if command -v podman &>/dev/null; then
  CONTAINER_CMD="podman"
  # Check if podman machine is running (macOS only)
  if [[ "$(uname)" == "Darwin" ]]; then
    if ! podman machine inspect &>/dev/null 2>&1; then
      echo "Podman machine not initialized. Running: podman machine init"
      podman machine init
    fi
    if ! podman info &>/dev/null 2>&1; then
      echo "Podman machine not running. Starting..."
      podman machine start
    fi
  fi
elif command -v docker &>/dev/null; then
  CONTAINER_CMD="docker"
else
  echo "Error: Neither podman nor docker found."
  echo "Install podman: brew install podman && podman machine init && podman machine start"
  echo "Or use Docker Desktop"
  exit 1
fi

echo "Using: $CONTAINER_CMD"

# Check if we have a TTY
TTY_FLAG=""
if [ -t 0 ]; then
  TTY_FLAG="-it"
else
  TTY_FLAG="-i"
fi

# Run the container with the playbook
$CONTAINER_CMD run --rm $TTY_FLAG \
  -v "$SCRIPT_DIR:/dotfiles" \
  -e "HOME=/root" \
  "$IMAGE" \
  bash -c "
    echo '>>> Installing prerequisites...'
    $INSTALL_CMD

    echo '>>> Setting up test environment...'
    cd /dotfiles
    
    # Create a test hosts file for container
    cat > /tmp/hosts <<EOF
[local]
localhost

[local:vars]
ansible_connection=local
ansible_python_interpreter=/usr/bin/python3
EOF

    echo '>>> Running playbook (dry-run)...'
    ansible-playbook -i /tmp/hosts playbook.yml \
      --check \
      -e 'python_version=skip golang_version=skip nodejs_version=skip' \
      --skip-tags 'sway,kube' \
      || true

    echo ''
    echo '>>> Dry-run complete.'
    
    # Only drop into shell if we have a TTY
    if [ -t 0 ]; then
      echo '>>> Dropping into shell for inspection...'
      exec bash
    else
      echo '>>> No TTY - exiting.'
    fi
  "
