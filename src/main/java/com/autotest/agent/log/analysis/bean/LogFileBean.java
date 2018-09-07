package com.autotest.agent.log.analysis.bean;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.alibaba.fastjson.annotation.JSONField;

@Entity
public class LogFileBean {
@Id
@GeneratedValue(strategy=GenerationType.AUTO)

	/*编号*/
	private String bh;
	/*日志开始时间  */
	private Date startTime;
	/*日志结束时间  */
	private Date endTime;
	/*类名  */
	@JSONField(name="class")
	private String className;
	/*方法名  */
	private String methodName;
	/*次数  */
	private Integer counter;
	/*总时间 */
	private Integer time;
	/*平均时间*/
	private Integer avg;

	/*版本信息 */
	private String version;
	/*日期*/
	private String day;
	/*起止日期*/
	private String startAndEnd;
	
	/*所属文件名字*/
	private String fileName;
	/*所属时间段*/
	private String timeCut;
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
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
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
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getTimeCut() {
		return timeCut;
	}
	public void setTimeCut(String timeCut) {
		this.timeCut = timeCut;
	}

}
