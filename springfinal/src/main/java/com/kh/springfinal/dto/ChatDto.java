package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ChatDto {
	
	private int chatNo;
	private int chatRoomNo;
	private String chatSender;
	private String chatReceiver;
	private String chatContent;
	private Date chatDate;
	private int attachNo;
}
