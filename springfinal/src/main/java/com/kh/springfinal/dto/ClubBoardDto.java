package com.kh.springfinal.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubBoardDto {
	private int clubBoardNo;
	private String clubBoardName;
	private String clubBoardTitle;
	private String clubBoardContent;
	private String clubBoardCategory;
	private String clubBoardDate;
	private String clubBoardLikecount;
	private int clubBoardReplyCount;
	private int clubMemberNo;
	private int clubNo;

}
