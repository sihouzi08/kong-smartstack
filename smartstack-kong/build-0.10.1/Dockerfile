FROM foreveross/smartstack

RUN sudo apt-get update
RUN sudo apt-get install -y openssl libpcre3 procps perl dnsmasq
COPY kong-0.10.1.trusty_all.deb /
RUN sudo dpkg -i kong-0.10.1.trusty_all.deb
