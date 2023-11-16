package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class KakaoPayRegularRequestRequestVO {
	private String cid; //가맹점 코드
	private String sid; // 정기결제 키
	private String partnerOrderId; //가맹점 주분번호
	private String partnerUserId; // 가맹점 회원아이디
	private String itemName;//상품 이름
	private int quantity; //상품 수량
	private int totalAmount; //상품 총액
	private int taxFreeAmount; //상품 비과세 금액
}
