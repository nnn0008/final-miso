package com.kh.springfinal.component;

import java.net.URISyntaxException;
import java.sql.Date;
import java.time.LocalDate;

import org.springframework.stereotype.Component;

import com.kh.springfinal.dto.PaymentDto;
import com.kh.springfinal.dto.PaymentRegularDto;

@Component
public class IsToday {
	public boolean isToday(PaymentRegularDto paymentRegularDto) {
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

}
