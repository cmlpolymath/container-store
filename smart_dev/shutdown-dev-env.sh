#!/bin/bash
# Script to close VS Code, stop Docker containers/daemon, optionally stop docker.socket, prune Docker, and shutdown WSL.

echo "Attempting to close VS Code..."
# Attempt to kill VS Code processes (this works if VS Code is started in WSL)
pkill -f "code" && echo "VS Code processes closed." || echo "VS Code may not be running in this environment."

echo "Stopping all running Docker containers..."
# Stop all running containers (if any)
container_ids=$(docker ps -q)
if [ -n "$container_ids" ]; then
  docker stop $container_ids && echo "Stopped running Docker containers." || echo "Failed to stop Docker containers."
else
  echo "No running Docker containers found."
fi

echo "Stopping the Docker daemon..."
# Stop the Docker daemon (requires sudo)
sudo service docker stop && echo "Docker daemon stopped." || echo "Failed to stop Docker daemon."

echo "Do you also want to stop docker.socket? (Y/N)"
read -r socketAnswer
if [[ "$socketAnswer" =~ ^[Yy]$ ]]; then
  sudo service docker.socket stop && echo "Docker socket stopped." || echo "Failed to stop Docker socket."
else
  echo "Docker socket remains running."
fi

echo "Do you wish to prune unused Docker resources? (Y/N)"
read -r pruneAnswer
if [[ "$pruneAnswer" =~ ^[Yy]$ ]]; then
  echo "Pruning unused Docker resources..."
  docker system prune -a -f && echo "Docker system pruned." || echo "Docker system prune encountered issues."
else
  echo "Skipping Docker system prune."
fi

echo "Shutting down WSL..."
# Call Windows wsl.exe to shutdown WSL (adjust path if needed)
if [ -f "/mnt/c/Windows/System32/wsl.exe" ]; then
  /mnt/c/Windows/System32/wsl.exe --shutdown && echo "WSL shutdown command executed."
else
  echo "wsl.exe not found. Please shutdown WSL manually."
fi

