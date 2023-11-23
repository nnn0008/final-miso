package com.kh.springfinal.dto;


import java.util.Date;
import java.util.List;

import com.kh.springfinal.vo.MeetingAttendMemberVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MeetingDto {
	private int meetingNo;
	private String meetingName;
	private Date meetingDate;
	private String meetingLocation;
	private int meetingPrice;
	private int meetingNumber;
	private String meetingFix;
	private int clubNo;
	private String dateString;
	private String date;
	private String time;
	private float dday;
	private int chatRoomNo;
	private int attachNo;
	private boolean isManager;
	private boolean didAttend;
	private int attendCount;
	private String memberId;
	private List<MeetingAttendMemberVO> attendMemberList;
	
}