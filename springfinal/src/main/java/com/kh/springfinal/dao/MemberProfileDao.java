package com.kh.springfinal.dao;

import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.MemberProfileDto;

public interface MemberProfileDao {
	void profileUpload(MemberProfileDto profileDto);
	AttachDto profileFindOne(String memberId);
	boolean profileDelete(String memberId, int attachNo);
}
