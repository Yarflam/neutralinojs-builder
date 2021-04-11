FROM yarflam/neutralinojs-builder
MAINTAINER Yarflam

RUN rm -f neutralino.config.json &&\
    rm -f resources/index.html &&\
    rm -f resources/styles.css &&\
    rm -f resources/js/main.js

COPY neutralino.config.json ./
COPY ./src/* ./resources/
