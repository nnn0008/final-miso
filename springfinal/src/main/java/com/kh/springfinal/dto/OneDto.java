package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class OneDto {
	private int oneNo;
	private String oneMember;
	private String oneLevel;
	private String oneTitle,oneContent;
	private Date oneDate;
	private int oneStatus;
	private String oneCategory;
	private int oneGroup,oneDepth;
	private Integer oneParent;
	private String type,keyword;
	

}
