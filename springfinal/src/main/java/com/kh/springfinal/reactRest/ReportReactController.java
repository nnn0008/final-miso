package com.kh.springfinal.reactRest;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubBoardImage2Dao;
import com.kh.springfinal.dao.ClubBoardImage3Dao;
import com.kh.springfinal.dao.ClubBoardImageDao;
import com.kh.springfinal.dao.ReportDao;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubBoardImage2Dto;
import com.kh.springfinal.dto.ClubBoardImage3Dto;
import com.kh.springfinal.dto.ClubBoardImageDto;
import com.kh.springfinal.dto.ReportDto;
import com.kh.springfinal.vo.FileLoadVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin(value = {"http://localhost:3000", "http://localhost:5500"})
@RestController
@RequestMapping("/rest/report")
public class ReportReactController {
	@Autowired
	private ReportDao reportDao;
	
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@Autowired
	private ClubBoardImageDao boardImageDao; 
	
	@Autowired
	private ClubBoardImage2Dao boardImage2Dao;
	
	@Autowired
	private ClubBoardImage3Dao boardImage3Dao;
	
	@Autowired
	private FileLoadVO fileLoadVO;
	
	@GetMapping("/")
	public List<ReportDto> selectList() {
		List<ReportDto> list = reportDao.selectList();
		return list;
	}
	
	@GetMapping("/{reportLocal}")
	public Map<String, Object> selectOneBoard(@PathVariable int reportLocal) throws IOException {
		 Map<String, Object> result = new HashMap<>();
		ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(reportLocal);
		ClubBoardImageDto boardImageDto = boardImageDao.selectOne(reportLocal);
		ClubBoardImage2Dto boardImageDto2 = boardImage2Dao.selectOne(reportLocal);
		ClubBoardImage3Dto boardImageDto3 = boardImage3Dao.selectOne(reportLocal);
		 result.put("clubBoardDto", clubBoardDto);
		 result.put("boardImageDto", boardImageDto);
	    result.put("boardImageDto2", boardImageDto2);
	    result.put("boardImageDto3", boardImageDto3);
		return result;
	}
	
	@GetMapping("/image/{attachNo}")
	public ResponseEntity<ByteArrayResource> down(@PathVariable int attachNo) throws IOException{
		return fileLoadVO.download(attachNo);
	}
	
	@DeleteMapping("/{clubBoardNo}")
	public boolean delete(@PathVariable int clubBoardNo) {
		return reportDao.delete(clubBoardNo);
	}
	
	
	
	
}
