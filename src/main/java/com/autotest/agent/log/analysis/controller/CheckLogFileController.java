package com.autotest.agent.log.analysis.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.autotest.agent.log.analysis.bean.LogFileBean;
import com.autotest.agent.log.analysis.dao.LogFileDao;
import com.autotest.agent.log.analysis.service.LogFileService;


@Controller
@RequestMapping("/logFileAnalysis")
public class CheckLogFileController {
	
	@Autowired
	private LogFileDao logFileDao;
	@Autowired
	private LogFileService logFileService;
	
	
	/**
	 * 上传文件并存入数据库
	 * @param file
	 * @return
	 * @throws ParseException
	 * @throws IOException 
	 */
	@RequestMapping("/upload")
	@ResponseBody
	public  JSONObject uploadAndAnalysis( MultipartFile [] file ) throws ParseException, IOException{
		JSONObject json = new JSONObject();
		
		Boolean flag = logFileService.saveFileInfoToDatabase(file, json);
		if(flag){
			 json.put("code", 0);
		}else{
			 json.put("code", 1);
		}
        return json;
	}

	
	@RequestMapping("deleteFiles")
	@ResponseBody
	public Object deleteFiles(String files){
		JSONObject json = new JSONObject();
		try {
			logFileDao.deleteFiles(files);
			json.put("code", 0);
		} catch (Exception e) {
			json.put("code", 1);
		}
		return json;
	}
	
	@RequestMapping("getDays")
	@ResponseBody
	public String getDays(){
		List<String> list = logFileDao.findFileList();
		return JSONObject.toJSONString(list);
	}
	
	@RequestMapping("toResultPage")
	public String toResultPage(Model model ,String methodName,String className){
		List<LogFileBean> findOne = logFileService.getDataInfo(methodName, className);
		model.addAttribute("data",JSONObject.toJSONString(findOne));
		model.addAttribute("methodName",methodName);
		model.addAttribute("className",className);
		return "jsp/result";
	}
	
	@RequestMapping("toClassResultPage")
	public String toClassResultPage(Model model ,String className){
		List<LogFileBean> findOne = logFileService.getDataInfo(null, className);
		model.addAttribute("data",JSONObject.toJSONString(findOne));
		model.addAttribute("className",className);
		return "jsp/classresult";
	}
	
	@RequestMapping("getTimes")
	@ResponseBody
	public String getTimes(String files){
		List<String> list = logFileDao.findTimeList(files);
		return JSONObject.toJSONString(list);
	}
	
	@RequestMapping("getClassName")
	@ResponseBody
	public String getClassName(String files,String startAndEndTime){
		List<String> list = logFileDao.findClassNames(files, startAndEndTime);
		return JSONObject.toJSONString(list);
	}
	
	/**
	 * 查看echart图形的每条详细信息
	 * @param methodName
	 * @param className
	 * @param value
	 * @param type
	 * @param days
	 * @param startAndEndTime
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("getDetail")
	@ResponseBody
	public String getDetail(String methodName,String className,Integer value ,Integer type,String days,String startAndEndTime) throws ParseException{
		LogFileBean logFileBean = new LogFileBean();
		logFileBean.setMethodName(methodName);
		logFileBean.setClassName(className);
		logFileBean.setDay(days);
		logFileBean.setStartAndEnd(startAndEndTime);
		if(type == 1){
			//value是总时长
			logFileBean.setTime(value);
		}else if(type == 2){
			//value是总数
			logFileBean.setCounter(value);
		}else if(type ==3){
			//value是平均值
			logFileBean.setAvg(value);
		}else{
			//do nothing
		}
		Example<LogFileBean> logFileExample = Example.of(logFileBean );
		//value 是总时长
		LogFileBean findOne = logFileDao.findOne(logFileExample);
		return JSONObject.toJSONString(findOne);
	}
	

	/**
	 * 根据日期查找当日每个时间段的数据统计折线图
	 * @param days
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("getEchartResult")
	@ResponseBody
	public String getEchartResult(String files){
		Map<String, Object> result = new HashMap<>();
		//拿到时间段的列表为x坐标轴
		List<String> timeList = logFileDao.findTimeCutList(files);
		List<String> timePointList = new ArrayList<>();
		List<String> y1Data = new ArrayList<>();
		List<String> y2Data = new ArrayList<>();
		List<String> y3Data = new ArrayList<>();
		
		for(String time : timeList){
			String timePoint = time.substring(11,13);
			Integer count = logFileDao.selectCountInfo(files, time.substring(0, 13));
			y1Data.add(count.toString());
			Integer times = logFileDao.selectTimeInfo(files, time.substring(0, 13));
			y2Data.add(times.toString());
			if(count!=0){
				Integer avg = times/count;
				y3Data.add(avg.toString());
			}else{
				y3Data.add("-");
			}
			timePointList.add(timePoint);
		}
		//x坐标的数据
		result.put("xData", JSONObject.toJSONString(timePointList));
		result.put("y1Data", JSONObject.toJSONString(y1Data));
		result.put("y2Data", JSONObject.toJSONString(y2Data));
		result.put("y3Data", JSONObject.toJSONString(y3Data));
		return JSONObject.toJSONString(result);
	}

	/**
	 * @param days 日期
	 * @param startAndEndTime 时间段
	 * @param page 页数
	 * @param type 排序数据的类型
	 * @param order 顺序
	 * @param className
	 * @param methodName
	 * @param searchType 当搜索类型为0的时候是方法名和类名的精确搜索
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("getDetailTableResult")
	@ResponseBody
	public String getDetailTableResult(Integer page,String type,String order,String className,String methodName) throws ParseException{
		Map<String, Object> result = new HashMap<>();
		
		
		LogFileBean logFileBean = new LogFileBean();
		if(StringUtils.isNotEmpty(methodName)){
			logFileBean.setMethodName(methodName);
		}
		if(StringUtils.isNotEmpty(className)){
			logFileBean.setClassName(className);
		}
		Example<LogFileBean> logFileExample = Example.of(logFileBean);
		
		
		String sortString="time";
		Pageable pageable = logFileService.getPageInfo(page, type, order, result, sortString);
		Page<LogFileBean> pageInfo = logFileDao.findAll(logFileExample, pageable);
		result.put("code", 1);
		result.put("count", pageInfo.getTotalElements());
		result.put("data", JSON.toJSON(pageInfo.getContent()));
		return JSONObject.toJSONString(result);
	}
	
	/**
	 * @param days 日期
	 * @param startAndEndTime 时间段
	 * @param page 页数
	 * @param type 排序数据的类型
	 * @param order 顺序
	 * @param className
	 * @param methodName
	 * @param searchType 当搜索类型为0的时候是方法名和类名的精确搜索
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping("getTableResult")
	@ResponseBody
	public String getTableResult(String files,String startAndEndTime,Integer page,String type,String order,String className,String methodName) throws ParseException{
		Map<String, Object> result = new HashMap<>();
		
		LogFileBean logFileBean = new LogFileBean();
		logFileBean.setFileName(files);
		
		if(!startAndEndTime.equals("null")){
			logFileBean.setStartAndEnd(startAndEndTime);
		}
		if(StringUtils.isNotEmpty(methodName)){
			logFileBean.setMethodName(methodName);
		}
		if(StringUtils.isNotEmpty(className)){
			logFileBean.setClassName(className);
		}
		ExampleMatcher matcher = ExampleMatcher.matching().withMatcher("className", ExampleMatcher.GenericPropertyMatchers.contains());
		Example<LogFileBean> logFileExample = Example.of(logFileBean ,matcher);
		
		
		String sortString="avg";
		Pageable pageable = logFileService.getPageInfo(page, type, order, result, sortString);
		Page<LogFileBean> pageInfo = logFileDao.findAll(logFileExample, pageable);
		result.put("code", 1);
		result.put("count", pageInfo.getTotalElements());
		result.put("data", JSON.toJSON(pageInfo.getContent()));
		return JSONObject.toJSONString(result);
	}

	
	
}
