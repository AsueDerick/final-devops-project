#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print messages
log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%S')] - $1"
}

# Update the system
log "Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Docker
log "Installing Docker..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add the current user to the docker group (avoid using sudo for Docker commands)
log "Adding user to the docker group..."
sudo usermod -aG docker $USER

# Enable and start Docker service
log "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Install Ansible
log "Installing Ansible..."
sudo apt-get update -y
sudo apt-get install -y ansible

# Install Minikube
log "Installing Minikube..."
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube /usr/local/bin/


# Verify installations
log "Verifying Docker installation..."
docker --version

log "Verifying Ansible installation..."
ansible --version

log "Verifying Minikube installation..."
minikube version

log "Installation of Docker, Ansible, and Minikube completed successfully!"

# Reminder to restart shell for Docker group changes to take effect
log "Please log out and log back in to use Docker as a non-root user."
