package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.vo.WishlistVO;

public interface WishlistDao {
	
	void insert(String memberId, int clubNo);
	boolean delete(String memberId,int clubNo);
	boolean doLike(String memberId,int clubNo);
	List<WishlistVO> selectListForHome(String memberId);
}
