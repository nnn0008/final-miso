package com.kh.springfinal.vo;

import java.sql.Date;
import java.util.List;

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
public class KakaoPayDetailResponseVO {
	private String tid,cid,status;
	private String partnerOrderId,partnerUserId;
	private String paymentMethodType;
	private KakaoPayAmountVO amount, canceledAmount,cancelAvailableAmount;
	private String itemName, itemCode;
	private int quantity;
	private Date createdAt, approvedAt, canceledAt;
	private KakaoPaySelectedCardInfo selectedCardInfo;
	private List<KakaoPaymentActionDetailVO> paymentActionDetails;//List를 선호
	
}
