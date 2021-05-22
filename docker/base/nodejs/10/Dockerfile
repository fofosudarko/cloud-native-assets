# nodejs
FROM node:10.22.1-alpine3.10
ARG PACKAGER=npm
RUN apk add --update --no-cache build-base wget git python python3 curl bash
RUN ${PACKAGER} install -g npm ; \
  (which serve || ${PACKAGER} install -g serve); \
  (which tsc || ${PACKAGER} install -g typescript); \
  (which ts-node || ${PACKAGER} install -g ts-node)
ADD scripts /scripts