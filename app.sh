#!/bin/bash
set -ex

docker pull tungshuaishuai/ambari-repo:2.7.6.3
docker pull tungshuaishuai/ambari-node:2.7.6.3


node_num=2

function create(){
    echo "创建网络"
    docker network create --subnet=172.188.0.0/16 ambari_cluster_net

    echo "启动repo"
    docker run -d --name ambari-repo  --network ambari_cluster_net --ip 172.188.0.2 -it  tungshuaishuai/ambari-repo:2.7.6.3

    echo "初始化脚本init-hosts.sh"
    sed -i s/node_num=.*/node_num=$node_num/g init-hosts.sh


    echo "创建ambari-server"
    docker run -d --privileged --name amb-server   --network ambari_cluster_net --ip 172.188.0.3 -it  tungshuaishuai/ambari-node:2.7.6.3
    docker cp init-hosts.sh         amb-server:/root/
    docker cp init-ambari-server.sh amb-server:/root/


    for (( i=1; i<=node_num; i++ ))
    do
        echo "创建ambari-agent$i"
        docker run -d --privileged --name  amb$i   --network ambari_cluster_net --ip 172.188.0.$((3+$i)) -it  tungshuaishuai/ambari-node:2.7.6.3
        docker cp init-hosts.sh    amb$i:/root/
    done


    echo "执行init-hosts"
    docker exec -it amb-server bash /root/init-hosts.sh
    docker exec -it amb-server wget http://repo.hdp.link/ambari/centos7/2.7.6.3-2/ambari.repo -P /etc/yum.repos.d/
    docker exec -it amb-server wget http://repo.hdp.link/HDP/centos8/3.3.1.0-002/hdp.repo -P /etc/yum.repos.d/
    for (( i=1; i<=node_num; i++ ))
    do
        docker exec -it amb$i   bash /root/init-hosts.sh
        docker exec -it amb$i wget http://repo.hdp.link/ambari/centos7/2.7.6.3-2/ambari.repo -P /etc/yum.repos.d/
        docker exec -it amb$i wget http://repo.hdp.link/HDP/centos8/3.3.1.0-002/hdp.repo -P /etc/yum.repos.d/
    done


    echo "初始化ambari-server"
    docker exec -it amb-server bash /root/init-ambari-server.sh
    
}


function start(){
    echo "执行start"
    docker start amb-server

    for (( i=1; i<=node_num; i++ ))
    do
        docker start amb$i
    done
    docker exec -it amb-server bash /root/init-hosts.sh
    docker exec -it amb-server ambari-server start
    docker exec -it amb-server ambari-agent start
    
    for (( i=1; i<=node_num; i++ ))
    do
        docker exec -it amb$i       bash /root/init-hosts.sh
        docker exec -it amb$i ambari-agent start
    done

}



function stop(){
    echo "执行stop"
    docker stop amb-server
    for (( i=1; i<=node_num; i++ ))
    do
        docker stop amb$i
    done
}


case "$1" in
   'start')
      start
      ;;
   'stop')
     stop
     ;;
   'create')
     create
     ;;
  *)
     echo "Usage: $0 {start|stop|create}"
     exit 1
esac
exit 0