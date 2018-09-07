<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>文档分析自动化工具</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/js/layui/css/layui.css" media="all">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">文档分析自动化工具</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="#" onClick="javaAgent()">javaagentLog文件分析</a></li>
     <!--   <li class="layui-nav-item"><a href="#" onClick="xmlCheck()">xml文件比对</a></li>-->
     <!--  <li class="layui-nav-item">
        <a href="javascript:;">其它系统</a>
        <dl class="layui-nav-child">
          <dd><a href="">邮件管理</a></dd>
          <dd><a href="">消息管理</a></dd>
          <dd><a href="">授权管理</a></dd>
        </dl>
      </li>--> 
    </ul>
  </div>
  
  <!-- javaAngent的日志分析工具 -->
  <div id="javaAgentAnalysisDiv">
  	   <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
     
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
        <li class="layui-nav-item"><a href="#" onClick="upfiles()">上传文件</a></li>
        <li class="layui-nav-item layui-nav-itemed">
          <a onClick="getDays()">查看结果</a>
          <dl class="layui-nav-child" id ="checkResult">
            
          </dl>
        </li>
      </ul>
    </div>
  </div>
  
  	  <div class="layui-body" style="padding-left :20px;padding-top : 10px"> 
    	
		  <div class="layui-upload" id="selectFileDiv">
		 	<button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button> 
		  		<div class="layui-upload-list">
		    		<table class="layui-table">
		      			<thead>
		        			<tr><th>文件名</th>
		        			<th>大小</th>
		        			<th>状态</th>
		        			<th>操作</th>
		      				</tr>
		      			</thead>
		      <tbody id="demoList"></tbody>
		    		</table>
		  		</div>
		  <button type="button" class="layui-btn" id="testListAction">开始上传</button>
		  <!--   <button type="button" class="layui-btn" onClick="getDays()">生成结果</button> -->
		</div> 
		<div style="display:none" id="hiddenDays"></div>
		<div style="display:none" id="hiddenPages"></div>
		<form class="layui-form" action="" id="checkAnalyDiv">

  
  <!--  <table class="layui-hide" id="resultTable"></table>-->
  <div id="echartsDiv">
    <div  id="countEchart"  style="width: 1300px;height:190px;margin-top:-10px"></div>
  	</div>
  	
  <div class="layui-form-item" >
 
    <label class="layui-form-label" style="padding-left :20px;padding-top : 10px" >时间段选择</label>
    <div class="layui-input-inline" style="width:24%">
      <select id="times" lay-filter="times" name="times" lay-search>
        
      </select>
    
    </div>
  <!--   <div class="layui-input-inline" style="width:20%">
      <select id="classNames">
        
      </select>
    </div> 
      <button style="margin-top:5px" type="button" class="layui-btn" onClick="getEchartsResult()">查询图形形式结果</button>-->
    <label class="layui-form-label" style="width: 30px;padding-top : 10px">类名</label>
     <div class="layui-input-inline" style="width:25%">
      <input type="text" id="className" name="" placeholder="请输入" autocomplete="off" class="layui-input">
    </div>
    <label class="layui-form-label" style="width: 50px;padding-top : 10px">方法名</label>
     <div class="layui-input-inline" style="width:18%">
      <input type="text" id="methodName" name="" placeholder="请输入" autocomplete="off" class="layui-input">
    </div>
       <button style="margin-left:20px" type="button" class="layui-btn" onClick="getTableResult(1)">查询</button>
	
  </div>
  	 <div style="margin-left:28px"  id="resultTablePageInfo"></div>
  	<div id="resultTableDiv" >
  	<div id="resultTable" lay-filter="resultTableFil"></div>
  	
  	</div>
  </form>

	  </div>
	  
  	</div>
  
  <!-- xml比对工具 -->
   <div id="xmlCompareDiv">
  	  <div class="layui-body">
    <!-- 内容主体区域 -->
   <!-- <div style="padding: 15px;">xmlcompare</div> --> 
  </div>
  	
  </div>

  
  <div class="layui-footer" style="margin-left: -220px;">
    <!-- 底部固定区域 -->
   <p style="margin-left: 700px;"> © Thunisoft.com - 北京华宇信息科技<p>
  </div>
</div>
<script src="${pageContext.request.contextPath}/js/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/layui/upload.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
<script src="${pageContext.request.contextPath}/js/echarts.common.min.js"></script>
<script src="${pageContext.request.contextPath}/js/timeformat.js"></script>

<script type="text/javascript">
	 var _path="${pageContext.request.contextPath}";
	 </script>
<script type="text/html" id="typeName">
  <a href="#" onClick="searchMethodInfo('{{d.methodName}}','{{d.class}}')" class="layui-table-link">{{d.methodName}}</a>
</script>
<script type="text/html" id="class">
  <a href="#" onClick="searchClassInfo('{{d.class}}')" class="layui-table-link">{{d.class}}</a>
</script>
<script>

function setTime(time){
	console.info(time);
}

//JavaScript代码区域
layui.use('element', function(){
  var element = layui.element;
  
});

layui.use('form', function(){
	  var form = layui.form;
	  form.on('select(times)',function(data){
		  var startAndEndTime=$("#times").val();
		  var days =$("#hiddenDays").val();
			$.ajax({
		        url: _path +'/logFileAnalysis/getClassName',
		        data:{"days":days,"startAndEndTime":startAndEndTime},
		        async:false,
		        dataType: "json",
		        success: function(data){
		        	var html ='';
		        	if(data.length>0){
		        		for(var i =0 ;i<data.length;i++){
		        			 $('#classNames').append('<option value="'+i+'">'+data[i]+'</option>');
		        		}
		        	}
		        	 renderForm();
		            }
		    });

	  })
	});
	



$("#javaAgentAnalysisDiv").show();
$("#xmlCompareDiv").hide();
$("#checkAnalyDiv").hide();


var startAndEndTime = null;
function getTableResult(page,startAndEndTime,field,type){
	if(startAndEndTime == null){
		startAndEndTime=$("#times").val();
	}
	var files =$("#hiddenDays").val();
	var className=$("#className").val();
	var methodName=$("#methodName").val();
	var page = page;
	$.ajax({
        url: _path +'/logFileAnalysis/getTableResult',
        data:{"files":files,"startAndEndTime":startAndEndTime,"page":page,"type":field,"order":type,"className":className,"methodName":methodName},
        async:true,
        dataType: "json",
        success: function(data){
        	
        	 var newfield,newtype;
        	
        	layui.use('table', function(){
      		  var table = layui.table;
      		  table.render({
      		    elem: '#resultTable'
      		    ,data:data.data
      		 	 ,limit: 100
      		    ,cols: [[
      		      {field:'class', width:600, title: '类名', templet: '#class'}
      		      ,{field:'methodName', width:200, title: '方法名', templet: '#typeName'}
      		      ,{field:'time', title: '总时间', width: '80', sort: true}
      		      ,{field:'counter', width:80, title: '总次数', sort: true}
      		      ,{field:'avg',width:80, title: '平均数', sort: true}//minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
      		      ,{field:'day',width:110, title: '日期'}
      		      ,{field:'startAndEnd',width:180, title: '时间段', templet: 
      		    	  function(obj){
	      		    	var date1 = new Date();
	      		      	date1.setTime(obj.startTime);
	      		      	var start = date1.Format("hh:mm:ss");
	      		      var date2 = new Date();
	      		      	date2.setTime(obj.endTime);
	      		      	var end = date2.Format("hh:mm:ss");
	      		      	return start+" - "+end
      		      	}
      		      }
      		    ]]
      		  });
      		 
      		  
      		table.on('sort(resultTableFil)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
      			newfield=obj.field;
      			newtype= obj.type
      			getTableResult(1,null,obj.field,obj.type);
	      		
      		}) 
      		});

        	layui.use('laypage', function(){
      		  var laypage = layui.laypage;
      		  //执行一个laypage实例
      		  laypage.render({
      		    elem: 'resultTablePageInfo' //注意，这里的 test1 是 ID，不用加 # 号
      		    ,count: data.count //数据总数，从服务端得到
      		    ,curr:data.pages
      		    ,limit: 100
      		  	,layout: ['count', 'prev', 'page', 'next']
      		    ,jump:function(data, first){
      		    	if(!first){ //点击右下角分页时调用
      		    		getTableResult(data.curr,startAndEndTime,newfield,newtype);
                      }
                  }
      		  });
      		})
        	
            }
    });
}

function searchMethodInfo(methodName,className){
	
	layui.use('layer', function(){ //独立版的layer无需执行这一句
		  var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句	
			//触发事件
		  layer.open({
    	      type: 2,
    	      title: methodName+'总数据详情',
    	      shadeClose: true,
    	      shade: false,
    	      maxmin: true, //开启最大化最小化按钮
    	      area: ['950px', '600px'],
    	      content: _path + '/logFileAnalysis/toResultPage?methodName='+methodName+"&className="+className,

    	    });
				  
				});
	
}

function searchClassInfo(className){
	
	layui.use('layer', function(){ //独立版的layer无需执行这一句
		  var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句	
			//触发事件
		  layer.open({
    	      type: 2,
    	      title: className+'总数据详情',
    	      shadeClose: true,
    	      shade: false,
    	      maxmin: true, //开启最大化最小化按钮
    	      area: ['950px', '600px'],
    	      content: _path + '/logFileAnalysis/toClassResultPage?className='+className,

    	    });
				  
				});
	
}

function javaAgent(){
	$("#javaAgentAnalysisDiv").show();
	$("#selectFileDiv").show();
	$("#xmlCompareDiv").hide();
	$("#checkAnalyDiv").hide();
	
}

function xmlCheck(){
	$("#javaAgentAnalysisDiv").hide();
	$("#xmlCompareDiv").show();
	$("#checkAnalyDiv").hide();
}

//重新渲染表单
function renderForm(){
	layui.use('form', function(){
		var form = layui.form;//高版本建议把括号去掉，有的低版本，需要加()
		form.render();
	});
}
var msg;
function getEchartsResult(startAndEndTime){
	if(startAndEndTime = null){
		startAndEndTime=$("#times").val();
	}
	var files =$("#hiddenDays").val();
	$.ajax({
        url: _path +'/logFileAnalysis/getEchartResult',
        data:{"files":files},
        async:true,
        dataType: "json",
        success: function(data){
        		getEchart('countEchart',JSON.parse(data.xData),JSON.parse(data.y1Data),JSON.parse(data.y2Data),JSON.parse(data.y3Data));
        		getTableResult(data.curr,startAndEndTime);
        		layer.close(msg);
        }
    });

}



function getEchart(eleNmae,xData,y1Data,y2Data,y3Data){
	var chart = echarts.init(document.getElementById(eleNmae));
	//指定图表的配置项和数据
option = {
    title: {
        text: '当日总计折线图'
    },
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        data:['总时间','总次数','总平均值']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    toolbox: {
        feature: {
            saveAsImage: {}
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: xData
    },
    yAxis: {
        type: 'value'
    },
    series: [
        {
            name:'总时间',
            type:'line',
            data:y2Data
        },{
            name:'总次数',
            type:'line',
            itemStyle: {
                normal: {
                    color: "#2ec7c9",
                    lineStyle: {
                        color: "#2ec7c9"
                    }
                }
            },
            data:y1Data
        },{
            name:'总平均值',
            type:'line',
            data:y3Data
        }
    ]
};

	//使用刚指定的配置项和数据显示图表。
	chart.setOption(option);
	
	
}


function checkAnaly(files){
	msg = layer.msg('努力查询中...', {icon: 16,shade: [0.5, '#f5f5f5'],scrollbar: false,offset: '0px', time:100000}) ;
	$('#times').html(''); 
	$("#hiddenDays").val(files);
	$("#javaAgentAnalysisDiv").show();
	$("#selectFileDiv").hide();
	$("#xmlCompareDiv").hide();
	$("#checkAnalyDiv").show();
	$.ajax({
        url: _path +'/logFileAnalysis/getTimes',
        data:{"files":files},
        async:false,
        dataType: "json",
        success: function(data){
        	var html ='';
        	$('#times').append('<option value="null">无</option>');
        	if(data.length>0){
        		for(var i =0 ;i<data.length;i++){
        			 $('#times').append('<option value="'+data[i]+'">'+data[i]+'</option>');
        		}
        		
        	}
        	getEchartsResult(1,data[0]);
        	
        	 renderForm();
            }
    });
	
	
}

function deletes(files){
	layer.confirm("确认要删除吗，删除后不能恢复", { title: "删除确认" }, function (index) {
        layer.close(index);
        msg = layer.msg('努力删除文件中...', {icon: 16,shade: [0.5, '#f5f5f5'],scrollbar: false,offset: '0px', time:100000}) ;
        $.ajax({
            url: _path +'/logFileAnalysis/deleteFiles',
            data:{"files":files},
            async:false,
            dataType: "json",
            success: function(data){
            	if(data.code == 0){
            		layer.msg('文件删除成功啦！', {
            	          time: 20000, //20s后自动关闭
            	          btn: ['明白了']
            	        });
            		location.reload();
            	}else{
            		layer.msg('文件删除失败，请重试', {
          	          time: 20000, //20s后自动关闭
          	          btn: ['明白了']
          	        });
            		layer.close(msg);
            	}
            }
    	});
	});
}




function upfiles(){
	$("#selectFileDiv").show();
	$("#xmlCompareDiv").hide();
	$("#checkAnalyDiv").hide();
}

function getDays(){
	$.ajax({
        url: _path +'/logFileAnalysis/getDays',
        dataType: "json",
        success: function(data){
        	var html ='';
        	if(data.length==1&&data[0] == null){
        		return;
        	}
        	if(data.length>0){
        		for(var i =0 ;i<data.length;i++){
        			html+='<dd>  <div><button class="layui-btn layui-btn-sm" onClick = deletes("'+data[i]+'")><i class="layui-icon layui-input-inline" style="font-size: 20px;display: inline;" ></i></button><a class="layui-input-inline" style="display: inline;margin-left:-10px" onClick = checkAnaly("'+data[i]+'")>'+data[i]+'</a></div>  </dd>';
        		}
        		checkAnaly(data[0]);
        	}
        	// $('#checkAnalyDiv').html('');
        	 $('#checkResult').html(html);
            }
    });
}


layui.use('upload', function(){
	var $ = layui.jquery
	  ,upload = layui.upload;
	  //多文件列表示例
	  var demoListView = $('#demoList')
	  ,uploadListIns = upload.render({
	    elem: '#testList'
	    ,url: _path +'/logFileAnalysis/upload'
	    ,accept: 'file'
	    ,multiple: true
	    ,exts:'log'
	    ,auto: false
	    ,bindAction: '#testListAction'
	    ,choose: function(obj){   
	      var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
	      //读取本地文件
	      obj.preview(function(index, file, result){
	        var tr = $(['<tr id="upload-'+ index +'">'
	          ,'<td>'+ file.name +'</td>'
	          ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
	          ,'<td>等待上传</td>'
	          ,'<td>'
	            ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
	            ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
	          ,'</td>'
	        ,'</tr>'].join(''));
	        
	        //单个重传
	        tr.find('.demo-reload').on('click', function(){
	          obj.upload(index, file);
	        });
	        
	        //删除
	        tr.find('.demo-delete').on('click', function(){
	          delete files[index]; //删除对应的文件
	          tr.remove();
	          uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
	        });
	        
	        demoListView.append(tr);
	      });
	    }
	  ,before: function () {
		  if(demoListView.text().indexOf('上传成功')!=-1 && demoListView.text().indexOf('重传')==-1){
			  layer.msg('文件已全部上传完成', {
		          time: 20000, //20s后自动关闭
		          btn: ['明白了']
		        });
		  }else{
			  layer.msg('努力上传中...', {icon: 16,shade: [0.5, '#f5f5f5'],scrollbar: false,offset: '0px', time:100000}) ;
		  }
      }
	  ,done: function(res, index, upload){
	      if(res.code == 0){ //上传成功
	        var tr = demoListView.find('tr#upload-'+ index)
	        ,tds = tr.children();
	        tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
	        tds.eq(3).html(''); //清空操作
	        $('#times').html(''); 
	        $('#checkResult').html(''); 
	        getDays();
	        layer.msg('恭喜您，上传完成！',{time: 1000,offset: '10px'});
	        layer.close();
	        return delete this.files[index]; //删除文件队列已经上传成功的文件
	      }
	      layer.msg('上传的文件已经存在，请删除了左侧已存在文件再重新上传', {
	          time: 20000, //20s后自动关闭
	          btn: ['明白了']
	        });
	      this.error(index, upload);
	      
	    }
	    ,error: function(index, upload){
	      var tr = demoListView.find('tr#upload-'+ index)
	      ,tds = tr.children();
	      tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
	      tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
	      layer.close();
	    }
	  });
	});



	
</script>
</body>
</html>