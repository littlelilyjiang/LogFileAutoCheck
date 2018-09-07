package com.autotest.agent.log.analysis.service;

import java.io.IOException;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.autotest.agent.log.analysis.bean.LogFileBean;

public interface LogFileService {

	/**
	 * 解析json数据到数据库中
	 * @param file 文件
	 * @param json 返回的json对象
	 * @return 
	 * @throws IOException
	 * @throws ParseException
	 */
	Boolean saveFileInfoToDatabase(MultipartFile[] file, JSONObject json) throws IOException, ParseException;

	List<LogFileBean> getDataInfo(String methodName, String className);

	/**
	 * 设置分页的相关信息
	 * @param page 页数
	 * @param type 排序的数据类型
	 * @param order 排序的顺序    desc asc
	 * @param result 结果
	 * @param sortString 
	 * @return
	 */
	Pageable getPageInfo(Integer page, String type, String order, Map<String, Object> result, String sortString);

}
