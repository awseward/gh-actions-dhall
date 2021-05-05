FROM debian:stretch

# hadolint ignore=DL3008,DL3015
RUN apt-get update \
 && apt-get install -y \
      bzip2 \
      git \
      wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY lib.sh /
COPY bin/* /bin/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
