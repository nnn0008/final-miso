package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberDto {
	private String memberId, memberPw;
	private String memberName;
	private String memberEmail;
	private String memberContent;
	private String memberAddr;
	private String memberBirth;
	private String memberLevel;
	private Date memberJoin;
	private Date memberLogin;
}
