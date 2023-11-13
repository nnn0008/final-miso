package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class KakaoPayDetailRequestVO {
	//cid는 넣으면 안됨
	private String tid;
	private int cancelAmount;
}
