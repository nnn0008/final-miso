package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ChatMemberListVO {

	private String clubMemberId;
	private String memberName;
	private String clubMemberRank;
	private int chatRoomNo;
	private int clubNo;
	
}
