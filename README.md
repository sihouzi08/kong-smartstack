#kong-smartstack

## 简介
kong + smartstack Docker化部署方案 

kong版本为0.10.2，代理端口8000

## 部署

0. 如果本地不存在`foreveross/smartstack-kong-10-2`镜像，则进入到`smartstack-kong/build-0.10.2`目录下，运行

	`./build.sh`
	
	生成`foreveross/smartstack-kong-10-2`镜像

1. 修改 `./smartstack/nerve/nerve_services/`目录下的`kongService.json`文件

	```
	{
  		"host": "172.16.1.206",
  		"port": 8001,
  		"reporter_type": "zookeeper",
  		"zk_hosts": [
    		"112.74.93.133:2181"
  		],
  		"zk_path": "/infra/services/kong",
  		"check_interval": 20,
  		"weight": 2,
  		"checks": [
    		{
      			"type": "http",
      			"uri": "/",
      			"timeout": 0.2,
      			"rise": 3,
      			"fall": 2
    		}
  		]
	}
	```
	根据具体情况配置以下参数，
	
	`host`: 本机IP 
	
	`port`: kong控制台端口，默认8001
	
	`zk_hosts`: zookeeper地址
	
	`zk_path`: 向zookeeper注册的路径
	
2. 配置`conf/kong-cluster.conf`的`pg_host`(默认数据库postgres)和`cluster_advertise`字段为本机IP。
3. 启动`./deploy.sh`
	
## kong dashboard

kong UI面板，可视化操作

kong 0.10.x 使用v2版

### 部署
启动`./start-kong-dashboard.sh`

### 参考

[https://github.com/PGBI/kong-dashboard](https://github.com/PGBI/kong-dashboard)

[https://hub.docker.com/r/pgbi/kong-dashboard/](https://hub.docker.com/r/pgbi/kong-dashboard/)
