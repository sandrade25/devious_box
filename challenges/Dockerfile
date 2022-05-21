# syntax=docker/dockerfile:1

# use LTS ubuntu
FROM ubuntu:20.04

LABEL maintainers="SydDevious"
LABEL name="challenges"

ENV TERM xterm
ENV container docker
ARG DEBIAN_FRONTEND=noninteractive
ARG ENVIRONMENT=local


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
    locales \
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
    dos2unix \
    libcairo2-dev \
    libjpeg-dev \
    libgif-dev \
    libpango1.0-dev \
    iputils-ping \
    --no-install-recommends


# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8   

# setup python
RUN cd /usr/local/bin && ln -s /usr/bin/python3 python
RUN pip3 install --upgrade pip

# quick update
RUN apt-get update

# vim setup
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# github keys. Pull this from a local server with limited access. For now files stored locally copied over. and ignored in git
COPY conf/github.priv /root/.ssh/id_rsa
COPY conf/github.pub /root/.ssh/id_rsa.pub
COPY conf/github.pub /root/.ssh/authorized_keys

RUN chmod 0600 /root/.ssh/id_rsa /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys
RUN ssh-keyscan -H github.com >> /root/.ssh/known_hosts

# vim setup
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# logging
RUN mkdir -p /var/log/challenges/
RUN chown www-data:www-data /var/log/challenges

# clone down app code and pip install packages
RUN git clone git@github.com:sandrade25/coding-challenges.git /var/www/challenges


WORKDIR /var/www/challenges/

RUN git pull
RUN pip install -r requirements.txt

# copy local setup script
COPY scripts/local_setup.sh /tmp/local_setup.sh

# # replace windows \r
# RUN dos2unix /tmp/local_setup.sh

# run local setup
RUN dos2unix /tmp/local_setup.sh
RUN /tmp/local_setup.sh $ENVIRONMENT
# RUN rm /tmp/local_setup.sh




EXPOSE 8001

CMD ["tail", "-f", "/dev/null"]

