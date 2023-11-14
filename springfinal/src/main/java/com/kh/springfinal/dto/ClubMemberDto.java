package com.kh.springfinal.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubMemberDto {
	
	private int clubMemberNo;
	private String clubMemberId;
	private int clubNo;
	private String clubMemberRank;
	private String joinMessage;
	

}
