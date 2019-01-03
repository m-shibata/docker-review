FROM ubuntu:rolling
MAINTAINER Mitsuya Shibata

## Prepare for package manager
#
RUN sed -i.bak "s,/\(archive.ubuntu.com\),/jp.\1,g" /etc/apt/sources.list

## Install pacakges for Re:VIEW/EPUB
#
#   - For Re:VIEW: ruby, zip
#   - For epubcheck: default-jre, unzip, wget
#   - For ja_JP.UTF-8: locales
#
RUN apt-get update && apt-get install -y --no-install-recommends \
    ruby \
    zip \
    default-jre \
    unzip \
    wget \
    locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## Set locale for Ruby
#
RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

## Create working directory
#
RUN mkdir -p /data/texmf
WORKDIR /data
ARG TEXMFCACHE
ENV TEXMFCACHE ${TEXMFCACHE:-/data/texmf}
ENV TEXMFSYSVAR ${TEXMFCACHE:-/data/texmf}
ENV TEXMFVAR ${TEXMFCACHE:-/data/texmf}

## Install pacakges for Re:VIEW/PDF
#
#   - For TeX: texlive-*
#   - For tlmgr: wget, xzdec
#   - For LuaTeX: texlive-luatex, lmodern
#   - For fonts: fonts-noto-cjk fonts-noto-cjk-extra
#   - For make: make
#
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-lang-japanese \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-luatex \
    lmodern \
    wget \
    xzdec \
    fonts-noto-cjk \
    fonts-noto-cjk-extra \
    fonts-noto-mono \
    fonts-noto-color-emoji \
    make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## Install epubcheck
#
ARG EPUBCHECK_VER
ENV EPUBCHECK_VER ${EPUBCHECK_VER:-4.1.0}
RUN wget -qO/tmp/epubcheck.zip \
    https://github.com/w3c/epubcheck/releases/download/v${EPUBCHECK_VER}/epubcheck-${EPUBCHECK_VER}.zip \
    && cd /tmp \
    && unzip epubcheck.zip \
    && mv epubcheck-${EPUBCHECK_VER} /opt/epubcheck \
    && rm epubcheck.zip

## Install Re:VIEW and rake
#
ARG REVIEW_VER
ENV REVIEW_VER ${REVIEW_VER:-3.0.0}
RUN gem install rake review:${REVIEW_VER}

