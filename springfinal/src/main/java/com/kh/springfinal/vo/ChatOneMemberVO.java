package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ChatOneMemberVO {
	
	private int chatRoomNo;
	private String chatSender;
	private String chatReceiver;
	private int senderAttachNo;
	private int receiverAttachNo;

}
