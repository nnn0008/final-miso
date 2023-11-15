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
import com.kh.springfinal.vo.KakaoPayRegularApproveRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularCancelRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularCancelResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularDetailRequestVO;
import com.kh.springfinal.vo.KakaoPayRegularDetailResponseVO;
import com.kh.springfinal.vo.KakaoPayRegularReadyResponseVO;
import com.kh.springfinal.vo.PurchaseListVO;

public interface KakaoPayService {
	KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO request) throws URISyntaxException;
	KakaoPayRegularReadyResponseVO ready2(KakaoPayReadyRequestVO request) throws URISyntaxException;
	
	KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO request)throws URISyntaxException;
	KakaoPayApproveResponseVO approve2(KakaoPayRegularApproveRequestVO request)throws URISyntaxException;
	
	KakaoPayDetailResponseVO detail(KakaoPayDetailRequestVO request)throws URISyntaxException;
	KakaoPayRegularDetailResponseVO detail2(KakaoPayRegularDetailRequestVO request)throws URISyntaxException;
	
	KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO request)throws URISyntaxException;
	KakaoPayRegularCancelResponseVO cancel2(KakaoPayRegularCancelRequestVO request)throws URISyntaxException;
	
	
	KakaoPayReadyRequestVO convert(PurchaseListVO listVO);
}
