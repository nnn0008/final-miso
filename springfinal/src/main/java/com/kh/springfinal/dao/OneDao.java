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

	
	//검색
	List<OneDto> searchMember(String oneMember);
	List<OneDto> searchTitle(String oneTitle);
	
	List<OneDto> selectListByPage(PaginationVO vo);//페이지네이션
	int countList(PaginationVO vo);//페이지네이션 카운트
	
	List<OneDto> selectByOneMember(String oneMember);//회원으로 제목찾기;
	List<OneDto> selectByOneTitle(String oneTitle);//제목으로 글찾기;
	

	


	
}
