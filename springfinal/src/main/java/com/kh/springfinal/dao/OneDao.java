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

	
	
	List<OneDto> searchMember(String oneMember);
	List<OneDto> searchTitle(String oneTitle);
	


	
}
