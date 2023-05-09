# ambari 2.7.6 in docker
仓库含有大文件，记得安装LFS
## 环境
centos7 48G内存, 启动完常用组件大约占用了14G内存。

## 软件包下载
HDP 3.3.1.0-002版本从公众号：HiDataPlus 下载。
或者使用阿里云下载(ambari-in-docker https://www.aliyundrive.com/s/gQXWmpNVC5F  提取码: qd46)我的repo文件夹。
```
ambari-2.7.6.3-2-centos7_8-x86_64.tar.gz
HDP-3.3.1.0-002-centos7_8-x86_64.tar.gz
HDP-UTILS-1.1.0.22-centos7_8-x86_64.tar.gz
unzip_repo.sh
```
修改unzip_repo.sh脚本的REPO_URL
然后运行脚本,会创建repo文件夹.

或者手动解压软件包和修改对应repo文件的地址。
最后结构如下：
```
3.3.1.0-002/
├── ambari-2.7.6.3-2-centos7_8-x86_64.tar.gz
├── HDP-3.3.1.0-002-centos7_8-x86_64.tar.gz
├── HDP-UTILS-1.1.0.22-centos7_8-x86_64.tar.gz
├── repo
│   ├── 2.7.6.3-2
│   │   ├── ambari
│   │   ├── ambari.repo
│   │   ├── ....
│   │   └── RPM-GPG-KEY
│   ├── 3.3.1.0-002
│   │   ├── hdp.repo
│   │   ├── ....
│   │   ├── tez
│   │   └── zookeeper
│   └── HDP-UTILS
│       └── centos7
└── start_repo.sh

```

## 启动repo
```bash
python -m http.server 8383
```

## build image
修改`docker file`
```
ENV REPO_URL 192.168.8.147:8383
```
构建镜像  `sh bin/build.sh`



## 第一次 create cluster
```
sh bin/create-cluster.sh

```
会初始化环境和启动容器

## start/stop cluster
```
sh bin/start-cluster.sh
sh bin/stop-cluster.sh
```

## 局域网中的windows访问docker网络
centos7的ip是192.168.8.147
```
windows 添加路由, -p永久 
route add -p 172.18.0.0 mask 255.255.0.0 192.168.8.147

linux 修改完后一定要重启
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
```


## 安装ambari安装使用的Repositories

HDP-3.3  HDP-UTILS-1.1.0.22
```
http://192.168.8.147:8383/3.3.1.0-002
```

##  查看私钥
```
docker exec -it amb-server cat /root/.ssh/id_rsa

# 添加节点 一共三个
amb[1-2].hadoop.demo
amb-server.hadoop.demo
```
