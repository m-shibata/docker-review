FROM ubuntu:16.10
MAINTAINER Mitsuya Shibata

## Prepare for package manager
#
RUN sed -i.bak "s,/\(archive.ubuntu.com\),/jp.\1,g" /etc/apt/sources.list

## Install pacakges for Re:VIEW/EPUB
#
#   - For Re:VIEW: ruby, zip
#   - For epubcheck: default-jre, unzip, wget
#
RUN apt-get update && apt-get install -y --no-install-recommends \
    ruby \
    zip \
    default-jre \
    unzip \
    wget \
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
RUN mkdir /data
WORKDIR /data

## Install pacakges for Re:VIEW/PDF
#
#   - For TeX: texlive-*
#   - For tlmgr: wget, xzde
#   - For LuaTeX: texlive-xetex, texlive-luatex
#   - For dependency of LuaTeX: fonts-lmodern (fixed after 17.04)
#   - For bold sanserif font: fonts-noto-cjk
#
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-lang-japanese \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-xetex \
    texlive-luatex \
    wget \
    xzdec \
    fonts-lmodern \
    fonts-noto-cjk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## Install epubcheck
#
ARG EPUBCHECK_VER
ENV EPUBCHECK_VER ${EPUBCHECK_VER:-4.0.2}
RUN wget -qO/tmp/epubcheck.zip \
    https://github.com/IDPF/epubcheck/releases/download/v${EPUBCHECK_VER}/epubcheck-${EPUBCHECK_VER}.zip \
    && cd /tmp \
    && unzip epubcheck.zip \
    && mv epubcheck-${EPUBCHECK_VER} /opt/epubcheck \
    && rm epubcheck.zip

## Install Re:VIEW and rake
#
ARG REVIEW_VER
ENV REVIEW_VER ${REVIEW_VER:-2.2.0}
RUN gem install rake review:${REVIEW_VER}

