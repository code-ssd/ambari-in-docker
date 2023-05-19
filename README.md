# 介绍

ambari docker镜像

```
.
├── app.sh 创建/启动/停止
├── node   node节点镜像
├── init-ambari-server.sh node节点依赖脚本
├── init-hosts.sh         node节点依赖脚本
└── repo   ambari hdp本地仓库镜像
```


# quick start

`sh app.sh create`

然后参考https://www.cnblogs.com/startnow/p/17416314.html

# 局域网中的windows访问docker网络
```
如果centos7的ip是192.168.8.147
windows 添加路由, -p永久 
route add -p 172.17.0.0 mask 255.255.0.0 192.168.8.147

linux 修改完后一定要重启
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
```
