# docker react config
FROM container-registry.example.com/library/nodejs-12-lts:latest as first_build
ARG APP_WORKDIR=/app
ARG APP_PACKAGER_BUILD_COMMANDS='build'
ARG APP_PACKAGER_BUILD_COMMAND_DELIMITER=','
ARG APP_PACKAGE_LOCK=${APP_WORKDIR}/package-lock.json
ARG APP_NODE_MODULES=${APP_WORKDIR}/node_modules/
ARG PACKAGER=npm
WORKDIR ${APP_WORKDIR}
COPY . ${APP_WORKDIR}
#RUN [[ ! -e "${APP_PACKAGE_LOCK}" ]] || rm -f ${APP_PACKAGE_LOCK}; \
#    [[ ! -d "${APP_NODE_MODULES}" ]] || rm -rf ${APP_NODE_MODULES}
#RUN ${PACKAGER} install && npm update && npm audit fix
RUN ${PACKAGER} install
RUN echo -ne "$APP_PACKAGER_BUILD_COMMANDS"| \
  sed "s~$~${APP_PACKAGER_BUILD_COMMAND_DELIMITER}~"| \
  tr "$APP_PACKAGER_BUILD_COMMAND_DELIMITER" '\n'| \
  while IFS='\n' read -r packager_build_command; \
  do [[ -z "$packager_build_command" ]] || \
  ( echo $0: Running command: $packager_build_command; ${PACKAGER} run $packager_build_command ); \
  done

FROM container-registry.example.com/library/nodejs-12-lts:latest
ARG APP_WORKDIR=/app
ARG APP_REPO=''
WORKDIR ${APP_WORKDIR}
COPY --from=first_build ${APP_WORKDIR}/server/${APP_REPO} ${APP_WORKDIR}/server/

ENV APP_SERVER_HOST=
ENV APP_SERVER_PORT=
ENV HTTPS=

EXPOSE 5000 5001
ENTRYPOINT [ "/bin/sh", "/app/run.sh" ]