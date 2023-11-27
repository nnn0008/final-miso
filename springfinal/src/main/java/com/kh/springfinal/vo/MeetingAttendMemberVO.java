package com.kh.springfinal.vo;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MeetingAttendMemberVO {
	
	private int attachNo;
	private int meetingNo;
	private int clubMemberNo;
	private String clubMemberRank;
	private String clubMemberId;

}
