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
import com.kh.springfinal.dao.PaymentDao;
import com.kh.springfinal.dao.PaymentRegularDao;
import com.kh.springfinal.dao.ProductDao;
import com.kh.springfinal.dto.ProductDto;
import com.kh.springfinal.vo.KakaoPayApproveRequestVO;
import com.kh.springfinal.vo.KakaoPayApproveResponseVO;
import com.kh.springfinal.vo.KakaoPayCancelRequestVO;
import com.kh.springfinal.vo.KakaoPayCancelResponseVO;
import com.kh.springfinal.vo.KakaoPayDetailRequestVO;
import com.kh.springfinal.vo.KakaoPayDetailResponseVO;
import com.kh.springfinal.vo.KakaoPayReadyRequestVO;
import com.kh.springfinal.vo.KakaoPayReadyResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularApproveRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularCancelRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularCancelResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularDetailRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularDetailResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularReadyResponseVO;
import com.kh.springfinal.vo.PurchaseListVO;
import com.kh.springfinal.vo.PurchaseVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class KakaoPayServiceImpl implements KakaoPayService {

	@Autowired
	private KakaoPayProperties kakaoPayProperties;
	
	@Autowired
	private RestTemplate template;
	
	@Autowired
	private HttpHeaders headers;

	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private PaymentRegularDao paymentRegularDao;
	
	@Override
	public KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO request) throws URISyntaxException {
		
		//주소 설정
		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");
		
		//바디 설정
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid",kakaoPayProperties.getCid());
		body.add("partner_order_id",request.getPartnerOrderId());
		body.add("partner_user_id",request.getPartnerUserId());
		body.add("item_name",request.getItemName());
		body.add("quantity","1");
		body.add("total_amount",String.valueOf(request.getItemPrice()));//100만원이 최대(개발자)
		body.add("tax_free_amount","0");//비과세
		
		//현재 페이지 주소 계산
		String path = ServletUriComponentsBuilder.fromCurrentRequestUri().toUriString();
		body.add("approval_url",path+"/success");
		body.add("cancel_url",path+"/cancel");
		body.add("fail_url",path+"/fail");
		
		//요청 발송
		HttpEntity entity = new HttpEntity(body,headers);//요청 객체
		
		KakaoPayReadyResponseVO response = template.postForObject(uri, entity, KakaoPayReadyResponseVO.class);
		
		return response;
	}

	@Override
	public KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO request) throws URISyntaxException {
		
		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", kakaoPayProperties.getCid());
		body.add("tid",request.getTid() );//거래번호
		body.add("partner_order_id", request.getPartnerOrderId());
		body.add("partner_user_id", request.getPartnerUserId());
		body.add("pg_token", request.getPgToken());
		
		
		
		HttpEntity entity = new HttpEntity(body,headers);//요청 객체
		
		KakaoPayApproveResponseVO response = template.postForObject(uri, entity, KakaoPayApproveResponseVO.class);
		
		log.debug("결제 승인 완료 = {}", response.getTid());
		
		return response;
	}

	@Override
	public KakaoPayDetailResponseVO detail(KakaoPayDetailRequestVO request) throws URISyntaxException {
		URI uri = new URI("https://kapi.kakao.com/v1/payment/order");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", kakaoPayProperties.getCid());
		body.add("tid",request.getTid() );//거래번호
		
		
		HttpEntity entity = new HttpEntity(body,headers);//요청 객체
		
		KakaoPayDetailResponseVO response = template.postForObject(uri, entity, KakaoPayDetailResponseVO.class);
		return response;
	}

	@Override
	public KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO request) throws URISyntaxException {
		URI uri = new URI("https://kapi.kakao.com/v1/payment/cancel");
		
		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", kakaoPayProperties.getCid());
		body.add("tid", request.getTid());
		body.add("cancel_amount",String.valueOf(request.getCancelAmount()));
		body.add("cancel_tax_free_amount","0");
		
		HttpEntity entity = new HttpEntity(body,headers);
		
		KakaoPayCancelResponseVO response = template.postForObject(uri, entity, KakaoPayCancelResponseVO.class);
		return response;
	}

	@Override
	public KakaoPayReadyRequestVO convert(PurchaseListVO listVO) {
		//구매목록 추출
		List<PurchaseVO> list = listVO.getProduct();
		
		//결제 사용할 정보를 저장할 변수들
		String name = null;
		int total = 0;
		
		//구매목록을 모두 조사하여 상품정보 추출 후 필요한 항목을 계산
		for(PurchaseVO vo : list) {
			//vo 안에는 상품번호(productNo)가 있다
			ProductDto dto = productDao.selectOne(vo.getProductNo());
			if(name ==null) {//이름이 없을때만 이름을 넣어라(최초 이름만 들어감)
				name=dto.getProductName();
			}
			total += dto.getProductPrice() *  vo.getQty();;
		}
		
		if(list.size() >= 2) {
			name += " 외"+(list.size()-1)+"건";
		}
		
		
		
		//partner_oder_id에 결제번호를 집어넣으면 충돌도 없고 좋지 않을까?
		int paymentNo = paymentDao.sequence();
		
		return KakaoPayReadyRequestVO.builder()
				.partnerOrderId(String.valueOf(paymentNo))
				.itemName(name)
				.itemPrice(total)
				.build();
	}

}
