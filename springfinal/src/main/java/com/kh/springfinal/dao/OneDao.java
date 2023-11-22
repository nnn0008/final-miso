package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.OneDto;
import com.kh.springfinal.vo.PaginationVO;

public interface OneDao {
	int sequence();
	public void insert(OneDto oneDto);
	boolean delete(int oneNo);
	List<OneDto>selectList();
	OneDto selectOne(int oneNo);
	boolean update(OneDto oneDto);

	
	//페이지네이션
	List<OneDto> selectListByPage(PaginationVO vo);//페이지네이션
	int countList(PaginationVO vo);//페이지네이션 카운트
	
	
	//이미지
	void connect(int oneNo,int attachNo);
	boolean deleteImage(int oneNo);
	Integer findImage(int oneNo);
	
	
	
	
	

	


	
}
