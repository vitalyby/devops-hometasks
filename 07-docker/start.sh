#!/bin/bash
cd /vagrant
docker --version
docker build -t image_with_apache2 .
docker run -it --rm -p 80:80/tcp image_with_apache2:latest