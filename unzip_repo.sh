mkdir -p repo
tar -zxvf HDP-3.3.1.0-002-centos7_8-x86_64.tar.gz           -C repo
tar -zxvf HDP-UTILS-1.1.0.22-centos7_8-x86_64.tar.gz        -C repo
tar -zxvf ambari-2.7.6.3-2-centos7_8-x86_64.tar.gz          -C repo


sed -i 's/repo.hdp.link:8383\/ambari\/centos7/192.168.8.147:8383/g' repo/2.7.6.3-2/ambari.repo
sed -i 's/repo.hdp.link:8383\/HDP\/centos8/192.168.8.147:8383/g'    repo/3.3.1.0-002/hdp.repo
sed -i 's/repo.hdp.link:8383\/HDP-UTILS\/centos8/192.168.8.147:8383\/HDP-UTILS\/centos7/g'                  repo/3.3.1.0-002/hdp.repo

