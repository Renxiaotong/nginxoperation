#这是一个自动下载，一键配置NGINX的脚本
#可支持的功能为: 一键配置 lnmp 动态网页，一键配置虚拟主机，一键配置https虚拟主机。还可以支持多种功能。

EXAMPLE
	bash nginxctl.sh [options] <虚拟主机名> #<虚拟机名是自己定义的>	

	[opstios]
        -r)
	#查看、修改nginx的工作目录(通常使用本工具装载后会自动更新无需修改) 

        -ip)
        #查看、修改本机的ip地址(默认ip地址为192.168.2.5)如果你的机器ip不是这个需要修改

        -hosts)
        #查看所有已经创建的虚拟主机     

        -rewrite)
        #地址重写技术(预留)

        #virtual host build

        -v)
        #nginx.sh -v 创建一个虚拟主机

        -vp)
        #创建一个基于httpd-tools的认证网页      
        
	-vn)
	#创建一个lnmp的php解释动态虚拟网页(需要开启php-fpm，php-mariadb等服务)
        
	start)
        #开启nginx(已经开了就不要开了，会报错)
        
        reload)
	#重新加载nginx

        -vs)
        #创建一个https虚拟主机（基于SSL加密网站的虚拟主机，通过私钥、证书对该站点数据进行加密）

        -d)
        #删除一个虚拟主机，无论其是什么类型
 
