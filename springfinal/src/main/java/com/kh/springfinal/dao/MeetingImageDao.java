package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MeetingImageDto;

public interface MeetingImageDao {
	void insert(int attachNo,int meetingNo);
	boolean delete(int meetingNo);
	MeetingImageDto selectOne(int meetingNo);
	List<MeetingImageDto> selectList();
}
