package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubBoardAllDto {
	private String memberId;
	private int attachNoMp;
	private String clubMemberRank;
	private int clubNo;
	private String clubBoardTitle;
	private String clubBoardContent;
	private String clubBoardCategory;
	private Date clubBoardDate;
	private int clubBoardLikecount;
	private String clubBoardName;
	private int attachNoCbi;
}
