#!/bin/bash
cd /vagrant
docker build -t hometask-image .
docker run -it --rm -p 8080:80/tcp hometask-image:latest