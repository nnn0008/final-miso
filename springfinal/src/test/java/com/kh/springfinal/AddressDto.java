package com.kh.springfinal;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class AddressDto {
	private String zipCodeNo;
	private String sido;
	private String sigungu;
	private String eupmyun;
	private String hdongName;
}