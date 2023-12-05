package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dto.NotifyDto;
import com.kh.springfinal.vo.NotifyVO;

@Repository
public class NotifyDaoImpl implements NotifyDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("notify.sequence");
	}
	
	@Override
	public void insert(NotifyDto notifyDto) {
		sqlSession.insert("notify.add", notifyDto);
	}

	@Override
	public List<NotifyDto> list(@RequestParam String notifyReceiver) {
		return sqlSession.selectList("notify.notifyList", notifyReceiver);
	}
	
	@Override
	public boolean delete(int notifyNo) {
		return sqlSession.delete("notify.del", notifyNo) > 0;
	}
	
	@Override
	public boolean notifyEnabledOff(@RequestParam String notifyReceiver) {
		return sqlSession.update("notify.notifyEnabledOff", notifyReceiver) > 0;
	}
	
	@Override
	public boolean notifyEnabledOn(@RequestParam String notifyReceiver) {
		return sqlSession.update("notify.notifyEnabledOn", notifyReceiver) > 0;
	}
	
	 @Override
	    public boolean isNotificationEnabled(@RequestParam String notifyReceiver) {
	        Boolean result = sqlSession.selectOne("notify.isNotificationEnabled", notifyReceiver);
	        return result != null && result.booleanValue();
	    }

	 
}
