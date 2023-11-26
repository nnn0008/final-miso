package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.dto.MemberEditDto;

public interface MemberDao {
	void join(MemberDto memberDto);
	public MemberDto loginId(String memberId);
	MemberDto selectOne(String memberId, String memberPw);
	List<MemberDto> memberIdListByEmail(String memberName, String memberEmail);
	boolean changePw(String memberId, String memberPw);
	List<MemberDto> selectListOld();
	List<MemberDto> selectListNew();
	boolean memberEdit(MemberEditDto memberDto);
	boolean updateLevel(String memberId);//회원등급변경
	boolean updateDownLevel(String memberId);//회원등급내리기
	
	boolean schedulerMember(String memberId);
	
	MemberDto memberFindId(String memberId);//아이디 찾을려고 만듬
}
