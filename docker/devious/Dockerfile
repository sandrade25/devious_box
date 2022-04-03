# syntax=docker/dockerfile:1
FROM ubuntu:20.04

LABEL maintainers="SydDevious"
LABEL name="eldorado"

ENV TERM xterm
ENV container docker

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone


RUN apt-get update && apt-get install -y \
    curl \
    less \
    groff \
    build-essential \
    ffmpeg \
    git \
    gnupg \
    gnupg-agent \
    htop \
    imagemagick \
    libczmq-dev \
    libevent-dev \
    libffi-dev \
    libjpeg-dev \
    libmagic-dev \
    libpq-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libxmlsec1-openssl \
    libzmq3-dev \
    lsof \
    nginx \
    openssh-server \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-software-properties \
    software-properties-common \
    pkg-config \
    rsyslog \
    unoconv \
    vim \
    zip \
    wget \
    unzip \
    bash-completion \
    --no-install-recommends

# setup python
RUN cd /usr/local/bin && ln -s /usr/bin/python3 python
RUN pip3 install --upgrade pip

# circus
RUN pip install circus
COPY conf/circus_local.ini /srv/circus_local.ini

# vim setup
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# logging
RUN mkdir -p /var/log/eldorado/
RUN chown www-data:www-data /var/log/eldorado

RUN git clone --branch $TARGET_BRANCH --depth 1 git@github.com:sandrade25/eldorado.git /var/www/eldorado
COPY app_local.ini /var/www/eldorado/app/conf/app_local.ini

WORKDIR /var/www/eldorado/

# local setup
COPY scripts/local_setup.sh /tmp/local_setup.sh
RUN /tmp/local_setup.sh $ENVIRONMENT
RUN rm /tmp/local_setup.sh


EXPOSE 80