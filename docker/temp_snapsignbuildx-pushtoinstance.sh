#!/usr/bin/env bash

command -v docker >/dev/null 2>&1 || {
    echo "Docker is not running. Please start Docker and try again."
    exit 1
}

SCRIPT_DIR="$(readlink -f "$(dirname "$0")")"
MONOREPO_ROOT="$(readlink -f "$SCRIPT_DIR/../")"

# Get the platform from environment variable or set to linux/amd64 if not set
# quote the string to prevent word splitting
if [ -z "$PLATFORM" ]; then
    PLATFORM="linux/amd64"
fi

echo "Building docker image for monorepo at $MONOREPO_ROOT"
echo "Image version: $1"

docker buildx build \
    -f "$SCRIPT_DIR/Dockerfile" \
    --platform=$PLATFORM \
    --progress=plain \
    -t "snapsign_next_$1" \
    "$MONOREPO_ROOT"


docker save -o $MONOREPO_ROOT/../SnapSignNextTars/snapsign_next_$1.tar snapsign_next_$1

scp -i $MONOREPO_ROOT/../Nxt-CA-Mn-Cert.pem $MONOREPO_ROOT/../SnapSignNextTars/snapsign_next_$1.tar ec2-user@3.99.74.230:/home/ec2-user/DockerImageTars