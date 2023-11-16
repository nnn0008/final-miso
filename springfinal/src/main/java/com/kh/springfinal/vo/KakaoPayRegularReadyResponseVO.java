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
@JsonIgnoreProperties(ignoreUnknown = true)//모르는 항목은 무시하도록 지정
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class KakaoPayRegularReadyResponseVO {
	private String tid; //결제 고유번호
	private String nextRedirectAppUrl;//모바일 앱용 결제 페이지 주소
	private String nextRedirectMobilUrl;//모바일 웹용 결제 페이지 주소
	private String nextRedirectPcUrl;//PC 웹용 결제 페이지 주소
	private String androidAppScheme;//카카오페이 결제를 위한 안드로이드 스키마
	private String iosAppScheme;//카카오페이 결제를 위한 아이폰 스키마
	private Date createdAt;//결제 준비를 요청한 시각
}
