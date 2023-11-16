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
public class KakaoPayRegularDetailResponseVO {
	private boolean available;//	사용 가능 여부
	private String cid,sid,status;	//	가맹점 코드, 10자
	private String paymentMethodType;//	결제 수단, CARD 또는 MONEY 중 하나
	private String itemName; //상품 이름. 최대 100자
	private Date createdAt;	//SID 발급 시각
	private Date lastApprovedAt; //마지막 결제 승인 시각
	private Date inactivatedAt; //정기결제 비활성화 시각
}
