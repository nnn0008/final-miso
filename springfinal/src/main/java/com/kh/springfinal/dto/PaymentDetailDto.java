package com.kh.springfinal.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@NoArgsConstructor@AllArgsConstructor@Builder
public class PaymentDetailDto {
	private int paymentDetailNo;//하위 결제번호
	private int paymentDetailOrigin;//상위 결제번호
	private int paymentDetailProduct;//구매상품번호
	private String paymentDetailProductName;//구매상품명
	private int paymentDetailProductPrice;//구매상품가격
	private int paymentDetailProductQty;//구매상품수량
	private String paymentDetailStatus;//구매상품상태(완료/취소)
	
	public boolean isCanceled() {
		return paymentDetailStatus.equals("취소");
	}
}
