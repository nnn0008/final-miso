package com.kh.springfinal.service;

import java.net.URISyntaxException;

import com.kh.springfinal.vo.KakaoPayApproveRequestVO;
import com.kh.springfinal.vo.KakaoPayApproveResponseVO;
import com.kh.springfinal.vo.KakaoPayCancelRequestVO;
import com.kh.springfinal.vo.KakaoPayCancelResponseVO;
import com.kh.springfinal.vo.KakaoPayDetailRequestVO;
import com.kh.springfinal.vo.KakaoPayDetailResponseVO;
import com.kh.springfinal.vo.KakaoPayReadyRequestVO;
import com.kh.springfinal.vo.KakaoPayReadyResponseVO;
import com.kh.springfinal.vo.PurchaseListVO;

public interface KakaoPayService {
	KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO request) throws URISyntaxException;
	KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO request)throws URISyntaxException;
	KakaoPayDetailResponseVO detail(KakaoPayDetailRequestVO request)throws URISyntaxException;
	KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO request)throws URISyntaxException;
	
	KakaoPayReadyRequestVO convert(PurchaseListVO listVO);
}
