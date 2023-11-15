package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class KakaoPayRegularRequestRequestVO {
	private String cid; //가맹점 코드
	private String sid; // 정기결제 키
	private String partner_order_id; //가맹점 주분번호
	private String partner_user_id; // 가맹점 회원아이디
	private String item_name;//상품 이름
	private int quantity; //상품 수량
	private int total_amount; //상품 총액
	private int tax_free_amount; //상품 비과세 금액
}
