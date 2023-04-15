#!/bin/bash
cd /vagrant
docker run -it --rm -p 8081:80/tcp -d --name staticd hometask-image:latest
docker cp ./index.html staticd:/var/www/html/index.html