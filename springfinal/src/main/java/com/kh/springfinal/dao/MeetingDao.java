package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.MeetingDto;
import com.kh.springfinal.dto.MemberProfileDto;
import com.kh.springfinal.vo.PaginationVO;

public interface MeetingDao {
	int sequence();
	void insert(MeetingDto meetingDto);
	boolean update(MeetingDto meetingDto);
	boolean delete(int meetingNo);
	MeetingDto selectOne(int meetingNo);
	List<MeetingDto> selectList(int clubNo);
	List<MeetingDto> meetingListByPage(PaginationVO vo);
	AttachDto findImage(int meetingNo);
	int count(PaginationVO vo);
	int count(int clubNO);//전체 개수 클럽 디테일로 보내서 jsp 전체에서 쓰기 위해서 만듬
}