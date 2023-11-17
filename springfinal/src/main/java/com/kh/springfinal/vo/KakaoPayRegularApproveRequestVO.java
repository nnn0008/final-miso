package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class KakaoPayRegularApproveRequestVO {
	private String tid,sid; //가맹점 코드
	private String partnerOrderId,partnerUserId; //가맹점 주분번호
	private int quantity,itemPrice,taxFreeAmount;
	private String pgToken;
}
