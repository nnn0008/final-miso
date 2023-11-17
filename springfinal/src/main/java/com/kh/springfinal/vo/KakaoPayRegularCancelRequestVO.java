package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class KakaoPayRegularCancelRequestVO {
	private String tid,sid;//요청 고유 번호
	private int cancelAmount,cancelTaxFreeAmount;
}
