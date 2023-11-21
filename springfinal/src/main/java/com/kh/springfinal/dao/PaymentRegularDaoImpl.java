package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.PaymentDto;
import com.kh.springfinal.dto.PaymentRegularDto;
import com.kh.springfinal.dto.RegularDetailDto;
import com.kh.springfinal.vo.PaymentRegularListVO;

@Repository
public class PaymentRegularDaoImpl implements PaymentRegularDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("paymentRegular.sequence");
	}

	@Override
	public void insert(PaymentRegularDto paymentRegularDto) {
		sqlSession.insert("paymentRegular.insert",paymentRegularDto);
	}
	@Override
	public void insertDetail(RegularDetailDto regularDetailDto) {
		sqlSession.insert("paymentRegular.insertDetail",regularDetailDto);
	}

	@Override
	public List<PaymentRegularDto> selectList() {
		return sqlSession.selectList("paymentRegular.list2");
	}
	@Override
	public List<PaymentRegularListVO> selectTotalList() {
		return sqlSession.selectList("paymentRegular.regularListAll");
	}
	@Override
	public RegularDetailDto selectDetail(int regularDetailNo) {
		return sqlSession.selectOne("paymentRegular.regularSelectDetail",regularDetailNo);
	}

	@Override
	public PaymentRegularDto selectOne(int paymentRegularNo) {
		return sqlSession.selectOne("paymentRegular.regularFind",paymentRegularNo);
	}

	@Override
	public void cancel(PaymentRegularDto paymentRegularDto) {
		sqlSession.update("paymentRegular.regularCancel",paymentRegularDto);
	}
	
	@Override
	public void cancelDetail(int regularDetailNo) {
		sqlSession.update("paymentRegular.regularCancelDetail",regularDetailNo);
	}

	@Override
	public void cancelDetailGroup(int regularDetailOrigin) {
		sqlSession.update("paymentRegular.regularCancelDetailGroup",regularDetailOrigin);
	}
	@Override
	public List<PaymentRegularListVO> selectTotalListByMember(String paymentRegularMember) {
		return sqlSession.selectList("paymentRegular.regularListAll",paymentRegularMember);
	}

	@Override
	public void updatePaymentRegularTime() {
		sqlSession.update("paymentRegular.scheduler");
	}

	@Override
	public void updateTid(int paymentRegularNo) {
		sqlSession.update("paymentRegular.updateTid");
		
	}
}
