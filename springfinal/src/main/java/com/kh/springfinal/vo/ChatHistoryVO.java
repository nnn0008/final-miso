package com.kh.springfinal.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ChatHistoryVO {


	private int chatNo;
	private int chatRoomNo;
	private String chatSender;
	private String chatReceiver;
	private String chatContent;
	private int attachNo;
	private LocalDateTime chatTime;
	
	private int clubMemberNo;
	private int clubNo;
	private String clubMemberRank;
	private LocalDateTime JoinDate;
	
	
}
