#!/bin/bash
sudo apt-get update
sudo apt-get install docker.io
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker

sudo systemctl daemon-reload
sudo apt-get update -y
sudo apt-get install -y ansible

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
minikube start 
minikube status

