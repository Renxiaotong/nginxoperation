#!/bin/bash

#*******此脚本根据位置变量搭建虚拟主机(只限基于域名的虚拟主机)********#

#确认当前nginx安装位置
cur_work_dir=$(awk '/^work_dir/{print $2}' /root/NGINX/envps);

#确认当前ip

ip=$(awk '/ip/{print $2}' /root/NGINX/envps);


[ ${cur_work_dir:0-1:1} == "/" ] && cur_work_dir=${cur_work_dir%/*};


#找出当前追加位置

let input_line=$(awk '/sendfile/{print NR}' ${cur_work_dir}/conf/nginx.conf);

let input_line++;

#一次只能搭建一台

[ $# -lt 1 ] && echo "虚拟主机数量过多，请尝试只搭建一台虚拟主机";

mkdir  ${cur_work_dir}/$1;	echo "welcome to $1" > ${cur_work_dir}/$1/index.html; 

sed -i "${input_line} a\#virtual host $1 begin\nserver {\nlisten 80;\nserver_name $1;\nlocation / {\nroot $1;\nindex index.html index.htm;\n}	\n}\n#virtual host $1 end" ${cur_work_dir}/conf/nginx.conf

sed -i "/virtual_host/s/$/\t${1}/" /root/NGINX/host;

echo "$ip $1" >> /etc/hosts 
