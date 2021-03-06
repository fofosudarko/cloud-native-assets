# app configuration
FROM openjdk:11-jdk-slim as first_build
WORKDIR /app
COPY gradlew gradlew
COPY gradle gradle
COPY build.gradle.kts .
COPY settings.gradle.kts .
RUN ./gradlew clean
#COPY keystores keystores
COPY src src
RUN ./gradlew --build-cache bootJar
RUN mkdir -p build/libs/dependency && (cd build/libs/dependency; jar -xf ../*.jar)

FROM openjdk:11-jre-slim
VOLUME [ "/tmp" ]
ARG WORKSPACE=/app
ARG DEPENDENCY=${WORKSPACE}/build/libs/dependency
COPY --from=first_build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=first_build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=first_build ${DEPENDENCY}/BOOT-INF/classes /app
#COPY --from=first_build ${WORKSPACE}/keystores /home/example-project/keystores

# env
ENV APP_SERVER_HOST=
ENV APP_SERVER_PORT=
ENV APP_SERVER_CONTEXT_PATH=
ENV DB_SERVER_HOST=
ENV DB_SERVER_PORT=
ENV DB_SERVER_DB=
ENV DB_SERVER_CONNECTION_QUERY_STRING=
ENV DB_SERVER_USERNAME=
ENV DB_SERVER_PASSWORD=
ENV LOGGING_LEVEL_ROOT=
ENV LOGGING_LEVEL_ORG_SPRINGFRAMEWORK_WEB=
ENV LOGGING_LEVEL_ORG_HIBERNATE=
ENV APP_SERVER_SERVICE_API_HOST=
ENV HIKARI_AUTO_COMMIT=
ENV HIKARI_CONNECTION_TIMEOUT=
ENV HIKARI_IDLE_TIMEOUT=
ENV HIKARI_MAX_LIFETIME=
ENV HIKARI_MINIMUM_IDLE=
ENV HIKARI_MAXIMUM_POOL_SIZE=
ENV HIKARI_POOL_NAME=
ENV HIKARI_TRANSACTION_ISOLATION=
ENV HIKARI_LEAK_DETECTION_THRESHOLD=
ENV HIKARI_VALIDATION_TIMEOUT=
ENV APP_SERVER_ENVIRONMENT=

EXPOSE 5000
ENTRYPOINT ["java", "-cp", "app:app/lib/*", "com.example.service.ApplicationKt"]