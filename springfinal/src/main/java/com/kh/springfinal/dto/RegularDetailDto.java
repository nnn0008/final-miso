package com.kh.springfinal.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@NoArgsConstructor@AllArgsConstructor@Builder
public class RegularDetailDto {
	private int regularDetailNo;//하위 결제번호
	private int regularDetailOrigin;//상위 결제번호
	private int regularDetailProduct;//구매상품번호
	private String regularDetailProductName;//구매상품명
	private int regularDetailProductPrice;//구매상품가격
	private int regularDetailProductQty;//구매상품수량
	private String regularDetailStatus;//구매상품상태(활성화/비활성화)
	
	public boolean isCanceled() {
		return regularDetailStatus.equals("비활성화");
	}
}
