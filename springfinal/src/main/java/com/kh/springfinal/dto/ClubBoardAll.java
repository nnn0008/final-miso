package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubBoardAll {
	private String memberName;
	private int mpAttachNo;
	private String clubMemberRank;
	private String clubBoardTitle;
	private String clubBoardContent;
	private String clubBoardCategory;
	private Date clubBoardDate;
	private String clubBoardFix;
	private int cbiAttachNo;
}
