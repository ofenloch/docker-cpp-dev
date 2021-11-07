FROM debian:11.1 as cpp-dev-base

LABEL maintainer="Oliver Ofenloch <57812959+ofenloch@users.noreply.github.com>"
LABEL version="0.0.1"

VOLUME "/project"

WORKDIR "/project"

# This is for my apt-cacher:
COPY apt.conf.proxy /etc/apt/apt.conf.d/01proxy


ENV DEBIAN_FRONTEND=noninteractive

ENV NEW_USER_NAME=ofenloch
ENV NEW_UID=6534
ENV NEW_GID=4356
ENV HOME_DIRECTORY=/home/${NEW_USER_NAME}
ENV SHELL=/bin/bash
ENV NEW_PASSWD_ENCRYPTED=54321


RUN /usr/bin/apt-get update && \
    /usr/bin/apt-get --yes --no-install-recommends --fix-broken --fix-missing install \
        apt-utils && \
    /usr/bin/apt-get --yes --no-install-recommends --fix-broken --fix-missing install \
        build-essential \
        gcc \
        g++ \
        cmake \
        ccache \
        bash \
        cppcheck \
        doxygen && \
    /bin/rm -rf /var/cache/apt/*


RUN /usr/sbin/groupadd --force --gid ${NEW_GID} ${NEW_USER_NAME} && \
    /usr/sbin/useradd --create-home --gid=${NEW_GID} --uid=${NEW_UID} --shell=${SHELL} --home-dir=${HOME_DIRECTORY} --password=${NEW_PASSWD_ENCRYPTED} ${NEW_USER_NAME}

# We won't use the cpp-dev-base image. So there's no USER and no ENTRYPOINT.
# USER ${NEW_USER_NAME}:${NEW_USER_NAME}
# ENTRYPOINT [ "bash", "-c" ]


# This is for my OpenModelica development:

FROM cpp-dev-base AS cpp-dev-openoodeilca

RUN /usr/bin/apt-get update && \
    /usr/bin/apt-get --yes --no-install-recommends --fix-broken --fix-missing install \
        clang \
        gfortran \
        default-jdk \
        ant \
        hwloc \
        libexpat1 \
        libhwloc-dev \
        libexpat1-dev \
        libboost-all-dev \
        liblapack-dev \
        libblas-dev \
        libhdf5-dev \
        libcurl4-openssl-dev \
        uuid-dev \
        lp-solve \
        coinor-libipopt-dev \
        libsundials-dev \
        && \
    /bin/rm -rf /var/cache/apt/*

USER ${NEW_USER_NAME}:${NEW_USER_NAME}

ENTRYPOINT [ "bash", "-c" ]
