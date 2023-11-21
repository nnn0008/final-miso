package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.PaymentDto;
import com.kh.springfinal.dto.PaymentRegularDto;
import com.kh.springfinal.dto.RegularDetailDto;
import com.kh.springfinal.vo.PaymentRegularListVO;

public interface PaymentRegularDao {
	int sequence();
	void insert(PaymentRegularDto paymentRegularDto);
	List<PaymentRegularDto>selectList();
	PaymentRegularDto selectOne(int paymentRegularNo);
	
	void insertDetail(RegularDetailDto regularDetailDto);
	
	List<PaymentRegularListVO> selectTotalList();
	List<PaymentRegularListVO> selectTotalListByMember(String paymentRegularMember);
	
	RegularDetailDto selectDetail(int regularDetailNo);
	void cancelDetail(int regularDetailNo);
	void cancel(PaymentRegularDto paymentRegularDto);
	void cancelDetailGroup(int regularDetailOrigin);
	
	
	//5분마다 정기결제 테스트
	void updatePaymentRegularTime();
	
}
