package com.kh.springfinal.dto;

import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MessageDto {

	public enum MessageType{
		join, message, dm, leave, file, delete
	}
	
	private MessageType messageType;
	private int chatRoomNo;
	private String chatSender;
	private String chatReceiver;
	private String chatContent;
	private String memberName;
	private int chatNo;
	private String chatBlind;
	
	private String fileName;
	private long fileSize;
	private String fileType;

}
