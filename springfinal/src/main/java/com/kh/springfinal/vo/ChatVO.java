package com.kh.springfinal.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ChatVO {
	
	private int chatNo;
	private int clubNo;
	private int chatRoomNo;
	private String clubMemberId;
	private String chatReceiver;
	private String chatContent;
	private int attachNo;
	private String memberName;
	
	private LocalDateTime chatTime;
}
