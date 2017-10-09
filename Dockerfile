FROM node:8.6

RUN apt-get update && apt-get install -y bash curl python git apt-transport-https

# gcloud
RUN curl https://sdk.cloud.google.com | bash

# Install YARN
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Install Docker
RUN set -x \
    && VER="17.03.0-ce" \
    && curl -L -o /tmp/docker-$VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$VER.tgz \
    && tar -xz -C /tmp -f /tmp/docker-$VER.tgz \
    && mv /tmp/docker/* /usr/bin 

# install angular-cli as "node" user with some permissions
RUN chown -R node:node /usr/local/lib/node_modules && chown -R node:node /usr/local/bin
RUN mkdir /app && chown node:node /app
USER node

# angular cli tool
RUN npm install -g @angular/cli

USER root
