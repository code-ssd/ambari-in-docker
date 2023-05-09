FROM centos:7

RUN curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo \
&& curl -o /etc/yum.repos.d/CentOS-epel.repo https://mirrors.aliyun.com/repo/epel-7.repo && yum clean all && yum makecache

RUN yum install epel-release -y && yum install -y systemd*

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

RUN yum install -y yum-utils yum-plugin-ovl tar wget git curl bind-utils unzip ntp openssh-server openssh-clients \
telnet net-tools initscripts sshpass python-pip python-wheel && systemctl enable sshd && systemctl enable ntpd


RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N "" && ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N "" \
&& ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N "" && ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P "" && echo 'root:123456a@' | chpasswd


ADD init-ambari-server.sh                  /root/init-ambari-server.sh
ADD init-hosts.sh                          /root/init-hosts.sh
ADD postgresql-42.2.14.jar                 /root/postgres-jdbc-driver.jar
ADD libpq5-12.3-10PGDG.rhel7.x86_64.rpm                       /root/libpq5-12.3-10PGDG.rhel7.x86_64.rpm
ADD python2-psycopg2-2.8.5-2.rhel7.x86_64.rpm                 /root/python2-psycopg2-2.8.5-2.rhel7.x86_64.rpm
RUN cd /root && rpm -ivh *.rpm && rm -rf *.rpm

RUN mkdir /usr/jdk64
ADD jdk-8u333-linux-x64.tar.gz             /usr/jdk64
ENV JAVA_HOME /usr/jdk64/jdk1.8.0_333
ENV PATH $PATH:$JAVA_HOME/bin


ENV REPO_URL 192.168.8.147:8383
RUN wget -nv http://$REPO_URL/2.7.6.3-2/ambari.repo -O	/etc/yum.repos.d/ambari.repo
RUN wget -nv http://$REPO_URL/3.3.1.0-002/hdp.repo  -O	/etc/yum.repos.d/hdp.repo
RUN yum install -y ambari-agent ambari-server && yum clean all && pip install psycopg2-binary==2.8.5





