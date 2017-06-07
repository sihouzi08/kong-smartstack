FROM foreveross/smartstack-kong-10-2

COPY ./run.sh /
COPY ./smartstack /smartstack
COPY ./conf/custom_nginx.template /conf/custom_nginx.template
COPY ./conf/kong-cluster.conf /etc/kong/kong.conf
COPY ./plugins/key-auth-redis /usr/local/share/lua/5.1/kong/plugins/key-auth-redis
COPY ./plugins/general-limiting /usr/local/share/lua/5.1/kong/plugins/general-limiting
COPY ./plugins/kong-0.10.2-0.rockspec /usr/local/lib/luarocks/rocks/kong/0.10.2-0/kong-0.10.2-0.rockspec

RUN sudo chmod +x ./run.sh

CMD ["bash","run.sh"]

