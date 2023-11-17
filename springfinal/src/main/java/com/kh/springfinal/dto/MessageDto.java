package com.kh.springfinal.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MessageDto {

	public enum MessageType{
		join, message, dm, leave, file, chatReset
	}
	
	private MessageType messageType;
	private int chatRoomNo;
	private String chatSender;
	private String chatReceiver;
	private String chatContent;
	private String memberName;
	
	private String fileName;
	private long fileSize;
	private String fileType;
}
