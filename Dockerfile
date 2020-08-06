FROM openjdk:8-alpine
ENV APP_VERSION=5.0.0

RUN set -eux; \
    apk add --progress \
    tini \
    unzip \
    bash; \
    rm -vrf /var/cache/apk/*

RUN wget -q -O /tmp/hapicli.zip https://github.com/jamesagnew/hapi-fhir/releases/download/v${APP_VERSION}/hapi-fhir-${APP_VERSION}-cli.zip

RUN unzip /tmp/hapicli.zip -d /; \
    rm /tmp/hapicli.zip

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/hapi-fhir-cli", "help"]