FROM node:14.13.0
LABEL authors="BoneXD"
EXPOSE 4200
WORKDIR /app
COPY package.json /app/package.json
RUN npm install
RUN npm install -g @angular/cli@10.1.7
COPY . /app
CMD ng serve --host 0.0.0.0