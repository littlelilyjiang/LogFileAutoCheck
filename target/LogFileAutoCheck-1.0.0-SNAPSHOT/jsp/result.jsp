<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/js/layui/css/layui.css" media="all">
<title>Insert title here</title>
</head>
<body>
<div id="resultTableDiv" >
  	<div id="resultTable" lay-filter="resultTableFil"></div>
  	<div id="resultTablePageInfo" ></div>
  	</div>
  <script src="${pageContext.request.contextPath}/js/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/layui/upload.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
<script src="${pageContext.request.contextPath}/js/echarts.common.min.js"></script>
<script src="${pageContext.request.contextPath}/js/timeformat.js"></script>

<script type="text/javascript">
	 var _path="${pageContext.request.contextPath}";
	 </script>	
<script>
var className = '${className}';
var methodName = '${methodName}';


layui.use('table', function(){
  var table = layui.table;

  table.render({
    elem: '#resultTable'
    ,data:${data}
    ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
    ,pageSize:15
    ,limit:100
    ,cols: [[
 		      {field:'class', width:400, title: '类名'}
 		      ,{field:'time', title: '总时间', width: '80', sort: true}
 		      ,{field:'counter', width:80, title: '总次数', sort: true}
 		      ,{field:'avg',width:80, title: '平均数', sort: true}//minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
 		      ,{field:'day',width:150, title: '日期', sort: true}
 		      ,{field:'startAndEnd',width:200, title: '时间段', templet: 
  		    	  function(obj){
    		    	var date1 = new Date();
    		      	date1.setTime(obj.startTime);
    		      	var start = date1.Format("hh:mm:ss");
    		      var date2 = new Date();
    		      	date2.setTime(obj.endTime);
    		      	var end = date2.Format("hh:mm:ss");
    		      	return start+" - "+end
		      	}}
 		    ]]
  });
  
  table.on('sort(resultTableFil)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		newfield=obj.field;
		newtype= obj.type
		getTableResult(1,obj.field,obj.type);
		
	}) 
	
	
});

layui.use('laypage', function(){
  	var laypage = layui.laypage;
  		//执行一个laypage实例
  		laypage.render({
  		    elem: 'resultTablePageInfo' //注意，这里的 test1 是 ID，不用加 # 号
  		    ,count: ${data}.length //数据总数，从服务端得到
  		    ,curr:1
  		    ,limit: 100
  		  	,layout: ['count', 'prev', 'page', 'next']
  		    ,jump:function(data, first){
  		    	if(!first){ //点击右下角分页时调用
  		    		getTableResult(data.curr);
                  }
              }
  		  });
  		})

 
function getTableResult(page,newfield,newtype){

	$.ajax({
        url: _path +'/logFileAnalysis/getDetailTableResult',
        data:{"page":page,"type":newfield,"order":newtype,"className":className,"methodName":methodName},
        async:true,
        dataType: "json",
        success: function(data){
        	
        	 var newfield,newtype;
        	
        	 layui.use('table', function(){
        		  var table = layui.table;

        		  table.render({
        		    elem: '#resultTable'
        		    ,data:data.data
        		    ,cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
        		    ,pageSize:15
        		    ,limit:100
        		    ,cols: [[
        		 		      {field:'class', width:400, title: '类名'}
        		 		      ,{field:'time', title: '总时间', width: '80', sort: true}
        		 		      ,{field:'counter', width:80, title: '总次数', sort: true}
        		 		      ,{field:'avg',width:80, title: '平均数', sort: true}//minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
        		 		      ,{field:'day',width:150, title: '日期', sort: true}
        		 		      ,{field:'startAndEnd',width:200, title: '时间段', templet: 
        	      		    	  function(obj){
        		      		    	var date1 = new Date();
        		      		      	date1.setTime(obj.startTime);
        		      		      	var start = date1.Format("hh:mm:ss");
        		      		      var date2 = new Date();
        		      		      	date2.setTime(obj.endTime);
        		      		      	var end = date2.Format("hh:mm:ss");
        		      		      	return start+" - "+end
        	      		      	}}
        		 		    ]]
        		  });
        		  
        		  table.on('sort(resultTableFil)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
        				newfield=obj.field;
        				newtype= obj.type
        				getTableResult(1,obj.field,obj.type);
        				
        			}) 
        			
        			
        		});
        	 var newfield,newtype;
        		layui.use('laypage', function(){
        		  	var laypage = layui.laypage;
        		  		//执行一个laypage实例
        		  		laypage.render({
        		  		    elem: 'resultTablePageInfo' //注意，这里的 test1 是 ID，不用加 # 号
        		  		    ,count: data.count //数据总数，从服务端得到
        		  		    ,curr:data.pages
        		  		  ,limit:100
        		  		  	,layout: ['count', 'prev', 'page', 'next']
        		  		    ,jump:function(data, first){
        		  		    	if(!first){ //点击右下角分页时调用
        		  		    		getTableResult(data.curr,newfield,newtype);
        		                  }
        		              }
        		  		  });
        		  		})
        	
            }
    });
}
</script>
</body>
</html>