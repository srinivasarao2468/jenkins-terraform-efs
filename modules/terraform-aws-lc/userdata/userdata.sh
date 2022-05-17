#!/bin/bash
yum erase java -y
yum install java-1.8.0-openjdk-devel.x86_64 -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y
chkconfig jenkins on
yum -y install nfs-utils
mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${file_system_id}.efs.${region}.amazonaws.com:/   /var/lib/jenkins/
chown -R jenkins:jenkins /var/lib/jenkins
service jenkins start
