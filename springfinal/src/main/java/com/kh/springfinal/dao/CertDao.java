package com.kh.springfinal.dao;

import com.kh.springfinal.dto.CertDto;

public interface CertDao {
	void insert(CertDto certDto);
	boolean delete(String certEmail);
	CertDto selectOne(String certEmail);
}
