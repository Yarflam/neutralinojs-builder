FROM ubuntu
MAINTAINER Yarflam
ENV DEBIAN_FRONTEND=noninteractive

# Install standards dependencies
RUN apt-get update && apt-get install -y curl\
    wget nano apt-transport-https lsb-release\
    ca-certificates git openssl

# Install English pack
RUN apt-get install -y --no-install-recommends locales &&\
    locale-gen en_GB.UTF-8 &&\
    echo "environment=LANG=\"en_GB.utf8\", LC_ALL=\"en_GB.UTF-8\", LC_LANG=\"en_GB.UTF-8\"" > /etc/default/locale
RUN chmod 0755 /etc/default/locale
ENV LC_ALL=en_GB.UTF-8
ENV LANG=en_GB.UTF-8
ENV LANGUAGE=en_GB.UTF-8

# Timezone Europe/Paris
RUN rm -f /etc/localtime &&\
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Install Node.js
ENV NODE_VERSION=14.15.4
ENV NODE_PLATFORM=x64
RUN wget https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$NODE_PLATFORM.tar.xz &&\
    tar xf node-v$NODE_VERSION-linux-$NODE_PLATFORM.tar.xz &&\
    mv ./node-v$NODE_VERSION-linux-$NODE_PLATFORM /opt/node &&\
    rm -f ./node-v$NODE_VERSION-linux-$NODE_PLATFORM.tar.xz
ENV PATH="/opt/node/bin:${PATH}"

# Install NeutrinoJS
WORKDIR /usr/src
RUN apt-get update && apt-get install -y libgtk-3-dev libwebkit2gtk-4.0-37 libwebkit2gtk-4.0-dev
RUN npm i -g @neutralinojs/neu &&\
    neu create app

# Builder
WORKDIR /usr/src/app
RUN echo "#!/bin/bash" > ./builder.sh &&\
    echo "neu build" >> ./builder.sh &&\
    echo "sleep 3" >> ./builder.sh
RUN chmod +x ./builder.sh
