FROM node:6.11.1

RUN apt-get update && apt-get install -y bash curl python git

# gcloud
RUN curl https://sdk.cloud.google.com | bash

# install npm 5.3.0
# Fix bug https://github.com/npm/npm/issues/9863
RUN cd $(npm root -g)/npm \
  && npm install fs-extra \
  && sed -i -e s/graceful-fs/fs-extra/ -e s/fs\.rename/fs.move/ ./lib/utils/rename.js

RUN npm install npm@5.3.0 -g


# install angular-cli as "node" user with some permissions
RUN chown -R node:node /usr/local/lib/node_modules
RUN chown -R node:node /usr/local/bin
RUN mkdir /app && chown node:node /app
USER node

# angular cli tool
RUN npm install -g @angular/cli

USER root
