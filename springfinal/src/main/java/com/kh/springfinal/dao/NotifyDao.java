package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kh.springfinal.dto.NotifyDto;
import com.kh.springfinal.vo.NotifyVO;

public interface NotifyDao {

	int sequence();
	void insert(NotifyDto notifyDto);
	List<NotifyDto> list(String notifyReceiver);
//	List<NotifyVO> notifyListWithNames(@Param("notifyReceiver") String notifyReceiver);
}
