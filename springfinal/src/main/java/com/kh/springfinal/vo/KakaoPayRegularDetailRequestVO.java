package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class KakaoPayRegularDetailRequestVO {
	//cid는 넣으면 안됨
	private String tid,sid;//정기 결제 고유번호. 20자
	private int cancelAmount;

}
