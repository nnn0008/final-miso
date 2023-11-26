package com.kh.springfinal.component;

import java.net.URISyntaxException;
import java.time.LocalDate;

import org.springframework.stereotype.Component;

import com.kh.springfinal.dto.PaymentDto;
import com.kh.springfinal.dto.PaymentRegularDto;

@Component
public class IsToday {
	public boolean isToday(PaymentRegularDto paymentRegularDto) {//정기결제end날짜가 오늘
	    LocalDate today = LocalDate.now();
	    LocalDate paymentRegularEnd = 
	            ((java.sql.Date) paymentRegularDto.getPaymentRegularEnd()).toLocalDate();
	    return today.isEqual(paymentRegularEnd);
}

public boolean regularMonth(PaymentRegularDto paymentRegularDto) throws URISyntaxException {
	String productName = paymentRegularDto.getPaymentRegularName();
	return productName.contains("1달");
	
}


public boolean regularYear(PaymentRegularDto paymentRegularDto) throws URISyntaxException {
	String productName = paymentRegularDto.getPaymentRegularName();
	return productName.contains("1년");
}

	public boolean endToday(PaymentDto paymentDto) {//단건결제 end날짜가 오늘
		LocalDate today = LocalDate.now();
		LocalDate paymentEnd = ((java.sql.Date) paymentDto.getPaymentEnd()).toLocalDate();
		return today.isEqual(paymentEnd);
	}
	
	

}
