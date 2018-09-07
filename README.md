# LogFileAutoCheck
分析.log文件
1、使用h2数据库 springboot项目
2、每次启动项目数据库信息会清空，如果不想清空可以将yml中h2的配置中的mem去掉
3、界面依赖于layui
4、分析json格式的log文件（每个log文件中是一天的日志）
    1）24个小时的数据进行分时统计 echart图标显示
    2）table显示每个log文件里面的每一条json数据
    
    
 未完成功能：
 1、周数据统计
 2、上传文件时若重名直接修改
