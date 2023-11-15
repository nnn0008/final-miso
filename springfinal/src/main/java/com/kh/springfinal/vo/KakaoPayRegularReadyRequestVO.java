package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class KakaoPayRegularReadyRequestVO {
	private String cid; //가맹점 ID
	private String partner_order_id; // 가맹점 주분번호
	private String partner_user_id; // 가맹점 회원 아이디
	private String item_name;//상품명
	private int quantity; //상품수량
	private int total_amount; //구매 금액
	private int tax_free_amount; //비과세 금액(0원으로 설정)
 	private String approval_url; // 성공시 URL
	private String cancel_url; // 취소시 URL
	private String fail_url; // 실패시URL
}
