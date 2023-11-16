package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class KakaoPayRegularReadyRequestVO {
	private String cid; //가맹점 ID
	private String partnerOrderId; // 가맹점 주분번호
	private String partnerUserId; // 가맹점 회원 아이디
	private String itemName;//상품명
	private int itemPrice; //구매 금액
	private int quantity; //상품수량
	private int taxFreeAmount; //비과세 금액(0원으로 설정)
 	private String approvalUrl; // 성공시 URL
	private String cancelUrl; // 취소시 URL
	private String failUrl; // 실패시URL
}
