package com.kh.springfinal.vo;

import java.util.Date;

import com.kh.springfinal.dto.MeetingDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MeetingVO {
	private int meetingNo;
	private String meetingName;
	private Date meetingDate;
	private String meetingLocation;
	private int meetingPrice;
	private int meetingNumber;
	private String meetingFix;
	private int clubNo;
	private String dateString;
	private int dday;
	private int chatRoomNo;
	
	private int attachNo;
	private String chatContent;
	private String chatBlind;
}
