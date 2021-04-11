#!/bin/bash
docker build -t neutralinojs-builder-sample . &&\
docker run --name neujs-sample -it neutralinojs-builder-sample /usr/src/app/builder.sh &&\
docker cp neujs-sample:/usr/src/app/dist/app ./dist &&\
docker rm -f neujs-sample &&\
docker rmi neutralinojs-builder-sample
