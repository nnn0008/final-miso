package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.vo.ClubImageVO;
import com.kh.springfinal.vo.ClubListVO;
import com.kh.springfinal.vo.MemberPreferInfoVO;
import com.kh.springfinal.vo.PaginationVO;

public interface ClubDao {
	
	int sequence();
	void insert(ClubDto clubDto);
	List<ClubDto> list();
	ClubDto selectOne(String memberId);
	ClubImageVO clubDetail(int clubNo);
	boolean edit(ClubDto clubDto);
	void connect(int clubNo, int attachNo);
	AttachDto findImage(int clubNo);
//	List<ClubListVO> clubList(String memberId); 페이지네이션 안 함
	List<ClubListVO> clubListPage(PaginationVO vo);	//함
	int preferCount (PaginationVO vo);
	
	List<ClubListVO> majorClubList(String memberId, int majorCategoryNo);
	List<ClubListVO> majorClubListPage(PaginationVO vo);
	
	List<ClubListVO> minorClubList(String memberId, int minorCategoryNo);
	List<ClubListVO> minorClubListPage(PaginationVO vo);
	
	List<ClubListVO> clubSearchPageList(PaginationVO vo);
	int searchCount(PaginationVO vo); 
	
	List<MemberPreferInfoVO> memberPreferInfo(String memberId);
	
}
