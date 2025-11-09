#!/bin/bash

NETWORK_NAME="monitoring"
COMPOSE_FILE="docker-compose.yml"

if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
    echo "Network '$NETWORK_NAME' not found. Creating it now..."
    docker network create --driver bridge "$NETWORK_NAME"
    
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create network '$NETWORK_NAME'. Exiting."
        exit 1
    fi
else
    echo "Network '$NETWORK_NAME' already exists. Proceeding."
fi

echo "Starting containers..."
docker compose -f "$COMPOSE_FILE" up -d