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
import com.kh.springfinal.dao.PaymentRegularDao;
import com.kh.springfinal.dao.ProductDao;
import com.kh.springfinal.dto.PaymentDetailDto;
import com.kh.springfinal.dto.PaymentDto;
import com.kh.springfinal.dto.PaymentRegularDto;
import com.kh.springfinal.dto.ProductDto;
import com.kh.springfinal.dto.RegularDetailDto;
import com.kh.springfinal.service.KakaoPayRegularService;
import com.kh.springfinal.service.KakaoPayService;
import com.kh.springfinal.vo.KakaoPayApproveRequestVO;
import com.kh.springfinal.vo.KakaoPayApproveResponseVO;
import com.kh.springfinal.vo.KakaoPayCancelRequestVO;
import com.kh.springfinal.vo.KakaoPayCancelResponseVO;
import com.kh.springfinal.vo.KakaoPayReadyRequestVO;
import com.kh.springfinal.vo.KakaoPayReadyResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularApproveRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularApproveResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularCancelRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularCancelResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularReadyRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularReadyResponseVO;
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
	private KakaoPayRegularService kakaoPayRegularService;
	
	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private PaymentRegularDao paymentRegularDao;
	
	@Autowired
	private ProductDao productDao;
	
	
	
	
	//상품 메인화면 띄울예정
	@RequestMapping("/product")
	public String product(Model model) {
		return "pay/product";
	}
	//단건 상품화면
	@RequestMapping("/singleList")
	public String singleList(Model model) {
		List<ProductDto>singleList=productDao.selectSingleProductList();
		model.addAttribute("singleList",singleList);
		return"pay/singleList";
	}
	//정기 상품화면
	@RequestMapping("/regularList")
	public String regularList(Model model) {
		List<ProductDto>regularList=productDao.selectRegularProductList();
		model.addAttribute("regularList",regularList);
		return"pay/regularList";
	}
	//결제 확인화면
	@GetMapping("/purchase")
	public String purchase(@ModelAttribute PurchaseListVO listVO, Model model) {
		List<PurchaseVO> purchaseList = listVO.getProduct();
		
		List<PurchaseConfirmVO> confirmList = new ArrayList<>();//옮겨닮을 리스트
		int total = 0;
		for(PurchaseVO vo : purchaseList) {//사용자가 선택한 번호를 반복하며
			ProductDto productDto =  productDao.selectOne(vo.getProductNo());//상품정보
			
			 if ("단건".equals(productDto.getProductType())) {
			PurchaseConfirmVO confirmVO = PurchaseConfirmVO.builder()
					.purchaseVO(vo).productDto(productDto)
					.build();
		confirmList.add(confirmVO);//화면에 출력할 데이터 추가
		total += confirmVO.getTotal();//총 구매금액 합산
			 }
	}
		
		model.addAttribute("list", confirmList);//선택한번호의상품
		model.addAttribute("total",total);
		return"pay/purchase";
	}
	
	@PostMapping("/purchase")
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
				.build());//카카오페이
			session.setAttribute("listVO",listVO);//구매한 상품의 번호
		
			return "redirect:"+response.getNextRedirectPcUrl();
	}
	
	@GetMapping("/purchase/success")
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
				
				//[3] 상품 개수 만큼 결제 상세정보를 등록
					List<PurchaseVO> list = listVO.getProduct();
					for(PurchaseVO vo : list) {
						ProductDto productDto = productDao.selectOne(vo.getProductNo());
						paymentDao.insertDetail(PaymentDetailDto.builder()
								.paymentDetailOrigin(paymentNo)//상위결제번호
								.paymentDetailProduct(vo.getProductNo())//상품번호
								.paymentDetailProductName(productDto.getProductName())//상품명
								.paymentDetailProductPrice(productDto.getProductPrice())//상품가격
								.paymentDetailProductQty(vo.getQty())//구매수량
								.build());
					}
			
				
		return "redirect:successResult";
	}
	
	@RequestMapping("/purchase/successResult")
	public String successResult() {
		return"pay/successResult";
	}
	
	@RequestMapping("/list")
	public String list(HttpSession session,Model model) {
		String memberId=(String)session.getAttribute("name");
		
		model.addAttribute("list",paymentDao.selectTotalList());//전체내역
		model.addAttribute("list",paymentDao.selectTotalListByMember(memberId));//나의 내역
		
		return"pay/list";
	}
	
	@RequestMapping("/cancel")
	public String cancel(@RequestParam int paymentDetailNo) throws URISyntaxException {
		PaymentDetailDto paymentDetailDto = paymentDao.selectDetail(paymentDetailNo);
		if(paymentDetailDto == null || paymentDetailDto.isCanceled()) {
//			throw new NoTargetException("이미 취소된 결제 입니다");
			 return "errorPage";
		}
		PaymentDto paymentDto =
					paymentDao.selectOne(paymentDetailDto.getPaymentDetailOrigin());
		
		KakaoPayCancelRequestVO request = KakaoPayCancelRequestVO.builder()
                .tid(paymentDto.getPaymentTid()) //거래번호
                .cancelAmount(
                		paymentDetailDto.getPaymentDetailProductPrice()//상품가격
                		* paymentDetailDto.getPaymentDetailProductQty()//구매수량
                		)
                .build();
		
       KakaoPayCancelResponseVO response = kakaoPayService.cancel(request);
       
       paymentDao.cancelDetail(paymentDetailNo);
       paymentDao.cancel(PaymentDto.builder()
    		   .paymentNo(paymentDto.getPaymentNo())//결제대표번호
    		   .paymentRemain(response.getCancelAvailableAmount().getTotal())//잔여금액
    		   .build());
		
       return "redirect:pay/list";
	}
	
	@RequestMapping("/cancelAll")
	public String cancelAll(@RequestParam int paymentNo) throws URISyntaxException {
		PaymentDto paymentDto = paymentDao.selectOne(paymentNo);
		if(paymentDto == null || paymentDto.getPaymentRemain() == 0) {
//			throw new NoTargetException("이미 취소된 결제입니다");
			return"errorPage";
		}
		
		KakaoPayCancelRequestVO request = KakaoPayCancelRequestVO.builder()
				.tid(paymentDto.getPaymentTid())
				.cancelAmount(paymentDto.getPaymentRemain())
				.build();
		KakaoPayCancelResponseVO response = kakaoPayService.cancel(request);
		
		paymentDao.cancel(PaymentDto.builder()
				.paymentNo(paymentNo)
				.paymentRemain(0)
				.build());
		paymentDao.cancelDetailGroup(paymentNo);
		
		return"redirect:pay/list";
	}
	@RequestMapping("/cancelPage")
	public String cancelPage(HttpSession session) {
		session.removeAttribute("approve");
		session.removeAttribute("listVO");
		return "pay/cancelPage";//취소했을때 보여주는 페이지
	}
	@RequestMapping("/failPage")
	public String fail(HttpSession session) {
		session.removeAttribute("approve");
		session.removeAttribute("listVO");
		return "pay/failPage";//실패했을때 보여주는페이지
	}
	
// ----------------------여기부터 정기결제-------------------------------------------
	
			//결제 확인화면
			@GetMapping("/regularPurchase")
			public String regularPurchase(@ModelAttribute PurchaseListVO listVO, Model model) {
				List<PurchaseVO> purchaseList = listVO.getProduct();
				
				List<PurchaseConfirmVO> confirmList = new ArrayList<>();//옮겨닮을 리스트
				int total = 0;
				for(PurchaseVO vo : purchaseList) {//사용자가 선택한 번호를 반복하며
					ProductDto productDto =  productDao.selectOne(vo.getProductNo());//상품정보
					
					 if ("정기".equals(productDto.getProductType())) {
					PurchaseConfirmVO confirmVO = PurchaseConfirmVO.builder()
							.purchaseVO(vo).productDto(productDto)
							.build();
				confirmList.add(confirmVO);//화면에 출력할 데이터 추가
				total += confirmVO.getTotal();//총 구매금액 합산
					 }
			}
				
				model.addAttribute("list", confirmList);//선택한번호의상품
				model.addAttribute("total",total);
				return"pay/regularPurchase";
			}
			
			@PostMapping("/regularPurchase")
			public String regularPurchase(HttpSession session,@ModelAttribute PurchaseListVO listVO) throws URISyntaxException {
				log.debug("listVO={}",listVO);
				
				KakaoPayRegularReadyRequestVO request = kakaoPayRegularService.convert(listVO);
				
				String memberId=(String)session.getAttribute("name");
				request.setPartnerUserId(memberId);
				
				KakaoPayRegularReadyResponseVO response = kakaoPayRegularService.ready(request);
				
				session.setAttribute("approve", KakaoPayRegularApproveRequestVO.builder()
						.partnerOrderId(request.getPartnerOrderId())
						.partnerUserId(request.getPartnerUserId())
						.tid(response.getTid())
						.build());//카카오페이
					session.setAttribute("listVO",listVO);//구매한 상품의 번호
				
					return "redirect:"+response.getNextRedirectPcUrl();
			}
			
			//@RequestMapping("/regularPurchase/regularSuccessResult")
			@GetMapping("/regularPurchase/regularSuccess")
			public String regularSuccess(HttpSession session,@RequestParam String pg_token) throws URISyntaxException {
				//session에 저장한 flash value 추출 및 삭제
						KakaoPayRegularApproveRequestVO request=
								(KakaoPayRegularApproveRequestVO)session.getAttribute("approve");
						PurchaseListVO listVO = (PurchaseListVO)session.getAttribute("listVO");
						
						session.removeAttribute("approve");
						session.removeAttribute("listVO");
						
						request.setPgToken(pg_token);//토큰 설정
						KakaoPayRegularApproveResponseVO response = kakaoPayRegularService.approve(request);//승인요청
						
						log.debug("Response(SID)={}", response.getSid());
					
						//[1] 결제번호 생성
						int paymentRegularNo = Integer.parseInt(response.getPartnerOrderId());
					
						//[2] 결제번호 등록
						paymentRegularDao.insert(PaymentRegularDto.builder()
								.paymentRegularNo(paymentRegularNo)//결제고유번호
								.paymentRegularMember(response.getPartnerUserId())//결제자ID
								.paymentRegularTid(response.getTid())//PG사 거래번호
								.paymentRegularSid(response.getSid())//PG사 정기결제번호
								.paymentRegularName(response.getItemName())//PG사 결제상품명
								.paymentRegularPrice(response.getAmount().getTotal())//총 결제액
								.paymentRegularRemain(response.getAmount().getTotal())//총 취소가능액
								.build());
						
						//[3] 상품 개수 만큼 결제 상세정보를 등록
							List<PurchaseVO> list = listVO.getProduct();
							for(PurchaseVO vo : list) {
								ProductDto productDto = productDao.selectOne(vo.getProductNo());
								paymentRegularDao.insertDetail(RegularDetailDto.builder()
										.regularDetailOrigin(paymentRegularNo)//상위결제번호
										.regularDetailProduct(vo.getProductNo())//상품번호
										.regularDetailProductName(productDto.getProductName())//상품명
										.regularDetailProductPrice(productDto.getProductPrice())//상품가격
										.regularDetailProductQty(vo.getQty())//구매수량
										.build());
							}
					
						
				return "redirect:regularSuccessResult";
			}
			
			@RequestMapping("/regularPurchase/regularSuccessResult")
			public String regularSuccessResult() {
				return"pay/regularSuccessResult";
			}
			
			@RequestMapping("/pay/regularCancel")
			public String regularCancel(@RequestParam int regularDetailNo)throws URISyntaxException{
				//1
				RegularDetailDto regularDetailDto = paymentRegularDao.selectDetail(regularDetailNo);
				
				if(regularDetailDto == null || regularDetailDto.isCanceled() ) {
//					throw new NoTargetException();
					return"에러페이지";
				}
				//2
				PaymentRegularDto paymentRegularDto = paymentRegularDao.selectOne(regularDetailDto.getRegularDetailOrigin());
				//3
				KakaoPayRegularCancelRequestVO request = KakaoPayRegularCancelRequestVO.builder()
						.sid(paymentRegularDto.getPaymentRegularSid())
						.cancelAmount(regularDetailDto.getRegularDetailProductPrice()*regularDetailDto.getRegularDetailProductQty())
						.build();
				//4
				KakaoPayRegularCancelResponseVO response = kakaoPayRegularService.cancel(request);
				//5
				paymentRegularDao.cancelDetail(regularDetailNo);
				paymentRegularDao.cancel(PaymentRegularDto.builder()
						.paymentRegularNo(paymentRegularDto.getPaymentRegularNo())//결제대표번호
						.paymentRegularRemain(response.getCancelAvailableAmount().getTotal())//잔여금액
						.build());
	return "redirect:list2";
}
		@RequestMapping("/pay/regularCancelAll")
		public String regularCancelAll(@RequestParam int paymentRegularNo)throws URISyntaxException{
			
			//1
			PaymentRegularDto paymentRegularDto = paymentRegularDao.selectOne(paymentRegularNo);
			if(paymentRegularDto == null || paymentRegularDto.getPaymentRegularRemain() == 0) {
//				throw new NoTargetException("이미 취소된 결제입니다");
				return"에러페이지";
		}
			//2
			KakaoPayRegularCancelRequestVO request = KakaoPayRegularCancelRequestVO.builder()
					.sid(paymentRegularDto.getPaymentRegularSid())
					.build();
			 log.debug("sid={}",paymentRegularDto.getPaymentRegularSid());
	         log.debug("vo sid={}", request);
	         KakaoPayRegularCancelResponseVO response = kakaoPayRegularService.cancel(request);
	         
	         //3
	         paymentRegularDao.cancel(PaymentRegularDto.builder()
	        		 .paymentRegularNo(paymentRegularNo)
	        		 .paymentRegularRemain(0)
	        		 .build());
	         paymentRegularDao.cancelDetailGroup(paymentRegularNo);
	         
	         return "redirect:list2";
		}
		@RequestMapping("/list2")
		public String list2(HttpSession session,Model model) {
			String memberId = (String) session.getAttribute("name");
			
			model.addAttribute("list",paymentRegularDao.selectTotalList());//전체내경
			model.addAttribute("list",paymentRegularDao.selectTotalListByMember(memberId));//나의내역
			return"pay/list2";
		}
		}
