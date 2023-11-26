package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.vo.ClubMemberVO;
import com.kh.springfinal.vo.HomeForClubVO;
import com.kh.springfinal.vo.MeetingAttendMemberVO;

public interface ClubMemberDao {
	
	ClubMemberDto selectOne(int clubMemberNo);
	
	void insert(ClubMemberDto clubMemberDto);
	
	int sequence();
	
	boolean existMember(int clubNo,String memberId);
	
	List<ClubMemberDto> memberList(int clubNo);
	
	List<ClubMemberVO> memberInfo(int clubNo);
	
	int memberCount(int clubNo);
	
	boolean editPossible(int clubNo,String clubMemberId);
	
	Integer findClubMemberNo(int clubNo,String memberId);
	
	boolean isManeger(int clubMemberNo);

//	String attendMemberId(int clubMemberNo);
	
	List<MeetingAttendMemberVO> meetingAttendList(int meetingNo);
	
	List<ClubDto> mypageClubList(String memberId);
	boolean upgradeRank(int clubMemberNo);
	
	List<HomeForClubVO> selectListByMemberId(String memberId);
}
