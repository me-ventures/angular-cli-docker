FROM node:6.11.1-alpine

# angular cli tool
RUN apk add --update nodejs-npm && npm install npm@5.3.0 -g
RUN npm install -g @angular/cli

# gcloud
RUN curl https://sdk.cloud.google.com | bash
