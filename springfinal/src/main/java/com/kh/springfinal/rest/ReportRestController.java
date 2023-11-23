package com.kh.springfinal.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ReportDao;
import com.kh.springfinal.dto.ReportDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
@RequestMapping("/rest/report")
public class ReportRestController {
	
	@Autowired
	private ReportDao reportDao;
	
	@PostMapping("/clubBoard/insert")
	public void clubBoardInsert(@RequestParam String reportCategory, @RequestParam String reportReported,
	@RequestParam String reportReporter, @RequestParam int reportLocal, @RequestParam String reportType) {
		ReportDto reportDto = new ReportDto();
		int reportNo = reportDao.sequence();
		
		reportDto.setReportCategory(reportCategory);
		reportDto.setReportLocal(reportLocal);
		reportDto.setReportNo(reportNo);
		reportDto.setReportReported(reportReported);
		reportDto.setReportReporter(reportReporter);
		reportDto.setReportType(reportType);
		
		reportDao.insert(reportDto);
	}
	
}
