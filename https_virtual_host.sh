#!/bin/bash

#*******此脚本根据位置变量搭建虚拟主机********#


#确认当前nginx安装位置
cur_work_dir=$(awk '/^work_dir/{print $2}' /root/NGINX/envps);
[ ${cur_work_dir:0-1:1} == "/" ] && cur_work_dir=${cur_work_dir%/*};
#确认当前ip

ip=$(awk '/ip/{print $2}' /root/NGINX/envps);



#找出当前追加位置

let input_line=$(awk '/HTTPS/{print NR}' ${cur_work_dir}/conf/nginx.conf);

let input_line++;

#一次只能搭建一台

[ $# -lt 1 ] && echo "虚拟主机数量过多，请尝试只搭建一台虚拟主机";

mkdir  ${cur_work_dir}/$1;	echo "welcome to $1" > ${cur_work_dir}/$1/index.html; 


sed -i "${input_line}a #virtual host $1 begin\nserver{\n	listen 443 ssl;\n	server_name $1;	\n	ssl_certificate 	cert.pem;\n	ssl_certificate_key     cert.key;\n	ssl_session_cache	shared:SSL:1m;\n	ssl_session_timeout 	5m;\nssl_ciphers	HIGH:!aNULL:!MD5;\n	ssl_prefer_server_ciphers     on;\nlocation / {\nroot  $1;\nindex index.html index.htm;\n}\n}\n#virtual host $1 end\n" ${cur_work_dir}/conf/nginx.conf;


sed -i "/virtual_host/s/$/\t${1}/" /root/NGINX/host;
#生成私钥与证书即可进行测试

echo "$ip $1" >> /etc/hosts 
