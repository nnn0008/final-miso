package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubBoardReplyDto {
	private int clubBoardReplyNo;
	private String clubBoardReplyContent;
	private Date clubBoardReplyDate;
	private int clubBoardReplyGroup;
	private Integer clubBoardReplyParent;
	private int clubBoardReplyDepth;
	private String clubBoardReplyWriter;
	private int clubMemberNo;
	private int clubBoardNo;
	
	//댓글 작성자 출력용 메소드
	public String getClubBoardReplyWriter() {
		if(clubBoardReplyWriter == null) return "탈퇴한 유저";
		else return clubBoardReplyWriter;
	}
}
