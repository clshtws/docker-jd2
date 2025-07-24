FROM ghcr.io/linuxserver/baseimage-selkies:alpine322

# set version label
ARG BUILD_DATE
ARG VERSION
ARG JDOWNLOADER_URL=https://installer.jdownloader.org/JDownloader.jar
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="clshtws"

# title
ENV TITLE=jDownloader2

RUN \
  echo "**** install packages ****" && \
  apk add --no-cache java-common openjdk8-jre jq ttf-dejavu curl ffmpeg rtmpdump moreutils && \
  echo "**** add icon ****" && \
  curl -o \
    /usr/share/selkies/www/icon.png \
    https://raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/jdownloader-2-icon.png && \
  echo "**** download jar ****" && \
  mkdir -p /defaults && \
  curl -# -L -o /defaults/JDownloader.jar ${JDOWNLOADER_URL} && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
VOLUME /output