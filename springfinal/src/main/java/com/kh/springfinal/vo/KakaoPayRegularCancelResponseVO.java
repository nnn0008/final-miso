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
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class KakaoPayRegularCancelResponseVO {
	private String cid;//가맹점 코드, 10자
	private String sid;//정기 결제 고유번호, 20자
	private String status;//정기 결제 상태, ACTIVE(활성) 또는 INACTIVE(비활성) 중 하나
	private KakaoPayAmountVO amount, canceledAmount,cancelAvailableAmount;
	private Date createdAt;	//sid 발급 시각
	private Date lastApprovedAt;//	마지막 결제승인 시각
	private Date inActivatedAt;//	정기결제 비활성화 시각
}
