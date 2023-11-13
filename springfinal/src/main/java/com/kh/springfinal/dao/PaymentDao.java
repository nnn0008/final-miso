package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.PaymentDto;
import com.kh.springfinal.vo.PaymentListVO;

public interface PaymentDao {
	int sequence();
	void insert(PaymentDto paymentDto);
	PaymentDto selectOne(int paymentNo);
	
	List<PaymentListVO> selectTotalList();
	List<PaymentListVO> selectTotalListByMember(String paymentMember);
	
	void cancel(PaymentDto paymentDto);

}
