package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dto.NotifyDto;
import com.kh.springfinal.vo.NotifyVO;

public interface NotifyDao {

	int sequence();
	void insert(NotifyDto notifyDto);
	List<NotifyDto> list(String notifyReceiver);
//	List<NotifyVO> notifyListWithNames(@Param("notifyReceiver") String notifyReceiver);
	
	boolean delete(int notifyNo);
	
	 boolean notifyEnabledOff(String notifyReceiver);
	 boolean notifyEnabledOn(String notifyReceiver);
	 boolean isNotificationEnabled(String notifyReceiver);
}
