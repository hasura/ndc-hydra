FROM ghcr.io/hasura/ndc-rest:v0.2.0

ENV HASURA_CONFIGURATION_DIRECTORY /etc/connector

COPY ./config /etc/connector
