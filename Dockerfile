FROM debian:stable-slim AS builder
LABEL maintainer="cq@vk6flab.com"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get -y upgrade

RUN mkdir -p /src/hlog /src/libjeffpc
RUN ls /src
ADD https://www.josefsipek.net/projects/hlog/src/latest.tar.gz /src/
RUN tar -zxf /src/latest.tar.gz --strip-components=1 -C /src/hlog

ADD https://hg.sr.ht/~jeffpc/libjeffpc/archive/tip.tar.gz /src/
RUN tar -zxf /src/tip.tar.gz --strip-components=1 -C /src/libjeffpc

# Dependencies for hlog
RUN apt-get -y install \
	build-essential \
	cmake \
	curl \
	libgps-dev \
	libhamlib-dev \
	liblua5.4-dev \
	libncurses-dev \
	libzmq3-dev \
	lua5.4 \
	pkgconf

# Extra dependencies for libjeffpc
RUN apt-get -y install \
	bison \
	flex \
	libbsd-dev \
	libntirpc-dev \
	mercurial

WORKDIR /src/libjeffpc
RUN cmake . -DCMAKE_INSTALL_PREFIX=/usr/local
RUN make install

# Fixme: workaround for a bug in the cmake for hlog
RUN ln -s /usr/include/tirpc/rpc/* /usr/include/rpc/
RUN ln -s /usr/include/tirpc/netconfig.h /usr/include/

WORKDIR /src/hlog
RUN cmake . -DWITH_JEFFPC=/usr/local -DCMAKE_INSTALL_PREFIX=/usr/local
RUN make install

# Fixme: workaround for a weird path error
RUN apt-get -y install \
	libunwind8

# Check that it actually worked
RUN ldd /usr/local/bin/hlog

COPY entry_point.sh /usr/local/bin/launch_hlog
RUN chmod +x /usr/local/bin/launch_hlog

RUN useradd -ms /bin/bash docker
USER docker

ENTRYPOINT ["/usr/local/bin/launch_hlog"]
