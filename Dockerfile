FROM alpine:3.5

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

RUN apk -U add ca-certificates fuse wget dcron tzdata \
    && rm -rf /var/cache/apk/* \
    && cd /tmp \
    && wget -q https://git.fionera.de/fionera/rclone/releases/download/1.47.1/rclone.zip \
    && unzip /tmp/rclone.zip \
    && mv /tmp/rclone/rclone /usr/bin \
    && rm -r /tmp/rclone*

COPY entrypoint.sh /
COPY sync.sh /
COPY sync-abort.sh /

VOLUME ["/config"]

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
