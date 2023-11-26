package com.kh.springfinal.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubMemberVO {
	
	private int clubMemberNo;
	private String memberId;
	private String memberName;
	private String clubMemberRank;
	private String joinMessage;
	private Date joinDate;
	private String joinDateString;
	private int attachNo;
	
	//리스트를 위한 항목
	private boolean masterRank;

}
