#!/bin/bash

limit=($(echo $LIMIT_CONNECTION))
sudo sed -i "s/\${LIMIT_CONNECTION}/$limit/g" /conf/custom_nginx.template

# start kong
#sudo kong start
sudo kong start --nginx-conf /conf/custom_nginx.template

# 获取宿主机IP
serverIP=$SERVER_IP

# 获取ZOOKEEPER地址

zookeeperArray=($(echo $ZOOKEEPER_ADDR | sed  's/,/ /g'))
zookeeperAddr="";
for var in ${zookeeperArray[@]}
do
  if [ -n "$zookeeperAddr" ] ; then
   zookeeperAddr=$zookeeperAddr','
  fi
  zookeeperAddr=$zookeeperAddr'"'$var'"'
done

zookeeperAddr=($(echo $zookeeperAddr | sed 's/[[:space:]]//g'))

sudo sed -i "s/\${SERVER_IP}/$SERVER_IP/g" /smartstack/nerve/nerve_services/kongService.json
sudo sed -i "s/\${ZOOKEEPER_ADDR}/$zookeeperAddr/g" /smartstack/nerve/nerve_services/kongService.json


# 配置smartstack
/bin/bash -l -c 'nerve -c /smartstack/nerve/nerve.conf.json' 
#nohup /bin/bash -l -c 'synapse -c /project/smartstack/synapse/synapse.conf.json' &



