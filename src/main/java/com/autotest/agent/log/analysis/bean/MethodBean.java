package com.autotest.agent.log.analysis.bean;

import java.util.Date;

import com.alibaba.fastjson.annotation.JSONField;

public class MethodBean {
	/*编号*/
	private String bh;
	/*日志开始时间  */
	private Date startTime;
	
	private String start;
	/*日志结束时间  */
	private Date endTime;
	
	private String end;
	/*类名  */
	@JSONField(name="class")
	private String className;
	/*方法名  */
	@JSONField(name="name")
	private String methodName;
	/*次数  */
	@JSONField(name="counter")
	private Integer counter;
	/*总时间 */
	@JSONField(name="time")
	private Integer time;
	/*平均时间*/
	@JSONField(name="avg")
	private Integer avg;
	/*一个类里面所有的方法*/
	@JSONField(name="methods")
	private String methods;
	/*版本信息 */
	private String version;
	/*日期*/
	private String day;
	/*起止日期*/
	private String startAndEnd;
	public String getBh() {
		return bh;
	}
	public void setBh(String bh) {
		this.bh = bh;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	public String getMethodName() {
		return methodName;
	}
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}
	public Integer getCounter() {
		return counter;
	}
	public void setCounter(Integer counter) {
		this.counter = counter;
	}
	public Integer getTime() {
		return time;
	}
	public void setTime(Integer time) {
		this.time = time;
	}
	public Integer getAvg() {
		return avg;
	}
	public void setAvg(Integer avg) {
		this.avg = avg;
	}
	public String getMethods() {
		return methods;
	}
	public void setMethods(String methods) {
		this.methods = methods;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getStartAndEnd() {
		return startAndEnd;
	}
	public void setStartAndEnd(String startAndEnd) {
		this.startAndEnd = startAndEnd;
	}
	
}
