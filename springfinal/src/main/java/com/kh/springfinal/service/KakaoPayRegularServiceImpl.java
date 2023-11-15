package com.kh.springfinal.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.springfinal.configuration.KakaoPayProperties;
import com.kh.springfinal.dao.PaymentRegularDao;
import com.kh.springfinal.dao.ProductDao;
import com.kh.springfinal.vo.KakaoPayApproveRequestVO;
import com.kh.springfinal.vo.KakaoPayApproveResponseVO;
import com.kh.springfinal.vo.KakaoPayCancelRequestVO;
import com.kh.springfinal.vo.KakaoPayCancelResponseVO;
import com.kh.springfinal.vo.KakaoPayDetailRequestVO;
import com.kh.springfinal.vo.KakaoPayReadyRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularApproveRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularApproveResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularDetailResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularOrderRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularOrderResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularReadyRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularReadyResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularRequestRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularRequestResponseVO;
import com.kh.springfinal.vo.PurchaseListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class KakaoPayRegularServiceImpl implements KakaoPayRegularService {
	
	@Autowired
	private KakaoPayProperties kakaoPayProperties;
	
	@Autowired
	private RestTemplate template;
	
	@Autowired
	private HttpHeaders headers;

	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private PaymentRegularDao paymentRegularDao;
	
	
	
	@Override
	public KakaoPayRegularReadyResponseVO ready(KakaoPayRegularReadyRequestVO request) throws URISyntaxException {
			
		//주소 설정
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		//바디 설정
		MultiValueMap <String,String> body = new LinkedMultiValueMap<>();
		body.add("cid", kakaoPayProperties.getRegularCid());
		body.add("partner_order_id", request.getPartnerOrderId());
		body.add("partner_user_id", request.getPartnerUserId());
		body.add("item_name", request.getItemName());
		body.add("quantity", "1");
		body.add("total_amount", String.valueOf(request.getTotalAmount()));
		body.add("vat_amount", "0");
		body.add("tax_free_amount", "0");
		
		//현재 페이지 주소 계산
		String path = ServletUriComponentsBuilder.fromCurrentRequestUri().toUriString();
		body.add("approval_url",path+"/success");
		body.add("cancel_url",path+"/cancel");
		body.add("fail_url",path+"/fail");
		
		//요청 발송
		HttpEntity entity = new HttpEntity(body,headers);//요청객체
		
		KakaoPayRegularReadyResponseVO response = template.postForObject(uri, entity, KakaoPayRegularReadyResponseVO.class);
		return response;
	}

	@Override
	public KakaoPayRegularApproveResponseVO approve(KakaoPayRegularApproveRequestVO request) throws URISyntaxException {
		
		//주소설정
		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");
		
		//바디설정
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("cid", kakaoPayProperties.getRegularCid());
		body.add("tid", request.getTid()); 
		body.add("partner_order_id", request.getPartnerOrderId()); 
		body.add("partner_user_id", request.getPartnerUserId());
		body.add("pg_token", request.getPgToken());
		
		HttpEntity entity = new HttpEntity(body,headers);//요청 객체
		
		KakaoPayRegularApproveResponseVO response = template.postForObject(uri, entity, KakaoPayRegularApproveResponseVO.class);
		
		log.debug("결제 승인 완료 = {}",response.getTid());
		
		return response;
	}
	
	@Override
	public KakaoPayRegularDetailResponseVO detail(KakaoPayDetailRequestVO request) throws URISyntaxException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public KakaoPayRegularRequestResponseVO request(KakaoPayRegularRequestRequestVO request) throws URISyntaxException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO request) throws URISyntaxException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public KakaoPayRegularOrderResponseVO order(KakaoPayRegularOrderRequestVO request) throws URISyntaxException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public KakaoPayRegularReadyResponseVO ready2(KakaoPayRegularReadyRequestVO request) throws URISyntaxException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public KakaoPayRegularApproveResponseVO approve2(KakaoPayRegularApproveRequestVO request)
			throws URISyntaxException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public KakaoPayReadyRequestVO convert(PurchaseListVO listVO) {
		// TODO Auto-generated method stub
		return null;
	}


}
