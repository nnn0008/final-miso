package com.kh.springfinal.dao;

public interface WishlistDao {
	
	void insert(String memberId, int clubNo);
	boolean delete(String memberId,int clubNo);
	boolean doLike(String memberId,int clubNo);
}
