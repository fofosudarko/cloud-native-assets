# docker node.js config
FROM container-registry.example.com/library/nodejs-12-lts:latest
WORKDIR /app
COPY package.json /app/package.json
RUN cd /app; npm install --production
COPY . /app

ENV NODE_ENV=
ENV PORT=
ENV HOST=
ENV MONGODB_HOST=
ENV MONGODB_PORT=
ENV MONGODB_USERNAME=
ENV MONGODB_PASSWORD=
ENV MONGODB_DBNAME=
ENV MONGODB_URI=
ENV MONGODB_CONNECTION_QUERY_STRING=
ENV JWT_SIGNING_KEY=
ENV JWT_EXPIRATION_PERIOD=
ENV SALT_ROUNDS=
ENV HTTPS=

EXPOSE 5000
ENTRYPOINT [ "node", "/app/index.js" ]