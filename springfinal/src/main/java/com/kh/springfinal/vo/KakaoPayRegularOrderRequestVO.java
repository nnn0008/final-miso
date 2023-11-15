package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class KakaoPayRegularOrderRequestVO {
	private String sid;//정기 결제 고유번호. 20자
	private String cid;//가맹점 코드
	private String tid; // 결제 고유 번호
}
