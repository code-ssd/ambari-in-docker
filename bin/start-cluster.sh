docker start amb-server
docker start amb1
docker start amb2

docker exec -it amb-server bash /root/init-hosts.sh
docker exec -it amb1       bash /root/init-hosts.sh
docker exec -it amb2       bash /root/init-hosts.sh


docker exec -it amb-server ambari-server start
docker exec -it amb-server ambari-agent start
docker exec -it amb1       ambari-agent start
docker exec -it amb2       ambari-agent start