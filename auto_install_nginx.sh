#!/bin/bash

#************此脚本用来，只用来自动安装nginx*************#

yum clean all &> /dev/null;

echo ">>>>>>>>>>>>>>>检查YUM>>>>>>>>>>>>>>>>"
let yum_check=$(yum repolist | awk '/^repolist:/ {print $2}');
[ $yum_check -le 0 ] && echo "yum异常" && exit;


tar -xf lnmp_soft.tar.gz -C /opt;
cd /opt/lnmp_soft; tar -xf nginx-1.17.6.tar.gz;
cd nginx-1.17.6;

echo ">>>>>>>>>>>>>>>安装依赖包>>>>>>>>>>>>>>>>"

echo ">>>>>>>>>需要一段时间请耐心等待>>>>>>>>>>>>>>>>"
/root/NGINX/speed.sh & 
yum -y install php php-fpm mariadb mariadb-server openssl-devel pcre-devel gcc make php-mysql &> /dev/null;
kill $!;

useradd -s /sbin/nologin nginx; 

source_dir=awk '/^work_dir/{print $2}' /root/NGINX/envps;

[ ! -z $1 ] && [ -d $1 ] && ./configure --user=nginx --prefix=$1  --with-http_ssl_module &&  sed -i "/^work_dir/s%$source_dir%$1%"|| ./configure --user=nginx  --with-http_ssl_module &> /dev/null;

echo ">>>>>>>>>>>>>>>开始编译>>>>>>>>>>>>>>>>";
/root/NGINX/speed.sh & 
make &> /dev/null;
kill $!;

echo ">>>>>>>>>>>>>>>开始安装>>>>>>>>>>>>>>>>"; 
make install &> /dev/null;

ls /usr/local/nginx/ &> /dev/null  && echo "安装成功";
