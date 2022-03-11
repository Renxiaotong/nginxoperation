#!/bin/bash

#*******此脚本根据位置变量搭建虚拟主机(认证功能)********#



#确认当前nginx安装位置
cur_work_dir=$(awk '/^work_dir/{print $2}' /root/NGINX/envps);
[ ${cur_work_dir:0-1:1} == "/" ] && cur_work_dir=${cur_work_dir%/*};

#确认当前ip

ip=$(awk '/ip/{print $2}' /root/NGINX/envps);

#找出当前追加位置

let input_line=$(awk '/sendfile/{print NR}' ${cur_work_dir}/conf/nginx.conf);

let input_line++;

#一次只能搭建一台

[ $# -lt 1 ] && echo "虚拟主机数量过多，请尝试只搭建一台虚拟主机";

mkdir  ${cur_work_dir}/$1;	echo "welcome to $1" > ${cur_work_dir}/$1/index.html; 

sed -i "${input_line} a\#virtual host $1 begin\nserver {\nlisten 80;\nserver_name $1;\n auth_basic   'input passwd';\n auth_basic_user_file ${cur_work_dir}/pass;\n location / {\nroot $1;\nindex index.html index.htm;\n}	\n}\n#virtual host $1 end" ${cur_work_dir}/conf/nginx.conf

#需要安装httpd-tools

#yum clean all &> /dev/null;

#let check=$(yum repolist | awk '/repolist/{print $2}');

#[ $check -le 0 ] && echo "yum异常" && exit;

#yum -y install httpd-tools &> /dev/null;

#需要在当前工作目录创建登录用户表(默认第一个用户为nginx，密码为nginx)
#第一次创建 htpasswd -c ${cur_work_dir}/pass  nginx; 
#追加用户 htpasswd ${cur_work_dir]/pass user_1

sed -i "/virtual_host/s/$/\t${1}/" /root/NGINX/host;
echo "$ip $1" >> /etc/hosts 


