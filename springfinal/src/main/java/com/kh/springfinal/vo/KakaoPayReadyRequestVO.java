package com.kh.springfinal.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
//@JsonIgnoreProperties({"tms_result"})//특정 항목만 무시하도록 지정
@JsonIgnoreProperties(ignoreUnknown = true)//모르는 항목은 무시하도록 지정
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class KakaoPayReadyRequestVO {
	private String partnerOrderId;
	private String partnerUserId;
	private String itemName;
	private int itemPrice;
}
