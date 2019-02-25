FROM alpine:latest

LABEL maintainer="Balazs Nadasdi <balazs.nadasdi@cheppers.com>"

RUN apk add --no-cache openssl taskd taskd-pki

VOLUME ["/data"]

ENV TASKDDATA=/data

ENV BITS=4096
ENV EXPIRATION_DAYS=365
ENV ORGANIZATION="Self-hosted taskd"
ENV COUNTRY=HU
ENV STATE="Budapest"
ENV LOCALITY="Budapest"

COPY entry.sh /entry.sh
COPY taskd-create-org /usr/bin/taskd-create-org
COPY taskd-create-user /usr/bin/taskd-create-user

RUN chmod +x /entry.sh /usr/bin/taskd-create-org /usr/bin/taskd-create-user

EXPOSE 60000

ENTRYPOINT ["/entry.sh"]
