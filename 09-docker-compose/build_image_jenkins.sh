#!/bin/bash
docker --version
docker build -t jenkins:v001 -f Dockerfile.jenkins .
docker build -t nexus:v001 -f Dockerfile.nexus .
docker compose version
docker compose -f docker-compose.yaml up -d