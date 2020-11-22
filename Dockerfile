FROM debian:stretch

# hadolint ignore=DL3008
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
      bzip2 \
      git \
      wget \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

COPY bin/* /bin/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
