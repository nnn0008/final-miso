package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.PaymentDetailDto;
import com.kh.springfinal.dto.PaymentDto;
import com.kh.springfinal.vo.PaymentListVO;

@Repository
public class PaymentDaoImpl implements PaymentDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("payment.sequence");
	}

	@Override
	public void insert(PaymentDto paymentDto) {
		sqlSession.insert("payment.insert",paymentDto);
	}
	@Override
	public void insertDetail(PaymentDetailDto paymentDetailDto) {
		sqlSession.insert("payment.insertDetail",paymentDetailDto);
	}
	@Override
	public List<PaymentDto> selectList() {
		return sqlSession.selectList("payment.list");
	}
	@Override
	public List<PaymentListVO> selectTotalList() {
		return sqlSession.selectList("payment.listAll");
	}
	@Override
	public PaymentDetailDto selectDetail(int paymentDetailNo) {
		return sqlSession.selectOne("payment.selectDetail",paymentDetailNo);
	}

	@Override
	public PaymentDto selectOne(int paymentNo) {
		return sqlSession.selectOne("payment.find",paymentNo);
	}
	@Override
	public void cancel(PaymentDto paymentDto) {
		sqlSession.update("payment.cancel",paymentDto);
	}
	@Override
	public void cancelDetail(int paymentDetailNo) {
		sqlSession.update("payment.cancelDetail",paymentDetailNo);
	}

	@Override
	public void cancelDetailGroup(int paymentDetailOrigin) {
		sqlSession.update("payment.cancelDetailGroup",paymentDetailOrigin);
	}
	@Override
	public List<PaymentListVO> selectTotalListByMember(String paymentMember) {
		return sqlSession.selectList("payment.listAll",paymentMember);
	}
	
	@Override
	public void updateMemberLevel(PaymentDto paymentDto) {
		sqlSession.update("payment.schedulerMember",paymentDto);
	}
	
	@Override
	public void updateClubPremium(PaymentDto paymentDto) {
		sqlSession.update("payment.schedulerPremium",paymentDto);
	}

}
