package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReportDto {
	private int reportNo;
	private String reportReported;
	private String reportReporter;
	private Date reportDate;
	private String reportCategory;
	private String reportType;
	private int reportLocal;
}
