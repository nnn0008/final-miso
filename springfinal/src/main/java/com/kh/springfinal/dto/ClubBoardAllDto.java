package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubBoardAllDto {
	private int clubBoardNo;
	private String clubMemberId;
	private Integer attachNoMp;
	private String clubMemberRank;
	private int clubNo;
	private String clubBoardTitle;
	private String clubBoardContent;
	private String clubBoardCategory;
	private Date clubBoardDate;
	private int clubBoardLikecount;
	private int clubBoardReplyCount;
	private String clubBoardName;
	private Integer attachNoCbi;
}
