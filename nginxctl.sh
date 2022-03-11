#!/bin/bash


#*****nginx总控入口与全局变量*****#

#确认nginx安装位置
source_work_dir=$(awk '/^work_dir/{print $2}' /root/NGINX/envps); 

#确认本机ip

ip=$(awk '/ip/{print $2}' /root/NGINX/envps); 

case $1 in

	#查看、修改nginx的工作目录(通常使用本工具装载后会自动更新无需修改) 
	-r)
	
		[ -z $2 ] && echo "$source_work_dir" || sed -i "/^work_dir/s%$source_work_dir%$2%" /root/NGINX/envps;
	;;
	#查看、修改本机的ip地址(默认ip地址为192.168.2.5)如果你的机器ip不是这个需要修改
	-ip)

		[ -z $2 ] && echo "$ip" || sed -i "/ip/s%$ip%$2%" /root/NGINX/envps;
	;;	
	#查看所有已经创建的虚拟主机	
	-hosts)
			
		cat /root/NGINX/host;
	;;
	#地址重写技术(预留)
	-rewrite)
	
	;;

	#virtual host build

	#nginx.sh -v 创建一个虚拟主机
	
	-v)
		 [ -z $2 ] && echo "you need to enter a servername"&& exit || bash /root/NGINX/virtual_host.sh $2;
	;;
 	#创建一个基于httpd-tools的认证网页	
	-vp)
		 [ -z $2 ] && echo "you need to enter a servername"&& exit || bash /root/NGINX/pass_virtual_host.sh $2;

	;;
	#创建一个lnmp的php解释动态虚拟网页(需要开启php-fpm，php-mariadb等服务)
	-vn)
		 [ -z $2 ] && echo "you need to enter a servername"&& exit || bash /root/NGINX/lnmp_virtual_host.sh $2;

	;;	
	#开启nginx(已经开了就不要开了，会报错)
	start)
		[ ${source_work_dir:1:1} == "/" ] && source_work_dir=${source_work_dir%/*};

		${source_work_dir}/sbin/nginx;
	;;
	#重新加载nginx
	reload)
		[ ${source_work_dir:1:1} == "/" ] && source_work_dir=${source_work_dir%/*};
	
		${source_work_dir}/sbin/nginx -s reload;
	;;
	
	#创建一个https虚拟主机（基于SSL加密网站的虚拟主机，通过私钥、证书对该站点数据进行加密）
	-vs)
		 [ -z $2 ] && echo "you need to enter a servername"&& exit || bash /root/NGINX/https_virtual_host.sh $2;
				
		
	;;
	#删除一个虚拟主机，无论其是什么类型
	-d)
		[ -z $2 ] && exit || bash /root/NGINX/del_virtual_host.sh $2 
	;;

	




	*)

	echo "没有这个选项";

esac
