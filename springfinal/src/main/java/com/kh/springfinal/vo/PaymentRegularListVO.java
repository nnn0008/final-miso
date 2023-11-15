package com.kh.springfinal.vo;

import java.util.List;

import com.kh.springfinal.dto.PaymentRegularDto;
import com.kh.springfinal.dto.RegularDetailDto;

import lombok.Data;

@Data
public class PaymentRegularListVO {
	private PaymentRegularDto paymentRegularDto;
	private List<RegularDetailDto> regularDetailList;
}
