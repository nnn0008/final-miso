package com.kh.springfinal.controller;

import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dao.PaymentDao;
import com.kh.springfinal.dao.ProductDao;
import com.kh.springfinal.dto.PaymentDto;
import com.kh.springfinal.dto.ProductDto;
import com.kh.springfinal.service.KakaoPayService;
import com.kh.springfinal.vo.KakaoPayApproveRequestVO;
import com.kh.springfinal.vo.KakaoPayApproveResponseVO;
import com.kh.springfinal.vo.KakaoPayReadyRequestVO;
import com.kh.springfinal.vo.KakaoPayReadyResponseVO;
import com.kh.springfinal.vo.PurchaseConfirmVO;
import com.kh.springfinal.vo.PurchaseListVO;
import com.kh.springfinal.vo.PurchaseVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/pay")
public class KakaopayController {
	@Autowired
	private KakaoPayService kakaoPayService;
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private ProductDao productDao;
	
	@RequestMapping("/product")
	public String product(Model model) {
		List<ProductDto>list=productDao.selectList();
		model.addAttribute("list",list);
		return "pay/product";
	}
	//결제 확인화면
	@GetMapping("/purchase")
	public String purchase(@ModelAttribute PurchaseListVO listVO, Model model) {
		List<PurchaseVO> purchaseList = listVO.getProduct();
		
		List<PurchaseConfirmVO> confirmList = new ArrayList<>();//옮겨닮을 리스트
		int total = 0;
		for(PurchaseVO vo : purchaseList) {//사용자가 선택한 번호를 반복하며
			ProductDto productDto =  productDao.selectOne(vo.getProductNo());
			
			PurchaseConfirmVO confirmVO = PurchaseConfirmVO.builder()
					.purchaseVO(vo).productDto(productDto)
					.build();
		confirmList.add(confirmVO);//화면에 출력할 데이터 추가
		total += confirmVO.getTotal();//총 구매금액 합산
	}
		
		model.addAttribute("list", confirmList);//선택한번호의상품
		model.addAttribute("total",total);
		return"pay/purchase";
	}
	
	@PostMapping("purchase")
	public String purchase(HttpSession session,@ModelAttribute PurchaseListVO listVO) throws URISyntaxException {
		log.debug("listVO={}",listVO);
		
		KakaoPayReadyRequestVO request = kakaoPayService.convert(listVO);
		
		String memberId=(String)session.getAttribute("name");
		request.setPartnerUserId(memberId);
		
		KakaoPayReadyResponseVO response = kakaoPayService.ready(request);
		
		session.setAttribute("approve", KakaoPayApproveRequestVO.builder()
				.partnerOrderId(request.getPartnerOrderId())
				.partnerUserId(request.getPartnerUserId())
				.tid(response.getTid())
				.build());//승인요청을 위한 준비데이터 -->카카오페이
			session.setAttribute("listVO",listVO);//구매한 상품의 번호
		
			return "redirect:"+response.getNextRedirectPcUrl();
	}
	
	@GetMapping("purchase/success")
	public String success(HttpSession session,@RequestParam String pg_token) throws URISyntaxException {
		//session에 저장한 flash value 추출 및 삭제
				KakaoPayApproveRequestVO request=
						(KakaoPayApproveRequestVO)session.getAttribute("approve");
				PurchaseListVO listVO = (PurchaseListVO)session.getAttribute("listVO");
				
				session.removeAttribute("approve");
				session.removeAttribute("listVO");
				
				request.setPgToken(pg_token);//토큰 설정
				KakaoPayApproveResponseVO response = kakaoPayService.approve(request);//승인요청
				
				//[1] 결제번호 생성
				int paymentNo = Integer.parseInt(response.getPartnerOrderId());
				
				//[2] 결제번호 등록
				paymentDao.insert(PaymentDto.builder()
						.paymentNo(paymentNo)//결제고유번호
						.paymentMember(response.getPartnerUserId())//결제자ID
						.paymentTid(response.getTid())//PG사 거래번호
						.paymentName(response.getItemName())//PG사 결제상품명
						.paymentPrice(response.getAmount().getTotal())//총 결제액
						.paymentRemain(response.getAmount().getTotal())//총 취소가능액
						.build());
				//[3] 상품 상세정보를 등록
				List<PurchaseVO> list = listVO.getProduct();
				for(PurchaseVO vo : list) {
					ProductDto productDto = productDao.selectOne(vo.getProductNo());//상품정보 조회
					paymentDao.insert(PaymentDto.builder()
							.paymentNo(paymentNo)
							.paymentProduct(vo.getProductNo())
							.paymentName(productDto.getProductName())
							.paymentPrice(productDto.getProductPrice())
							.build());
				}
				
		return "redirect:pay/successResult";
	}
	
	@RequestMapping("purchase/successResult")
	public String successResult() {
		return"pay/successResult";
	}
	
	@RequestMapping("purchase/list")
	public String list(HttpSession session,Model model) {
		String memberId=(String)session.getAttribute("name");
		
		model.addAttribute("list",paymentDao.selectTotalListByMember(memberId));
		
		return"pay/list";
	}
}
