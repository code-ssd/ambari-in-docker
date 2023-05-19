echo '127.0.0.1   localhost'> /etc/hosts
echo '172.188.0.2 repo.hdp.link'>> /etc/hosts
echo '172.188.0.3 amb-server.hdp.link amb-server'>> /etc/hosts
node_num=2
for (( i=1; i<=node_num; i++ ))
do
    ip="172.188.0.$((3+$i))"
    echo "$ip amb$i.hdp.link amb$i">> /etc/hosts
done

sleep 3
sshpass -p '123456' ssh-copy-id -o  "StrictHostKeyChecking no" localhost
for (( i=1; i<=node_num; i++ ))
do
    sshpass -p '123456' ssh-copy-id -o  "StrictHostKeyChecking no" amb$i
done


