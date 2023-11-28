package com.kh.springfinal.vo;

import com.kh.springfinal.dto.ClubMemberDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubImageVO {
	
	private int clubNo;
	private String clubOwner;
	private	int clubCategory;
	private int zipCodeNo;
	private int chatRoomNo;
	private String clubName;
	private String clubExplain;
	private int clubPersonnel;
	private String clubPremium;
	private String clubDate;
	private int attachNo;
	private int clubMaxPersonnel;
	private int plusDay;

}
