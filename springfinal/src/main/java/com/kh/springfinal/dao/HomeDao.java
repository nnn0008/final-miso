package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MeetingMemberDto;
import com.kh.springfinal.vo.HomeForMeetingMemberVO;
import com.kh.springfinal.vo.HomeForMeetingVO;
import com.kh.springfinal.vo.PaginationVO;

public interface HomeDao {
	List<HomeForMeetingVO> selectList(PaginationVO vo, String memberId);
	List<HomeForMeetingMemberVO> selectList();
	int meetingCount(PaginationVO vo, String memberId);
	MeetingMemberDto selectOne(int clubMemberNo, int meetingNo);
}
