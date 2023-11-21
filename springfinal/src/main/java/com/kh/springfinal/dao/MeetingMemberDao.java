package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MeetingMemberDto;

public interface MeetingMemberDao {
	void insert(MeetingMemberDto meetingMemberDto);
	boolean delete(int meetingNo);
	MeetingMemberDto selectOne(int meetingNo);
	List<MeetingMemberDto> selectList();
	boolean didAttend(int meetingNo,int clubMemberNo);
	boolean deleteAttend(int meetingNo,int clubMemberNo);
}
