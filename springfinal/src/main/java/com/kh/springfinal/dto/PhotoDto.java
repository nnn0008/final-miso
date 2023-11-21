package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class PhotoDto {
	private int photoNo;
	private Date PhotoDate;
	private int photoReadcount;
	private int photoLikecount;
	private int clubMemberNo;
	private int clubNo;
}
