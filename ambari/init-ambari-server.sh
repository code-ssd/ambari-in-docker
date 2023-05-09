sshpass -p '123456a@' ssh-copy-id -o "StrictHostKeyChecking no" localhost
sshpass -p '123456a@' ssh-copy-id -o "StrictHostKeyChecking no" amb-server
sshpass -p '123456a@' ssh-copy-id -o "StrictHostKeyChecking no" amb1
sshpass -p '123456a@' ssh-copy-id -o "StrictHostKeyChecking no" amb2


ambari-server setup -j /usr/jdk64/jdk1.8.0_333 -s

ambari-server start

echo "host  all  all 0.0.0.0/0  md5" >> /var/lib/pgsql/data/pg_hba.conf
cat > /tmp/create_hive.sql <<EOF  
CREATE DATABASE hive;
CREATE USER hive WITH PASSWORD 'hive';
GRANT ALL PRIVILEGES ON DATABASE hive TO hive;
CREATE DATABASE hue;
CREATE USER hue WITH PASSWORD 'hue';
GRANT ALL PRIVILEGES ON DATABASE hue TO hue;
EOF
chmod +r /tmp/create_hive.sql
su - postgres -c 'psql -U postgres -f /tmp/create_hive.sql'
systemctl restart postgresql

ambari-server setup --jdbc-db=postgres --jdbc-driver=/root/postgres-jdbc-driver.jar