package com.autotest.agent.log.analysis.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.autotest.agent.log.analysis.bean.LogFileBean;
import com.autotest.agent.log.analysis.bean.MethodBean;
import com.autotest.agent.log.analysis.dao.LogFileDao;
import com.autotest.agent.log.analysis.service.LogFileService;

@Service
public class LogFileServiceImpl implements LogFileService{

	private static Logger log = Logger.getLogger(LogFileServiceImpl.class);
	
	private static final String PATTERNS = "yyyy-MM-dd hh:mm:ss";

	@Autowired
	private LogFileDao logFileDao;
	
	@Override
	public Boolean saveFileInfoToDatabase(MultipartFile[] file, JSONObject json) throws IOException, ParseException {
		
		if(file[0].getSize() == 0){
			json.put("code", 1);
	        json.put("message", "上传的文档不存在!");
		}
		String fileName = file[0].getOriginalFilename();
		
		LogFileBean logFileBean = new LogFileBean();
		logFileBean.setFileName(fileName);
		Example<LogFileBean> example = Example.of(logFileBean);
		
		if(!CollectionUtils.isEmpty(logFileDao.findAll(example))){
			log.info("此文档已存在，文档名称为："+fileName);
				return false;
			}
		File realFile = null;
		
		realFile = File.createTempFile("tmp", null);
		file[0].transferTo(realFile);
		
		String agentLogStr = FileUtils.readFileToString(realFile,"UTF-8");
		List<MethodBean> agentLogArray = JSONObject.parseArray(agentLogStr,MethodBean.class);
		for(MethodBean methodBean : agentLogArray){
			logFileBean = new LogFileBean();
			List<MethodBean> methodList = JSONObject.parseArray(methodBean.getMethods(),MethodBean.class);
			for(MethodBean bean : methodList){
				logFileBean.setMethodName(bean.getMethodName());
				logFileBean.setCounter(bean.getCounter());
				logFileBean.setTime(bean.getTime());
				if(bean.getAvg()!=null){
					logFileBean.setAvg(bean.getAvg());
				}else{
					logFileBean.setAvg(bean.getTime()/bean.getCounter());
				}
			}
			logFileBean.setClassName(methodBean.getClassName());
			logFileBean.setDay(methodBean.getStart().substring(0, 10));
			logFileBean.setStartAndEnd(methodBean.getStart()+" - "+methodBean.getEnd());
			logFileBean.setStartTime(DateUtils.parseDate(methodBean.getStart(), PATTERNS));
			logFileBean.setTimeCut(methodBean.getStart().substring(0, 13));
			logFileBean.setEndTime(DateUtils.parseDate(methodBean.getEnd(), PATTERNS));
			Example<LogFileBean> logFileExample = Example.of(logFileBean  );
			if(!CollectionUtils.isEmpty(logFileDao.findAll(logFileExample))){
				log.info("此数据已存在，数据信息为："+JSONObject.toJSONString(logFileBean));
				return false;
			}
			logFileBean.setBh(UUID.randomUUID().toString().replace("-", ""));
			logFileBean.setFileName(fileName);
			logFileDao.saveAndFlush(logFileBean);	
		}
		
		//退出时删除此临时文件
		realFile.deleteOnExit();
	
		return true;
	}

	@Override
	public List<LogFileBean> getDataInfo(String methodName, String className) {

		LogFileBean logFileBean = new LogFileBean();
		
		logFileBean.setClassName(className);
		if(StringUtils.isNotEmpty(methodName)){
			logFileBean.setMethodName(methodName);
		}
		Example<LogFileBean> logFileExample = Example.of(logFileBean  );
		//value 是总时长
		String sortString="time";
		Sort sort = new Sort(Direction.DESC, sortString);
		return logFileDao.findAll(logFileExample,sort);
	
	}

	@Override
	public Pageable getPageInfo(Integer page, String type, String order, Map<String, Object> result,
			String sortString) {

		if(type != null){
			sortString = type;
		}
		Sort sort = new Sort(Direction.DESC, sortString);
		if (order != null && order.contains("asc")) {
			sort = new Sort( Direction.ASC ,sortString);
		}
		Pageable pageable = null;
		if(page !=null&&page>1){
			pageable = new PageRequest(page-1, 100,sort);
			result.put("pages", page);
		}else{
			pageable = new PageRequest(0, 100,sort);
			result.put("pages", 1);
		}
		return pageable;
	
	}

}
