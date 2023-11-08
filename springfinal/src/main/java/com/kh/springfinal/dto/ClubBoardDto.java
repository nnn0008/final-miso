package com.kh.springfinal.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubBoardDto {
	private int clubBoardNo;
	private String clubBoardTitle;
	private String clubBoardContent;
	private String clubBoardCategory;
	private String clubBoardFix;
	private String clubBoardDate;
	private int clubMemberNo;
	private int clubNo;
}
