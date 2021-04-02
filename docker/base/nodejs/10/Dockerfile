# nodejs
FROM node:10.22.1-alpine3.10
RUN apk add --update --no-cache build-base wget git python python3 curl bash
RUN npm install -g npm ; \
  (which serve || npm install -g serve); \
  (which tsc || npm install -g typescript); \
  (which ts-node || npm install -g ts-node)
ADD scripts /scripts