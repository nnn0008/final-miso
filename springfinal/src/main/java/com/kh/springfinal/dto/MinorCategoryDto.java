package com.kh.springfinal.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class MinorCategoryDto {
	
	
	private int minorCategoryNo;
	private	int MajorCategoryNo;
	private	String minorCategoryName;

}
