package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.MeetingDto;

public interface MeetingDao {
	int sequence();
	void insert(MeetingDto meetingDto);
	boolean update(MeetingDto meetingDto);
	boolean delete(int meetingNo);
	MeetingDto selectOne(int meetingNo);
	List<MeetingDto> selectList(int clubNo);
	AttachDto findImage(int meetingNo);
	
}