package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@NoArgsConstructor@AllArgsConstructor@Builder
public class PaymentRegularDto {
	private int paymentRegularNo;//정기결제번호
	private String paymentRegularMember;//구매회원ID
	private String paymentRegularTid;//PG사 결제 거래번호
	private String paymentRegularSid;//PG사 정기거래번호
	private String paymentRegularName;//PG사 결제 상품명
	private int paymentRegularPrice;//PG사 결제 가격
	private int paymentRegularRemain;//잔여 결제 금액(취소 가능 금액)
	private Date paymentRegularTime;//결제시간
	private Date paymentRegularBegin;//시작일
	private Date paymentRegularEnd;//만료일
}
