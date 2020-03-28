#!/bin/bash
#
# sshd seetting
echo '123' | passwd root --stdin
sed -i '/^PasswordAuthentication no/c\PasswordAuthentication yes' /etc/ssh/sshd_config

mkdir -m 600 /root/.ssh
cat > /root/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYSmGv1d33ietIAhSHHM4zTn4RpZhNAWVSW6LjJ2YPzvcS5yQzQvGW3udIOlt67IhRjWwTZahTzZxOmKax20k/iRd5SdKTX4OfrIh3RXNroBgaKQ5vosqYHgS6Bf3KRm72E1+cG0unfNgs+8kQqtm6qlLa6hVXyHRCrfHQQ3Sn4oQAejtDJK85rpuBrKhsnE9bT61tdnW2mQ56YC71/PZgZswwwzRQPi1bp/CFgHwM9DtKoGjDHeCo635QqniG5dAbaD+Diou4v7YQ3ooKl/vKVqcCBDUKSC2Rb5EOUHsAAMku1bQrqE9Im5wy9b6JUPG9goG2rWjQgTC3n55Ec5Xkn99sFMwNBWpI0P5vYLJ/Alc5V//2aHMajMatOpu0dlRo5XQNtmAFW+AnEHqDJqRelkIxNKa4h9xQH8AuGh/dY9jUKw1SHzwWDv6onm0+4MBZla5fNUPaEOjBjfYy4hPkoy8CK//ORKFMdmCzxZoOR8rkeOk3bVmPXgyZhFRX4oE= zxs@zxs
EOF
chmod 600 /root/.ssh/authorized_keys
systemctl restart sshd

# set selinux
setenforce 0
sed -i '/^SELINUX=enforcing/c\SELINUX=disable' /etc/selinux/config

# set yum repo
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

# set timezone
timedatectl set-timezone Asia/Shanghai

# set ulimit
cat >> /etc/security/limits.conf <<EOF
* soft noproc 65536
* hard noproc 65536
* soft nofile 65535
* hard nofile 65535 
EOF

# setup
yum install -y vim supervisor
