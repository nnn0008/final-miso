package com.kh.springfinal.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springfinal.dto.ProductDto;

@Repository
public class ProductDaoImpl implements ProductDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ProductDto> selectList() {
		return sqlSession.selectList("product.list");
	}

	@Override
	public ProductDto selectOne(int productNo) {
		return sqlSession.selectOne("product.find",productNo);
	}

}
