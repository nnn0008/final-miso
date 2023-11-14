package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubMemberVO {
	
	private String memberId;
	private String memberName;
	private String clubMemberRank;
	private String joinMessage;

}
