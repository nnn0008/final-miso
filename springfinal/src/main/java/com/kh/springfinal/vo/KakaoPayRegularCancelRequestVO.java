package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class KakaoPayRegularCancelRequestVO {
	private String sid;//요청 고유 번호
	private String cid;//가맹점 코드
}
