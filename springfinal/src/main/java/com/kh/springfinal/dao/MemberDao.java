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
	boolean memberEditSelf(MemberDto memberDto);
	boolean deleteMember(String memberId);
}
