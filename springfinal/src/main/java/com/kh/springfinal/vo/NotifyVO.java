package com.kh.springfinal.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder

public class NotifyVO {
	private int notifyNo;
	private String notifySender, notifyReceiver;
	private int notifyClubBoardNo;
	private String notifyClubBoardTitle;
	private Date notifyDate;
	private String notifyType;
	private String clubName;
	private String memberName;
	
}
