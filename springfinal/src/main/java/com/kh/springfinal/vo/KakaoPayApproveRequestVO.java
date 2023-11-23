package com.kh.springfinal.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@JsonIgnoreProperties(ignoreUnknown = true)//모르는 항목은 무시하도록 지정
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class KakaoPayApproveRequestVO {
	private String cid,tid,partnerOrderId,partnerUserId,pgToken;

}
