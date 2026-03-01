#!/bin/bash
set -e

# Sync config from project root to docker/data directory using a temporary container to bypass permission issues.
echo "Syncing config/config.json to docker/data/config.json..."
mkdir -p docker/data
docker run --rm -v "$(pwd):/host" busybox sh -c "cp /host/config/config.json /host/docker/data/config.json"

docker stop picoclaw-gateway || true
docker rm picoclaw-gateway || true

cd docker
docker compose down
docker compose pull
docker compose --profile gateway up -d
docker compose logs -f
