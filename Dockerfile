FROM ubuntu:16.04

MAINTAINER JustaDockernoob <nobody@cares.ever>

ENV RCLONE_VERSION=current
ENV ARCH=amd64
ENV SYNC_SRC=
ENV SYNC_DEST=
ENV SYNC_OPTS=-v
ENV RCLONE_OPTS="--config /config/rclone.conf"
ENV CRON=
ENV CRON_ABORT=
ENV FORCE_SYNC=
ENV CHECK_URL=
ENV TZ=

RUN apt-get update \
    && apt-get install -y ca-certificates fuse wget libterm-readline-gnu-perl apt-utils tzdata unzip zip \
    && rm -rf /var/lib/apt/lists/* \
    && cd /tmp \
    && wget -q https://git.fionera.de/fionera/rclone/releases/download/1.47.2/rclone.zip \
    && unzip /tmp/rclone.zip \
    && mv -v rclone /usr/bin \
    && rm -r /tmp/rclone*

COPY entrypoint.sh /
COPY sync.sh /
COPY sync-abort.sh /

VOLUME ["/config"]

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
