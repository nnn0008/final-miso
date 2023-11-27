package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubListVO {
	
	private int clubNo;
	private String clubName;
	private String clubExplain;
	private String sido;
	private String sigungu;
	private String majorCategoryName;
	private String minorCategoryName;
	private int memberCount;
	private int attachNo;
	private boolean likeClub;

}
