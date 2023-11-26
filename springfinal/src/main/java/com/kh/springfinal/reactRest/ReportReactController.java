package com.kh.springfinal.reactRest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ReportDao;
import com.kh.springfinal.dto.ReportDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin(value = {"http://localhost:3000", "http://localhost:5500"})
@RestController
@RequestMapping("/rest/report")
public class ReportReactController {
	@Autowired
	private ReportDao reportDao;
	
	@GetMapping("/")
	public List<ReportDto> selectList() {
		List<ReportDto> list = reportDao.selectList();
		return list;
	}
}
