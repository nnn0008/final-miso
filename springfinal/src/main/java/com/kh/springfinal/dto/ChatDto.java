package com.kh.springfinal.dto;

import java.sql.Date;
import java.time.LocalDateTime;

import com.kh.springfinal.vo.ClientVO;

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
	private int attachNo;
	
	private LocalDateTime chatTime;
	
	 public LocalDateTime getChatTime() {
	        return chatTime;
	    }

	    public void setChatTime(LocalDateTime chatTime) {
	        this.chatTime = chatTime;
	    }
}
