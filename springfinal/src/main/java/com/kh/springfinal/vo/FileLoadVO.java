package com.kh.springfinal.vo;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import javax.annotation.PostConstruct;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.configuration.FileUploadProperties;
import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ClubBoardImage2Dao;
import com.kh.springfinal.dao.ClubBoardImage3Dao;
import com.kh.springfinal.dao.ClubBoardImageDao;
import com.kh.springfinal.dao.MeetingImageDao;
import com.kh.springfinal.dao.PhotoImageDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ClubBoardImage2Dto;
import com.kh.springfinal.dto.ClubBoardImage3Dto;
import com.kh.springfinal.dto.ClubBoardImageDto;
import com.kh.springfinal.dto.MeetingImageDto;
import com.kh.springfinal.dto.PhotoImageDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Component
public class FileLoadVO {
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private ClubBoardImageDao clubBoardImageDao;
	
	@Autowired
	private ClubBoardImage2Dao clubBoard2ImageDao;
	
	@Autowired
	private ClubBoardImage3Dao clubBoard3ImageDao;
	
	@Autowired
	private MeetingImageDao meetingImageDao;
	
	@Autowired
	private PhotoImageDao photoImageDao;
	
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(props.getHome()).getAbsoluteFile();
		dir.mkdirs();
	}
	
	//동호회 게시글 insert시
	public void upload(ClubBoardImageDto clubBoardImageDto, ClubBoardImage2Dto clubBoardImage2Dto, ClubBoardImage3Dto clubBoardImage3Dto, 
			int clubBoardNo, MultipartFile attach, MultipartFile attachSecond, MultipartFile attachThird) throws IllegalStateException, IOException {
		//파일이 있다면 실행시켜주는 메소드
		if(!attach.isEmpty()) {
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
			clubBoardImageDao.insert(clubBoardImageDto);		
		}
		
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
			clubBoard2ImageDao.insert(clubBoardImage2Dto);
		}
		
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
			clubBoard3ImageDao.insert(clubBoardImage3Dto);
		}

	}
	//동호회 게시글 에딧시에
	public void delete(ClubBoardImageDto dto, MultipartFile multipartFile, int clubBoardNo) throws IllegalStateException, IOException {
		if(dto != null) {
			AttachDto attachDto = attachDao.selectOne(dto.getAttachNo());
			if(attachDto != null) {
				attachDao.delete(dto.getAttachNo());
				
				File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
				target.delete();
			}
			
			int attachNo = attachDao.sequence();
			File insertTarget = new File(dir, String.valueOf(attachNo));
			multipartFile.transferTo(insertTarget);
			
			AttachDto insertDto = new AttachDto();
			insertDto.setAttachNo(attachNo);
			insertDto.setAttachName(multipartFile.getOriginalFilename());
			insertDto.setAttachSize(multipartFile.getSize());
			insertDto.setAttachType(multipartFile.getContentType());
			attachDao.insert(insertDto);
			
			dto.setAttachNo(attachNo);
			clubBoardImageDao.insert(dto);
		}
		else { //최초에 등록한 dto가 없다 = 처음에는 이미지를 등록하지 않았다
			int attachNo = attachDao.sequence();
			File insertTarget = new File(dir, String.valueOf(attachNo));
			multipartFile.transferTo(insertTarget);
			
			AttachDto insertDto = new AttachDto();
			insertDto.setAttachNo(attachNo);
			insertDto.setAttachName(multipartFile.getOriginalFilename());
			insertDto.setAttachSize(multipartFile.getSize());
			insertDto.setAttachType(multipartFile.getContentType());
			attachDao.insert(insertDto);
			
			ClubBoardImageDto newDto = new ClubBoardImageDto();
			newDto.setAttachNo(attachNo);
			newDto.setClubBoardNo(clubBoardNo);
			clubBoardImageDao.insert(newDto);
		}
	}
	public void delete2(ClubBoardImage2Dto dto, MultipartFile multipartFile, int clubBoardNo) throws IllegalStateException, IOException {
		if(dto != null) {
			AttachDto attachDto = attachDao.selectOne(dto.getAttachNo());
			if(attachDto != null) {
				attachDao.delete(dto.getAttachNo());
				
				File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
				target.delete();
			}
			
			int attachNo = attachDao.sequence();
			File insertTarget = new File(dir, String.valueOf(attachNo));
			multipartFile.transferTo(insertTarget);
			
			AttachDto insertDto = new AttachDto();
			insertDto.setAttachNo(attachNo);
			insertDto.setAttachName(multipartFile.getOriginalFilename());
			insertDto.setAttachSize(multipartFile.getSize());
			insertDto.setAttachType(multipartFile.getContentType());
			attachDao.insert(insertDto);
			
			dto.setAttachNo(attachNo);
			clubBoard2ImageDao.insert(dto);	
		}
		else {
			int attachNo = attachDao.sequence();
			File insertTarget = new File(dir, String.valueOf(attachNo));
			multipartFile.transferTo(insertTarget);
			
			AttachDto insertDto = new AttachDto();
			insertDto.setAttachNo(attachNo);
			insertDto.setAttachName(multipartFile.getOriginalFilename());
			insertDto.setAttachSize(multipartFile.getSize());
			insertDto.setAttachType(multipartFile.getContentType());
			attachDao.insert(insertDto);
			
			ClubBoardImage2Dto newDto = new ClubBoardImage2Dto();
			newDto.setAttachNo(attachNo);
			newDto.setClubBoardNo(clubBoardNo);
			clubBoard2ImageDao.insert(newDto);
		}
	}
	public void delete3(ClubBoardImage3Dto dto, MultipartFile multipartFile, int clubBoardNo) throws IllegalStateException, IOException {
		if(dto != null) {
			AttachDto attachDto = attachDao.selectOne(dto.getAttachNo());
			if(attachDto != null) {
				attachDao.delete(dto.getAttachNo());
				
				File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
				target.delete();
			}
			
			int attachNo = attachDao.sequence();
			File insertTarget = new File(dir, String.valueOf(attachNo));
			multipartFile.transferTo(insertTarget);
			
			AttachDto insertDto = new AttachDto();
			insertDto.setAttachNo(attachNo);
			insertDto.setAttachName(multipartFile.getOriginalFilename());
			insertDto.setAttachSize(multipartFile.getSize());
			insertDto.setAttachType(multipartFile.getContentType());
			attachDao.insert(insertDto);
			
			dto.setAttachNo(attachNo);
			clubBoard3ImageDao.insert(dto);
		}
		else {
			int attachNo = attachDao.sequence();
			File insertTarget = new File(dir, String.valueOf(attachNo));
			multipartFile.transferTo(insertTarget);
			
			AttachDto insertDto = new AttachDto();
			insertDto.setAttachNo(attachNo);
			insertDto.setAttachName(multipartFile.getOriginalFilename());
			insertDto.setAttachSize(multipartFile.getSize());
			insertDto.setAttachType(multipartFile.getContentType());
			attachDao.insert(insertDto);
			
			ClubBoardImage3Dto newDto = new ClubBoardImage3Dto();
			newDto.setAttachNo(attachNo);
			newDto.setClubBoardNo(clubBoardNo);
			clubBoard3ImageDao.insert(newDto);
		}
	}
	
	//파일 다운로드 관련처리
	public ResponseEntity<ByteArrayResource> download(int attachNo) throws IOException{
		AttachDto attachDto = attachDao.selectOne(attachNo);
		
		if(attachDto == null) {
			//throw new NoTargetException("파일 없음");//내가만든 예외로 통합
			return ResponseEntity.notFound().build();//404 반환
		}
		
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
		
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize())
				.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
				.header(HttpHeaders.CONTENT_DISPOSITION, 
					ContentDisposition.attachment()
					.filename(attachDto.getAttachName(), StandardCharsets.UTF_8)
					.build().toString()
				)
			.body(resource);
	}

	/////////////////////////////////////////////////////////////////////////////////
	//MeetingRestController
	//정모 게시글 insert 시
	public void meetingUpload (MultipartFile meetingImage, int meetingNo) throws IllegalStateException, IOException {	
		
		AttachDto attachDto = new AttachDto();
		int attachNo = attachDao.sequence();
		
		File target = new File(dir, String.valueOf(attachNo));
		meetingImage.transferTo(target);
		
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(meetingImage.getOriginalFilename());
		attachDto.setAttachSize(meetingImage.getSize());
		attachDto.setAttachType(meetingImage.getContentType());
		
		
		
		//log.debug("attachNo = {}", attachNo);
		attachDao.insert(attachDto);
		meetingImageDao.insert(attachNo,meetingNo);
		
	}
	
	//////////////////////////////////////////////
	//사진게시판 insert시
	public void photoUpload(MultipartFile multipartFile, int photoNo) throws IllegalStateException, IOException {
		AttachDto attachDto = new AttachDto();
		int attachNo = attachDao.sequence();
		
		File target = new File(dir, String.valueOf(attachNo));
		multipartFile.transferTo(target);
		
		attachDto.setAttachNo(attachNo);
		attachDto.setAttachName(multipartFile.getOriginalFilename());
		attachDto.setAttachSize(multipartFile.getSize());
		attachDto.setAttachType(multipartFile.getContentType());
		
		PhotoImageDto photoImageDto = new PhotoImageDto();
		
		photoImageDto.setAttachNo(attachNo);
		photoImageDto.setPhotoNo(photoNo);
		//log.debug("attachNo={}", attachNo);
		//log.debug("photoNo={}", photoNo);
		attachDao.insert(attachDto);
		photoImageDao.insert(photoImageDto);
	}
	
	//사진 게시판 List
	
	
	
}