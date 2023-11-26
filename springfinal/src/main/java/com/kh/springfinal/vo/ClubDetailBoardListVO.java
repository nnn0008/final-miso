package com.kh.springfinal.vo;

import java.util.Date;
import java.util.List;

import com.kh.springfinal.dto.MeetingDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ClubDetailBoardListVO {
	
	private int attachNo;
	private int clubBoardNo;
	private int clubNo;
	private String clubBoardTitle;
	private String clubBoardContent;
	private String clubBoardDate;
	private String clubBoardCategory;
	private String memberId;
	private String memberName;

}
