package com.kh.springfinal.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubDto {
	
	private int clubNo;
	private String clubOwner;
	private	int clubCategory;
	private int zipCodeNo;
	private int chatRoomNo;
	private String clubName;
	private String clubExplain;
	private int clubPersonnel;
	private String clubPremium;
	

}