# docker next.js config
FROM container-registry.example.com/library/nodejs-12-lts:latest as first_build
ARG APP_WORKDIR=/app
ARG APP_NPM_BUILD_COMMANDS='build'
ARG APP_NPM_BUILD_COMMAND_DELIMITER=','
ARG APP_PACKAGE_LOCK=${APP_WORKDIR}/package-lock.json
ARG APP_NODE_MODULES=${APP_WORKDIR}/node_modules/
ARG APP_REPO=
WORKDIR ${APP_WORKDIR}
#RUN [[ ! -e "${APP_PACKAGE_LOCK}" ]] || rm -f ${APP_PACKAGE_LOCK}; \
#    [[ ! -d "${APP_NODE_MODULES}" ]] || rm -rf ${APP_NODE_MODULES}
COPY package.json ${APP_WORKDIR}/package.json
RUN cd ${APP_WORKDIR}; npm install
COPY . ${APP_WORKDIR}
RUN echo -ne "$APP_NPM_BUILD_COMMANDS"| \
  sed "s~$~${APP_NPM_BUILD_COMMAND_DELIMITER}~"| \
  tr "$APP_NPM_BUILD_COMMAND_DELIMITER" '\n'| \
  while IFS='\n' read -r npm_build_command; \
  do [[ -z "$npm_build_command" ]] || \
  ( echo $0: Running command: $npm_build_command; npm run $npm_build_command ); \
  done

ENV APP_SERVER_HOST=0.0.0.0
ENV APP_SERVER_PORT=5000
ENV APP_BUILD_MODE=universal
ENV APP_NAME=next-app
ENV APP_RUN_COMMAND='next start'
ENV APP_WORKDIR=/app
ENV HTTPS=false

EXPOSE 5000 5001
ENTRYPOINT [ "/bin/sh", "/app/run.sh" ]