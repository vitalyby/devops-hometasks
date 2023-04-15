#!/bin/bash
cd /vagrant/multi
docker build -t image_wcg .
docker run -it --rm -p 8888:8888/tcp image_wcg:latest