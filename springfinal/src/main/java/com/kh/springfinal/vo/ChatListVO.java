package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ChatListVO {

	private int chatRoomNo;
	private int clubNo;
	private String clubName;
	private String clubExplain;
}
