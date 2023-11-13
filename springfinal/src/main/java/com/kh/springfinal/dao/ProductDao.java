package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ProductDto;

public interface ProductDao {
	List<ProductDto> selectList();
	ProductDto selectOne(int productNo);

}
