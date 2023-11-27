package com.kh.springfinal.dto;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
	@DateTimeFormat(pattern = "yyyyMMddHHmm") String clubBoardDate;
	private int clubBoardLikecount;
	private int clubBoardReplyCount;
	private String clubBoardName;
	private Integer attachNoCbi;
	private Integer attachNoCbi2;
	private Integer attachNoCbi3;
}
