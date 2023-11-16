package com.kh.springfinal.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class KakaoPayRegularApproveResponseVO {
	private String aid;//요청 고유 번호
	private String tid;//결제 고유 번호
	private String cid;//가맹점 코드
	private String sid;//정기결제용 아이디
	private String partnerOrderId;//가맹점 주문번호
	private String partnerUserId;//가맹점 회원번호
	private String paymentMethodType;//결제 수단(CARD/MONEY)
	private KakaoPayAmountVO amount;//결제 금액 정보
	private KakaoPayCardInfoVO cardInfo;//결제 카드 정보
	private String itemName;//상품 이름
	private String itemCode;//상품 코드
	private int quantity;//상품 수량
	private Date createdAt;//결제 준비 요청 시각
	private Date approvedAt;//결제 승인 시각
	private String payload;//결제 요청 시 전달된 요청 데이터
}
