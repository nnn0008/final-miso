package com.kh.springfinal.service;

import java.net.URISyntaxException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.springfinal.component.IsToday;
import com.kh.springfinal.configuration.KakaoPayProperties;
import com.kh.springfinal.dao.PaymentDao;
import com.kh.springfinal.dao.PaymentRegularDao;
import com.kh.springfinal.dto.PaymentDto;
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
	
	@Autowired
	PaymentDao paymentDao;
	
	@Autowired
	IsToday isToday;
	
	
	@Scheduled(cron = "0 0 9 * * *")//매일 9시 마다 데이터확인

	


	@Override
	public void regularPayment() throws URISyntaxException {
		log.debug("실행되나?");
			
		List<PaymentRegularDto> list = paymentRegularDao.selectList();
		for(PaymentRegularDto paymentRegularDto : list ) {
			boolean today = isToday.isToday(paymentRegularDto);
			
			if(today) {
				
				if(isToday.regularMonth(paymentRegularDto)) {//1달
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
				 request.setTid(response.getTid());
				 paymentRegularDto.setPaymentRegularTid(response.getTid());
				 paymentRegularDao.updatePaymentRegularTime(paymentRegularDto);
				 log.debug("response={}",response);
				 log.debug("dto={}",paymentRegularDto);
				 log.debug("request{}",request);
				 log.debug("1달 완료");
				}
				else if(isToday.regularYear(paymentRegularDto)) {//1년
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
				 request.setTid(response.getTid());
				 paymentRegularDto.setPaymentRegularTid(response.getTid());
				 paymentRegularDao.updatePaymentRegularTime(paymentRegularDto);
				 log.debug("1년 완료");
				}
			}
		
	
		}
	 }



}
