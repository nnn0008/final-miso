package com.kh.springfinal.service;

import java.net.URISyntaxException;

import com.kh.springfinal.dto.PaymentRegularDto;

public interface RegularSchedulerService {
	void regularPayment() throws URISyntaxException;
//	boolean regularMonth(PaymentRegularDto paymentRegularDto) throws URISyntaxException;//1달
//	boolean regularYear(PaymentRegularDto paymentRegularDto) throws URISyntaxException;//1년
//	
//	boolean isToday(PaymentRegularDto paymentRegularDto);//결제일이 오늘 날짜인지 검사
}
