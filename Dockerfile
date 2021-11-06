FROM debian:11.1

LABEL maintainer="Oliver Ofenloch <57812959+ofenloch@users.noreply.github.com>"
LABEL version="0.0.1"

VOLUME "/project"

WORKDIR "/project"

# This is for my apt-cacher:
COPY apt.conf.proxy /etc/apt/apt.conf.d/01proxy

RUN /usr/bin/apt-get update && \
    /usr/bin/apt-get --yes --no-install-recommends --fix-broken --fix-missing install \
        apt-utils && \
    /usr/bin/apt-get --yes --no-install-recommends --fix-broken --fix-missing install \
        build-essential \
        gcc \
        g++ \
        cmake \
        bash \
        cppcheck && \
    /bin/rm -rf /var/cache/apt/*

ENTRYPOINT [ "bash", "-c" ]