# docker-discuz

`discuz`是一款社区论坛系统，将`discuz`做成容器化并发布到好雨云市需要注意以下的几个问题：

1、好雨默认的数据持久化目录是`/data`，在`Dockerfile`中亦可将挂载目录直接写成`/data`

2、discuz需要将以下的几个目录进行持久化操作

 * config
 * data
 * uc_server/data
 * uc_client/data/cache

3、配置文件中可以直接取关联的数据库的系统环境变量，好雨以变量注入的形式进行容器间的关联，所以你的配置文件可以写成这样：

```
$_config['db'][1]['dbhost']    		= $_ENV['MYSQL_HOST'] . ':' . $_ENV['MYSQL_PORT'];

$_config['db'][1]['dbuser']    		= $_ENV['MYSQL_USER'];
$_config['db'][1]['dbpw']      	    = $_ENV['MYSQL_PASS'];
$_config['db'][1]['dbcharset'] 		= 'utf8';
$_config['db'][1]['pconnect']  		= 0;
$_config['db'][1]['dbname']    		= 'discuz';
$_config['db'][1]['tablepre']  		= 'dis_';
```

服务正常运行后，即开始初始化安装论坛，会新建数据库及表。如果关联的数据库中新建过discuz库和表，目前还不支持覆盖及重写，需要使用新库。