package com.kh.springfinal.vo;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@JsonIgnoreProperties(ignoreUnknown = true)
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class KakaoPayRegularApproveResponseVO {
	private String aid, tid, cid, sid;//요청/거래/가맹점/정기결제 코드
	private String partnerOrderId, partnerUserId;
	private String paymentMethodType;//결제 수단(CARD/MONEY)
	private KakaoPayAmountVO amount;//결제 금액 정보
	private KakaoPayCardInfoVO cardInfo;//결제 카드 정보
	private String itemName, itemCode;//상품명/코드
	private int quantity;//상품 수량
	private Date createdAt, approvedAt;//준비/승인 시각
	private String payload;//메모
}
