package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ZipCodeSearchVO {
	private int zipCodeNo;
	private String sido;
	private String sigungu;
	private String eupmyun;
	private String doro;
	private String buildName;
	private String dongName;
	private String hdongName;
	private String searchVal;
}
