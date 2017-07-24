FROM node:6.11.1

# angular cli tool
RUN npm install -g @angular/cli
RUN npm install -g npm@5.3.0

# gcloud
RUN curl https://sdk.cloud.google.com | bash
