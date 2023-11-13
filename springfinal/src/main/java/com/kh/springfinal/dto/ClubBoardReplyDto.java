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
	private int clubBoardReplyParent;
	private int clubBoardReplyDepth;
	private String clubBoardReplyWriter;
	private int clubMemberNo;
	private int clubBoardNo;
}
