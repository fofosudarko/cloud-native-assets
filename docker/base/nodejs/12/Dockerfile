# Dockerfile
FROM node:12.19-alpine3.12
ARG PACKAGER=npm
RUN apk add --no-cache --update curl bash
RUN ${PACKAGER} install -g npm ; \
  (which serve || ${PACKAGER} install -g serve); \
  (which tsc || ${PACKAGER} install -g typescript); \
  (which ts-node || ${PACKAGER} install -g ts-node)
ADD scripts /scripts