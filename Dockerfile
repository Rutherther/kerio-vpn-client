FROM ubuntu:bionic

ARG deb

ADD ./install.sh /tmp/install.sh
ADD ./kerio.sh /usr/bin/kerio.sh
ADD ./mounts.sh /usr/bin/mounts.sh
ADD http://cdn.kerio.com/dwn/control/control-9.2.6-2720/kerio-control-vpnclient-9.2.6-2720-linux-amd64.deb /tmp/kerio.deb
ADD ./configure-kerio.sh /usr/bin/configure-kerio.sh
ADD ./healthcheck.sh /usr/bin/healthcheck.sh

RUN apt-get update && apt-get install -y iproute2 openssl libuuid1 procps cifs-utils smbclient

RUN sh /tmp/install.sh

HEALTHCHECK --interval=1m --timeout=10s CMD /usr/bin/healthcheck.sh
ENTRYPOINT [ "/usr/bin/kerio.sh" ]
