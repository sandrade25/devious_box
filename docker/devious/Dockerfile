# syntax=docker/dockerfile:1

# use LTS ubuntu
FROM ubuntu:20.04

LABEL maintainers="SydDevious"
LABEL name="eldorado"

ENV TERM xterm
ENV container docker
ARG DEBIAN_FRONTEND=noninteractive
ARG ENVIRONMENT=local

# # Set timezone:
# RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone


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
    --no-install-recommends


# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8   

# setup postgres
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update
RUN apt-get -y install postgresql-13

# setup python
RUN cd /usr/local/bin && ln -s /usr/bin/python3 python
RUN pip3 install --upgrade pip

# quick update
RUN apt-get update

# copy config files
COPY conf/mime.types /usr/local/etc/mime/types
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/circus_local.ini /srv/circus_local.ini
COPY conf/postgresql.conf /tmp/postgresql.conf

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

# circus
RUN pip install circus
COPY conf/circus_local.ini /srv/circus_local.ini

# logging
RUN mkdir -p /var/log/eldorado/
RUN chown www-data:www-data /var/log/eldorado

# clone down app code and pip install packages
RUN git clone git@github.com:sandrade25/eldorado.git /var/www/eldorado
COPY conf/app_local.ini /var/www/eldorado/app/conf/app_local.ini

WORKDIR /var/www/eldorado/

RUN pip install -r requirements.txt

# copy local setup script
COPY scripts/local_setup.sh /tmp/local_setup.sh

# # replace windows \r
# RUN dos2unix /tmp/local_setup.sh

# run local setup
RUN /tmp/local_setup.sh $ENVIRONMENT
# RUN rm /tmp/local_setup.sh


EXPOSE 80

CMD ["uvicorn", "app.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "80"]

