package com.kh.springfinal.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;

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
import com.kh.springfinal.dto.ProductDto;
import com.kh.springfinal.vo.KakaoPayRegularApproveRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularApproveResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularCancelRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularCancelResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularDetailRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularDetailResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularReadyRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularReadyResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularRequestRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularRequestResponseVO;
import com.kh.springfinal.vo.PurchaseListVO;
import com.kh.springfinal.vo.PurchaseVO;

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
		body.add("total_amount", String.valueOf(request.getItemPrice()));
		body.add("tax_free_amount", "0");
		
		//현재 페이지 주소 계산
		String path = ServletUriComponentsBuilder.fromCurrentRequestUri().toUriString();
		body.add("approval_url",path+"/regularSuccess");
		body.add("cancel_url",path+"/cancelPage");
		body.add("fail_url",path+"/failPage");
		
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
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", kakaoPayProperties.getRegularCid());
		body.add("tid", request.getTid()); 
		body.add("partner_order_id", request.getPartnerOrderId()); 
		body.add("partner_user_id", request.getPartnerUserId());
		body.add("pg_token", request.getPgToken());
		
		HttpEntity entity = new HttpEntity(body,headers);//요청 객체
		log.debug("알려주세요={}",entity);
		
		
		KakaoPayRegularApproveResponseVO response = template.postForObject(uri, entity, KakaoPayRegularApproveResponseVO.class);
		
		log.debug("정기결제 1차 승인 완료 = {}",response.getTid());
		log.debug("sid = {}",response.getSid());
		return response;
	}
	@Override
	public KakaoPayRegularRequestResponseVO request(KakaoPayRegularRequestRequestVO request) throws URISyntaxException {
		
		//주소설정
		URI uri = new URI("https://kapi.kakao.com/v1/payment/subscription");
				
		//바디설정
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("cid", kakaoPayProperties.getRegularCid());
		body.add("tid", request.getTid());
		body.add("sid", request.getSid());
		body.add("partner_order_id", request.getPartnerOrderId());
		body.add("partner_user_id", request.getPartnerUserId());
		body.add("item_name", request.getItemName());
		body.add("quantity",String.valueOf(request.getQuantity()));
		body.add("total_amount",String.valueOf(request.getTotalAmount()));//이건 개발자 100만원최대
		body.add("tax_free_amount", "0");
		
		HttpEntity entity = new HttpEntity(body,headers);//요청 객체
		
		KakaoPayRegularRequestResponseVO response = template.postForObject(uri, entity, KakaoPayRegularRequestResponseVO.class);
		log.debug("2차 결제 승인 완료 = {}", response.getTid());
		return response;
	}
	
	@Override
	public KakaoPayRegularCancelResponseVO cancel(KakaoPayRegularCancelRequestVO request) throws URISyntaxException {
		
		//주소설정
		URI uri = new URI("https://kapi.kakao.com/v1/payment/cancel");
		
		//바디설정
		MultiValueMap<String, String>body = new LinkedMultiValueMap<>();
		body.add("cid", kakaoPayProperties.getRegularCid());
		body.add("tid", request.getTid());
		body.add("cancel_amount", String.valueOf(request.getCancelAmount()));
		body.add("cancel_tax_free_amount", "0");
		
		HttpEntity entity = new HttpEntity(body,headers);//요청 객체
		
		KakaoPayRegularCancelResponseVO response = template.postForObject(uri, entity, KakaoPayRegularCancelResponseVO.class);
		
		return response;
	}

	@Override
	public KakaoPayRegularDetailResponseVO detail(KakaoPayRegularDetailRequestVO request) throws URISyntaxException {
		
		//주소 설정
		URI uri = new URI("https://kapi.kakao.com/v1/payment/manage/subscription/status");
		
		//바디 설정
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", kakaoPayProperties.getRegularCid());
		body.add("sid", request.getSid());
		
		HttpEntity entity = new HttpEntity(body,headers);//요청 객체
		
		KakaoPayRegularDetailResponseVO response = template.postForObject(uri, entity, KakaoPayRegularDetailResponseVO.class);
		
		return response;
	}
	

//	@Override
//	public KakaoPayRegularReadyResponseVO ready2(KakaoPayRegularReadyRequestVO request) throws URISyntaxException {
//		
//		//주소 설정
//		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
//		
//		//바디 설정
//		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
//		body.add("cid", kakaoPayProperties.getRegularCid());
//		body.add("partner_order_id", request.getPartnerOrderId());
//		body.add("partner_user_id", request.getPartnerUserId());
//		body.add("item_name", request.getItemName());
//		body.add("quantity", "1");
//		body.add("total_amount", String.valueOf(request.getItemPrice()));
//		body.add("vat_amount", "0");
//		body.add("tax_free_amount", "0");
//		
//		//현재 페이지 주소 계산
//		String path = ServletUriComponentsBuilder.fromCurrentRequestUri().toUriString();
//		body.add("approval_url",path+"/regularSuccess");
//		body.add("cancel_url",path+"/cancelPage");
//		body.add("fail_url",path+"/failPage");
//		
//		//요청 발송
//		HttpEntity entity = new HttpEntity(body,headers);//요청객체
//				
//		KakaoPayRegularReadyResponseVO response = template.postForObject(uri, entity, KakaoPayRegularReadyResponseVO.class);
//		
//		return response;
//	}
//
//	@Override
//	public KakaoPayRegularApproveResponseVO approve2(KakaoPayRegularApproveRequestVO request)
//			throws URISyntaxException {
//		
//		//주소 설정
//		URI uri = new URI("https://kapi.kakao.com/v1/payment/subscription");
//		
//		//바디설정
//		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
//		body.add("cid", kakaoPayProperties.getRegularCid());
//		body.add("tid", request.getTid());
//		body.add("sid", request.getSid());
//		body.add("partner_order_id", request.getPartnerOrderId()); 
//		body.add("partner_user_id", request.getPartnerUserId());
//		body.add("quantity", "1");
//		body.add("total_amount",String.valueOf(request.getItemPrice()));
//		body.add("tax_free_amount", "0");
//				
//		HttpEntity entity = new HttpEntity(body,headers);//요청 객체
//				
//		KakaoPayRegularApproveResponseVO response = template.postForObject(uri, entity, KakaoPayRegularApproveResponseVO.class);
//				
//				
//		return response;
//	}

	
	@Override
	public KakaoPayRegularReadyRequestVO convert(PurchaseListVO listVO) {
		//구매목록 추출
		List<PurchaseVO> list = listVO.getProduct();
		
		//결제 사용할 정보 저장
		String name = null;
		int total = 0;
		
		//구매목록을 모두 조사하여 상품정보 추출 후 필요한 항목 계산
		for(PurchaseVO vo : list) {
			//vo안에는 상품번호가 있음
			ProductDto dto = productDao.selectOne(vo.getProductNo());
			if(name==null) {//이름이 없을때만 이름을 넣어
				name=dto.getProductName();
			}
			total += dto.getProductPrice() * vo.getQty();
		}
		if(list.size() >= 2) {
			name += "외" + (list.size()-1) + "건";
		}
		System.out.println("Total Price: " + total);
		
		int paymentRegularNo= paymentRegularDao.sequence();
		
		return KakaoPayRegularReadyRequestVO.builder()
				.partnerOrderId(String.valueOf(paymentRegularNo))
				.itemName(name)
				.itemPrice(total)
				.build();
	}


}
