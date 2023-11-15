package com.kh.springfinal.service;

import java.net.URISyntaxException;

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

public interface KakaoPayRegularService {
	KakaoPayRegularReadyResponseVO ready(KakaoPayRegularReadyRequestVO request)throws URISyntaxException;
	KakaoPayRegularApproveResponseVO approve(KakaoPayRegularApproveRequestVO request)throws URISyntaxException;
	KakaoPayRegularDetailResponseVO detail(KakaoPayDetailRequestVO request)throws URISyntaxException;
	KakaoPayRegularRequestResponseVO request(KakaoPayRegularRequestRequestVO request)throws URISyntaxException;
	KakaoPayCancelResponseVO cancel(KakaoPayCancelRequestVO request)throws URISyntaxException;
	KakaoPayRegularOrderResponseVO order(KakaoPayRegularOrderRequestVO request)throws URISyntaxException;
	KakaoPayRegularReadyResponseVO ready2(KakaoPayRegularReadyRequestVO request)throws URISyntaxException;
	KakaoPayRegularApproveResponseVO approve2(KakaoPayRegularApproveRequestVO request)throws URISyntaxException;
	KakaoPayReadyRequestVO convert(PurchaseListVO listVO);
}
