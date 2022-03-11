#!/bin/bash

#*******此脚本根据位置变量删除虚拟主机********#


#确认当前nginx安装位置
cur_work_dir=$(awk '/^work_dir/{print $2}' /root/NGINX/envps);

#确认当前ip

ip=$(awk '/ip/{print $2}' /root/NGINX/envps);



[ ${cur_work_dir:0-1:1} == "/" ] && cur_work_dir=${cur_work_dir%/*};


let begin=$(awk "/#virtual host $1 begin/{print NR}" ${cur_work_dir}/conf/nginx.conf) &> /dev/null;

[ -z $begin ] && echo "no such host,exit with fault" && exit;

let end=$(awk "/#virtual host $1 end/{print NR}" ${cur_work_dir}/conf/nginx.conf);

sed -i "${begin},${end}d" $cur_work_dir/conf/nginx.conf;

rm -rf ${cur_work_dir}/$1;

sed -i "/$ip $1/d" /etc/hosts;


sed -i "/virtual_host/s/${1}//" /root/NGINX/host;
echo "Sucssful  Delete!";
