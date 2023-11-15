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
public class KakaoPayRegularOrderResponseVO {
	private boolean available;//	사용 가능 여부
	private String cid;	//	가맹점 코드, 10자
	private String sid;	//정기 결제 고유 번호, 20자
	private String status;	//정기 결제 상태, ACTIVE(활성) 또는 INACTIVE(비활성) 중 하나
	private String payment_method_type;//	결제 수단, CARD 또는 MONEY 중 하나
	private String item_name; //상품 이름. 최대 100자
	private Date created_at;	//SID 발급 시각
	private Date last_approved_at; //마지막 결제 승인 시각
	private Date inactivated_at; //정기결제 비활성화 시각
}
