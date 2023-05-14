cat > /etc/hosts <<EOF
127.0.0.1       localhost
172.18.0.2 amb-server.hadoop.demo amb-server
172.18.0.3 amb1.hadoop.demo amb1
172.18.0.4 amb2.hadoop.demo amb2
EOF

sshpass -p '123456' ssh-copy-id -o  "StrictHostKeyChecking no" localhost
sshpass -p '123456' ssh-copy-id -o  "StrictHostKeyChecking no" amb1
sshpass -p '123456' ssh-copy-id -o  "StrictHostKeyChecking no" amb2
sshpass -p '123456' ssh-copy-id -o  "StrictHostKeyChecking no" amb-server
