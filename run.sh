#!/bin/bash

# 安装依赖
sudo npm i -d --registry=https://registry.npm.taobao.org

# start kong
sudo kong start
#sudo kong start --nginx-conf conf/custom_nginx.template

# 配置smartstack
/bin/bash -l -c 'nerve -c /project/smartstack/nerve/nerve.conf.json' 
#nohup /bin/bash -l -c 'synapse -c /project/smartstack/synapse/synapse.conf.json' &

# 开发情况以开发模式启动,生产模式调整为npm start
#sudo npm run start


