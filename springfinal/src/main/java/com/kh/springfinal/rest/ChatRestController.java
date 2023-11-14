package com.kh.springfinal.rest;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.configuration.FileUploadProperties;
import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.MemberDto;

@CrossOrigin
@RestController
public class ChatRestController {
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@Autowired
	private AttachDao attachDao;
	
    // 초기 디렉터리 설정
    @Autowired
    private FileUploadProperties props;

    private File dir;

    @PostConstruct
    public void init() {
        dir = new File(props.getHome());
        dir.mkdirs();
    }
	
	 @GetMapping("/getProfile")
	    public List<MemberDto> getProfile() {
		 	return chatRoomDao.selectMemberProfile();
	    }

	 @GetMapping("/download")
	 public ResponseEntity<ByteArrayResource> download(
			 @RequestParam int attachNo
			 ) throws IOException{
		 
		 AttachDto attachDto = attachDao.selectOne(attachNo); 
		 
		 File target = new File(dir, String.valueOf(attachNo));
		 if(!target.exists()) return ResponseEntity.notFound().build();
		 
		 byte[] data = FileUtils.readFileToByteArray(target); //실제 파일 정보 불러오기
		 ByteArrayResource resource = new ByteArrayResource(data);
		 
		 return ResponseEntity.ok()
					.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
					.contentLength(attachDto.getAttachSize())
					.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
					.header(HttpHeaders.CONTENT_DISPOSITION, 
					ContentDisposition.attachment().
					filename(attachDto.getAttachName(), StandardCharsets.UTF_8)
					.build().toString()
					)
					.body(resource);
					}
			 
	 }

