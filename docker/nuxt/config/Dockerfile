# docker node.js config
FROM container-registry.example.com/library/nodejs-12-lts:latest as first_build
ARG APP_WORKDIR=/app
ARG APP_PACKAGER_BUILD_COMMANDS='build'
ARG APP_PACKAGER_BUILD_COMMAND_DELIMITER=','
ARG APP_PACKAGE_LOCK=${APP_WORKDIR}/package-lock.json
ARG APP_NODE_MODULES=${APP_WORKDIR}/node_modules/
ARG PACKAGER=npm
WORKDIR ${APP_WORKDIR}
#RUN [[ ! -e "${APP_PACKAGE_LOCK}" ]] || rm -f ${APP_PACKAGE_LOCK}; \
#  [[ ! -d "${APP_NODE_MODULES}" ]] || rm -rf ${APP_NODE_MODULES}
COPY package.json ${APP_WORKDIR}/package.json
RUN cd ${APP_WORKDIR}; ${PACKAGER} install
COPY . ${APP_WORKDIR}
RUN echo -ne "$APP_PACKAGER_BUILD_COMMANDS"| \
  sed "s~$~${APP_PACKAGER_BUILD_COMMAND_DELIMITER}~"| \
  tr "$APP_PACKAGER_BUILD_COMMAND_DELIMITER" '\n'| \
  while IFS='\n' read -r packager_build_command; \
  do [[ -z "$packager_build_command" ]] || \
  ( echo $0: Running command: $packager_build_command; ${PACKAGER} run $packager_build_command ); \
  done

ENV APP_SERVER_HOST=
ENV APP_SERVER_PORT=
ENV APP_BUILD_MODE=
ENV APP_NAME=
ENV APP_RUN_COMMAND=
ENV APP_WORKDIR=

EXPOSE 5000
ENTRYPOINT [ "/bin/sh", "/app/run.sh" ]