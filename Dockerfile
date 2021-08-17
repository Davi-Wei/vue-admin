FROM node:lts-alpine as builder
WORKDIR /vue-admin
# RUN npm set registry https://registry.npm.taobao.org
# cache step
COPY package.json /vue-admin/package.json
RUN npm install
# build
COPY ./ /vue-admin
RUN npm run build:prod

FROM nginx as production
RUN mkdir /web
COPY --from=builder /vue-admin/dist/ /web
COPY --from=builder /vue-admin/build/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
