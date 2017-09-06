FROM node:6.11.1

RUN apt-get update && apt-get install -y bash curl python git apt-transport-https

# gcloud
RUN curl https://sdk.cloud.google.com | bash

# install npm 5.3.0
# Fix bug https://github.com/npm/npm/issues/9863
RUN cd $(npm root -g)/npm \
  && npm install fs-extra \
  && sed -i -e s/graceful-fs/fs-extra/ -e s/fs\.rename/fs.move/ ./lib/utils/rename.js

RUN npm install npm@5.3.0 -g

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
