package com.kh.springfinal.rest;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.configuration.FileUploadProperties;
import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.OneDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.OneDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/one")
public class OneRestController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private OneDao oneDao;
	
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	@PostMapping("/upload")
	public Map<String, Object> upload(@RequestParam MultipartFile attach, OneDto oneDto) throws IllegalStateException, IOException{
		
		int attachNo = attachDao.sequence();
		
		
		File target = new File(dir, String.valueOf(attachNo));//저장할파일
		attach.transferTo(target);
		
		
		AttachDto attachDto = new AttachDto();
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(attach.getOriginalFilename());
		attachDto.setAttachSize(attach.getSize());
		attachDto.setAttachType(attach.getContentType());
		attachDao.insert(attachDto);
		
		int oneNo = oneDto.getOneNo();
		oneDao.deleteImage(oneNo);//제거
		oneDao.connect(oneNo, attachNo);//연결
		
		return Map.of("attachNo",attachNo);
	}
	
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> download(@RequestParam int attachNo) throws IOException{
		AttachDto attachDto = attachDao.selectOne(attachNo);
		
		if(attachDto == null) {
			return ResponseEntity.notFound().build();//404 반환
		}
		
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target);//실제 파일정보 불러오기
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING,StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize())
				.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
				.header(HttpHeaders.CONTENT_DISPOSITION,
						ContentDisposition.attachment().filename(attachDto.getAttachName(),StandardCharsets.UTF_8).build().toString()
						)
				.body(resource);
	}
	
	@PostMapping("/delete")
		public void delete(OneDto oneDto) {
		int oneNo = oneDto.getOneNo();
		oneDao.deleteImage(oneNo);
	}

}
