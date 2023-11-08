package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.OneDto;
import com.kh.springfinal.vo.PaginationVO;

public interface OneDao {
	public void insert(OneDto oneDto);
	public void delete(int oneNo);
	public List<OneDto> lsit();
	OneDto selectOne(int oneNo);
	public void update(OneDto oneDto);

	
	
	List<OneDto> searchMember(String oneMember);
	List<OneDto> searchTitle(String oneTitle);
	
	int countList(PaginationVO vo);
	
//	List<OneDto> selectListByPage(PaginationVO vo);

	
}
