package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ProductDto;

public interface ProductDao {
	
	List<ProductDto> selectSingleProductList();//단건목록
	List<ProductDto> selectSingleProductList2();//단건목록
	List<ProductDto> selectRegularProductList();//정기목록
	List<ProductDto> selectRegularProductList2();//정기목록
	ProductDto selectOne(int productNo);

}
