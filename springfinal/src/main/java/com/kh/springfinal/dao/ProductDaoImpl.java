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
	public List<ProductDto> selectSingleProductList() {
		return sqlSession.selectList("product.singleList");
	}
	
	@Override
	public List<ProductDto> selectSingleProductList2() {
		return sqlSession.selectList("product.singleList2");
	}
	
	@Override
	public List<ProductDto> selectRegularProductList() {
		return sqlSession.selectList("product.regularList");
	}
	
	@Override
	public List<ProductDto> selectRegularProductList2() {
		return sqlSession.selectList("product.regularList2");
	}

	@Override
	public ProductDto selectOne(int productNo) {
		return sqlSession.selectOne("product.find",productNo);
	}


}
