package com.kh.springfinal.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.springfinal.configuration.KakaoPayProperties;
import com.kh.springfinal.dao.PaymentRegularDao;
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
	
	 @Scheduled(fixedRate = 300000) // 5분
	@Override
	public void regularPayment() {
		log.debug("정기결제 실행");
//	KakaoPayRegularRequestRequestVO request = KakaoPayRegularRequestRequestVO.builder()
//			.cid(kakaoPayProperties.getRegularCid())
//			.sid(request.getSid())
//			.partnerOrderId(request.getPartnerOrderId())
//			.partnerUserId(request.getPartnerUserId())
//			.itemName(request.getItemName())
//			.quantity(String.valueOf(request.getQuantity()))
//			.totalAmount(String.valueOf(request.getTotalAmount()))
//			.taxFreeAmount("0")
//			.build();
//	KakaoPayRegularRequestResponseVO response = kakaoPayRegularService.request(request);
	}

}
