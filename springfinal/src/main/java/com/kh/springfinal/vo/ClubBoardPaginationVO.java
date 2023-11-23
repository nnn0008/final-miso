package com.kh.springfinal.vo;

import lombok.Data;

@Data
public class ClubBoardPaginationVO {
	Integer begin;
	Integer end; 
	int clubNo; 
	String keyword;
	int page;
}
