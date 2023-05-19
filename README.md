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