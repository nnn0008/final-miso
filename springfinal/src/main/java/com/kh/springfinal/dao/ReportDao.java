package com.kh.springfinal.dao;

import java.util.List;

import com.kh.springfinal.dto.ReportDto;

public interface ReportDao {
	void insert(ReportDto reportDto);
	List<ReportDto> selectList();
	boolean delete(int reportNo);
}
