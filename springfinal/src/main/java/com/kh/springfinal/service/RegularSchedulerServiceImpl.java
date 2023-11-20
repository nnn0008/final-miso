package com.kh.springfinal.service;

import java.net.URISyntaxException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.springfinal.configuration.KakaoPayProperties;
import com.kh.springfinal.dao.PaymentRegularDao;
import com.kh.springfinal.dto.PaymentRegularDto;
import com.kh.springfinal.vo.KakaoPayRegularRequestRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularRequestResponseVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class RegularSchedulerServiceImpl implements RegularSchedulerService {
	@Autowired
	private KakaoPayProperties kakaoPayProperties;
	
	@Autowired
	KakaoPayRegularService kakaoPayRegularService;
	
	@Autowired
	PaymentRegularDao paymentRegularDao;
	@Scheduled(cron = "0 0 9 * * *")//매일 9시 마다
//	 @Scheduled(fixedRate = 300000) // 5분
	@Override
	public void regularPayment() throws URISyntaxException {
		log.debug("정기결제 실행");
		
		List<PaymentRegularDto> list = paymentRegularDao.selectList();
		for(PaymentRegularDto paymentRegularDto : list ) {
			
		
		 KakaoPayRegularRequestRequestVO request = KakaoPayRegularRequestRequestVO.builder()
		            .cid(kakaoPayProperties.getRegularCid())
		            .sid(paymentRegularDto.getPaymentRegularSid())
		            .partnerOrderId(String.valueOf(paymentRegularDto.getPaymentRegularNo()))
		            .partnerUserId(paymentRegularDto.getPaymentRegularMember())
		            .itemName(paymentRegularDto.getPaymentRegularName())
		            .totalAmount(paymentRegularDto.getPaymentRegularPrice())
		            .quantity(1)
		            .build();
		 KakaoPayRegularRequestResponseVO response = kakaoPayRegularService.request(request);
	
		}
	 }
}
