# It is our freshly build sonar-scanner-image from previous steps that
# is used here as a base image in docker file that we will be working on
FROM sonar-scanner-image:latest
# Here we are setting up a working directory to /app. It is like using `cd app` command
WORKDIR /app
# Copying all files from the project directory to our current location (/app) in image
# except patterns mention in .dockerignore
COPY . .
# Execution of example command. Here it is used to show a list of files and directories.
# It will be useful in later exercises in this tutorial. 
RUN ls -list
# To execute sonar-scanner we just need to run "sonar-scanner" in the image. 
# To pass Sonarqube parameter we need to add "-D"prefix to each as in the example below
# sonar.host.url is property used to define URL of Sonarqube server
# sonar.projectKey is used to define project key that will be used to distinguish it in 
# sonarqube server from other projects
# sonar.sources directory for sources of project
RUN sonar-scanner \
    -Dsonar.host.url="http://172.30.188.141:9000" \
    -Dsonar.projectKey="cathaybk" \
    -Dsonar.sources=". " \
    -Dsonar.login="e0a52e2221d50f4042c10324c7b381d5ccfafa55"


# 第一階段產生dist資料夾
# FROM node:14.13.0 as builder
# # 指定預設/工作資料夾
# WORKDIR /usr/app
# # 只copy package.json檔案
# COPY ./package*.json ./
# # 安裝dependencies
# RUN npm install
# # copy其餘目錄及檔案
# COPY ./ ./
# COPY src src
# # 指定建立build output資料夾，--prod為Production Mode, my-app 為專案名稱依照各自的專案變更
# RUN npm run build --output-path=/usr/app/dist/my-app --prod

# # pull nginx image
# FROM nginx:alpine

# RUN chgrp -R 0 /var/cache/nginx /var/run /var/log/nginx && \
#     chmod -R g+rwX /etc/nginx/ /var/cache/nginx /var/run /var/log/nginx
# RUN sed -i.bak 's/listen\(.*\)80;/listen 8081;/' /etc/nginx/conf.d/default.conf
# RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf

# # 從第一階段的檔案copy
# COPY --from=builder /usr/app/dist/my-app /usr/share/nginx/html
# # 覆蓋image裡的設定檔
# COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf

# EXPOSE 8080