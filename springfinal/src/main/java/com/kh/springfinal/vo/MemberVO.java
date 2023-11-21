package com.kh.springfinal.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MemberVO {
	private String memberId, memberPw;
	private String memberName;
	private String memberEmail;
	private String memberContant;
	private String memberAddr;
	private String memberBirth;
	private String memberLevel;
	private Date memberJoin;
	private Date memberLogin;
	private String profileImageUrl;
}
