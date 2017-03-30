FROM node:6.10.1

# angular cli tool
RUN npm install -g @angular/cli

# gcloud
RUN curl https://sdk.cloud.google.com | bash
