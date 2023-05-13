# 第一次运行
docker network create --subnet=172.18.0.0/16 ambari_net


docker run -d --privileged --name amb-server   --network ambari_net --ip 172.18.0.2 -it  tungshuaishuai/ambari:2.7.6.3
docker run -d --privileged --name amb1         --network ambari_net --ip 172.18.0.3 -it  tungshuaishuai/ambari:2.7.6.3
docker run -d --privileged --name amb2         --network ambari_net --ip 172.18.0.4 -it  tungshuaishuai/ambari:2.7.6.3

docker exec -it amb-server hostname amb-server.hadoop.demo
docker exec -it amb1       hostname amb1.hadoop.demo
docker exec -it amb2       hostname amb2.hadoop.demo

docker cp init-hosts.sh amb-server:/root

docker cp init-hosts.sh amb1:/root
docker cp init-hosts.sh amb2:/root

docker exec -it amb-server bash /root/init-hosts.sh
docker exec -it amb1       bash /root/init-hosts.sh
docker exec -it amb2       bash /root/init-hosts.sh


docker exec -it amb-server bash /root/init-ambari-server.sh


