package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class KakaoPayRegularApproveRequestVO {
	private String cid; //가맹점 코드
	private String tid; // 결제 고유 번호
	private String partner_order_id; //가맹점 주분번호
	private String partner_user_id; // 가맹점 회원아이디
	private String pg_token; // 결제승인 인증용 토큰
}
