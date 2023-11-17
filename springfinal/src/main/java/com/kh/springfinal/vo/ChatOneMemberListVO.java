package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ChatOneMemberListVO {
	
	private String chatSender;
	private String senderName;
	private String senderLevel;
	private String chatReceiver;
	private String receiverName;
	private String receiverLevel;
	private int chatRoomNo;

}
