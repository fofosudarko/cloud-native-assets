# Dockerfile
FROM node:12.19-alpine3.12
RUN apk add --no-cache --update curl bash
RUN npm install -g npm ; \
  (which serve || npm install -g serve); \
  (which tsc || npm install -g typescript); \
  (which ts-node || npm install -g ts-node)
ADD scripts /scripts