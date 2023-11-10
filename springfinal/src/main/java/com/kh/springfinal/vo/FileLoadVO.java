package com.kh.springfinal.vo;

import java.io.File;
import java.io.IOException;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.configuration.FileUploadProperties;
import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ClubBoardImage2Dto;
import com.kh.springfinal.dto.ClubBoardImage3Dto;
import com.kh.springfinal.dto.ClubBoardImageDto;

@Component
public class FileLoadVO {
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}
	
	public void upload(ClubBoardImageDto clubBoardImageDto, ClubBoardImage2Dto clubBoardImage2Dto, ClubBoardImage3Dto clubBoardImage3Dto, 
			int clubBoardNo, MultipartFile attach, MultipartFile attachSecond, MultipartFile attachThird) throws IllegalStateException, IOException {
		//파일이 있다면 실행시켜주는 메소드
		int attachNo = attachDao.sequence();
		clubBoardImageDto.setAttachNo(attachNo);
		clubBoardImageDto.setClubBoardNo(clubBoardNo);
		
		File target = new File(dir, String.valueOf(attachNo));
		attach.transferTo(target);
		
		AttachDto attachDto = new AttachDto();
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(attach.getOriginalFilename());
		attachDto.setAttachSize(attach.getSize());
		attachDto.setAttachType(attach.getContentType());
		attachDao.insert(attachDto);
		
		if(!attachSecond.isEmpty()) {
			int attachSecondNo = attachDao.sequence();
			clubBoardImage2Dto.setAttachNo(attachSecondNo);
			clubBoardImage2Dto.setClubBoardNo(clubBoardNo);
			
			File targetSecond = new File(dir, String.valueOf(attachSecondNo));
			attachSecond.transferTo(targetSecond);
			
			AttachDto attachSecondDto = new AttachDto();
			attachSecondDto.setAttachNo(attachSecondNo);
			attachSecondDto.setAttachName(attachSecond.getOriginalFilename());
			attachSecondDto.setAttachSize(attachSecond.getSize());
			attachSecondDto.setAttachType(attachSecond.getContentType());
			attachDao.insert(attachSecondDto);
			
			if(!attachThird.isEmpty()) {
				int attachThirdNo = attachDao.sequence();
				clubBoardImage3Dto.setAttachNo(attachThirdNo);
				clubBoardImage3Dto.setClubBoardNo(clubBoardNo);
				
				File targetThird = new File(dir, String.valueOf(attachThirdNo));
				attachThird.transferTo(targetThird);
				
				AttachDto attachThirdDto = new AttachDto();
				attachThirdDto.setAttachNo(attachThirdNo);
				attachThirdDto.setAttachName(attachThird.getOriginalFilename());
				attachThirdDto.setAttachSize(attachThird.getSize());
				attachThirdDto.setAttachType(attachThird.getContentType());
				attachDao.insert(attachThirdDto);
			}
		}
	}
}
