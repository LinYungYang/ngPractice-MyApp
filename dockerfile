#FROM node:14.13.0
#LABEL authors="BoneXD"
#EXPOSE 4200
#WORKDIR /app
#COPY package.json /app/package.json
#RUN npm install
#RUN npm install -g @angular/cli@10.1.7
#COPY . /app
#CMD ng serve --host 0.0.0.0

########################################
# 第一階段產生dist資料夾
FROM node:14.13.0 as builder
# 指定預設/工作資料夾
WORKDIR /usr/app
# 只copy package.json檔案
COPY ./package*.json ./
# 安裝dependencies
RUN npm install
# copy其餘目錄及檔案
COPY ./ ./
COPY src src
# 指定建立build output資料夾，--prod為Production Mode
RUN npm run build --output-path=/usr/app/dist/my-app --prod

# pull nginx image
FROM nginx:alpine
# 從第一階段的檔案copy
COPY --from=builder /usr/app/dist/my-app /usr/share/nginx/html
# 覆蓋image裡的設定檔
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
