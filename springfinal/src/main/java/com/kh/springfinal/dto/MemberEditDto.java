package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberEditDto {
	private String memberId;
	private String memberName;
	private String memberEmail;
	private String memberContact;
	private int memberAddr;
	private String memberBirth;
}
