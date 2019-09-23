FROM python:3.7-alpine
MAINTAINER pmcoelho@protonmail.com

ENV PYTHONBUFFERED 1
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

COPY ./requirements.txt /requirements.txt

RUN apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev && \
    pip install -r /requirements.txt && \
    apk del .tmp-build-deps


RUN mkdir /tiljournal
WORKDIR /tiljournal
COPY ./tiljournal /tiljournal

RUN adduser -D user
USER user
