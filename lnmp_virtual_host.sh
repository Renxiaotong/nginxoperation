#!/bin/bash

#*******此脚本根据位置变量搭建lnmp虚拟主机(只限基于域名的虚拟主机)********#

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


sed -i "${input_line} a\#virtual host $1 begin\nserver {\n listen       80;\n server_name  $1;\n #charset koi8-r;\n#access_log  logs/host.access.log  main;\nlocation / {\nroot   $1;\n index  index.html index.htm;\n}\n#error_page  404              /404.html;\n # redirect server error pages to the static page /50x.html\n#\n # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000\n#\nlocation ~ \.php$ {\nroot           $1;\nfastcgi_pass   127.0.0.1:9000;\nfastcgi_index  index.php;\n#fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;\n include        fastcgi.conf;\n }\n}\n#virtual host $1 end" ${cur_work_dir}/conf/nginx.conf

sed -i "/virtual_host/s/$/\t${1}/" /root/NGINX/host;

echo "$ip $1" >> /etc/hosts 



