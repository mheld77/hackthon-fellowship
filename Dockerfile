# Stage 1 (to create a "build" image node)
FROM node:18-alpine AS builder_node

RUN apk update && \
    apk upgrade

RUN cat /etc/alpine-release
RUN node --version

WORKDIR /usr/src/app
COPY . .

RUN npm install

RUN npm run build

# Stage 2 (to create a downsized "container executable")
FROM nginx:alpine as build_nginx

RUN apk update && \
    apk upgrade

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY --from=builder_node /usr/src/app/dist/hackaton /usr/share/nginx/html

#COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/nginx.conf

###VOLUME ["/var/cache/nginx"]

# COPY docker-entrypoint.sh /usr/local/bin/
# RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

# ENTRYPOINT ["docker-entrypoint.sh"]

###EXPOSE 9005
EXPOSE 4200

CMD ["nginx", "-g", "daemon off;"]
