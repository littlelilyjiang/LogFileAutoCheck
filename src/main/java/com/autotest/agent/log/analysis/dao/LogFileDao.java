package com.autotest.agent.log.analysis.dao;

import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.autotest.agent.log.analysis.bean.LogFileBean;

@Transactional
public interface LogFileDao extends JpaRepository<LogFileBean,Long>{

	 /**
	  * 判断这条数据是否已经存在于数据库中
	 * @param cClassName
	 * @param cMethodName
	 * @param dStartTime
	 * @param dEndTime
	 * @return
	 */
	@Query("select t from  LogFileBean t where t.className  = ?1 and t.methodName  = ?2 and t.startTime = ?3 and t.endTime =?4")
	List<LogFileBean> findByClassName(@Param("className")String cClassName,@Param("methodName")String cMethodName,@Param("startTime") Date dStartTime,@Param("endTime") Date dEndTime);

	 /**
	  * 得到这个日期的所有时间列表
	 * @param cDay
	 * @return
	 */
	@Query("select startAndEnd from LogFileBean t where t.fileName = ?1 group by startAndEnd order by startAndEnd")
	 List<String> findTimeList(@Param("files")String files);
	
	 /**
	  * 得到这个日期的所有时间点列表
	 * @param cDay
	 * @return
	 */
	@Query("select timeCut from LogFileBean t where t.fileName = ?1 group by timeCut order by timeCut")
	 List<String> findTimeCutList(@Param("files")String files);
	 
	 /**
	  * 得到所有的文件列表
	 * @return
	 */
	@Query("SELECT fileName FROM LogFileBean group by fileName")
	 List<String> findFileList();
	
	 /**
	  * 得到所有的文件列表
	 * @return 
	 * @return
	 */
	@Modifying
	@Query("delete from  LogFileBean t where t.fileName  = ?1")
	 void deleteFiles(String files);
	 
	 /**
	  * 查找这个时间段内的所有类名
	 * @param cDay
	 * @param cStartAndEnd
	 * @return
	 */
	@Query("select className from  LogFileBean t where t.fileName  = ?1 and t.startAndEnd  = ?2 ")
	 List<String> findClassNames(String files,String cStartAndEnd);
	

	/**
	 * 按照时间段查询总数信息
	 * @param cDay
	 * @param cStartAndEnd
	 * @return
	 */
	@Query("select sum(counter) from  LogFileBean t where t.fileName  = ?1  and t.timeCut  = ?2 ")
	 Integer selectCountInfo(String files,String timeCut);
	
	/**
	 * 按照时间段查询次数信息
	 * @param cDay
	 * @param cStartAndEnd
	 * @return
	 */
	@Query("select sum(time ) from  LogFileBean t where t.fileName  = ?1  and t.timeCut  = ?2 ")
	 Integer selectTimeInfo(String files,String timeCut);

}

