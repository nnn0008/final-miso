package com.kh.springfinal.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.CategoryDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.ZipCodeDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.dto.ZipCodeDto;
import com.kh.springfinal.vo.ClubImageVO;
import com.kh.springfinal.vo.ClubMemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/club")
public class ClubController {
	
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private ZipCodeDao zipDao;
	
	@Autowired
	private ChatRoomDao chatRoomDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	
	
	@GetMapping("/insert")
	public String insert(Model model) {
		
		
		List<MajorCategoryDto> majorList = categoryDao.majorcategoryList();
//		List<ZipCodeDto> zipList = zipDao.list();
		
		model.addAttribute("majorCategory",majorList);
//		model.addAttribute("zipList",zipList);
		 
		return "club/insert";
		
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute ClubDto clubDto,
			HttpSession session) {
		
		
		
//		String memberId = (String) session.getAttribute("name");	//session 생긴 후 풀 주석
		
		ClubMemberDto clubMemberDto = new ClubMemberDto();
		ChatRoomDto chatRoomDto = new ChatRoomDto();
		String memberId = (String) session.getAttribute("name");
		int clubNo = clubDao.sequence();
		int chatRoomNo = chatRoomDao.sequence();
		int clubMemberNo = clubMemberDao.sequence();
		
		chatRoomDto.setChatRoomNo(chatRoomNo);
		chatRoomDao.insert(chatRoomDto);

		clubDto.setChatRoomNo(chatRoomNo);
		clubDto.setClubNo(clubNo);
		clubDto.setClubOwner(memberId);
		
		clubMemberDto.setClubMemberNo(clubMemberNo);
		clubMemberDto.setClubNo(clubNo);
		clubMemberDto.setClubMemberId(memberId);
		clubMemberDto.setClubMemberRank("운영진");
		clubMemberDto.setJoinMessage("환영합니다.");
		
		log.debug("clubDto={}",clubDto);
		
		clubDao.insert(clubDto);
		clubMemberDao.insert(clubMemberDto);
		
		

		return "redirect:/";
		
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int clubNo,
			Model model,HttpSession session) {
		
		String memberId = (String) session.getAttribute("name");
		ClubImageVO clubDto = clubDao.clubDetail(clubNo);
		MajorCategoryDto major = categoryDao.findMajor(clubDto.getClubCategory());
		ZipCodeDto zipDto = zipDao.findZip(clubNo);
		
		boolean joinButton = !clubMemberDao.existMember(clubNo, memberId);
		
		List<ClubMemberVO> clubMemberList = clubMemberDao.memberInfo(clubNo);
		
		
		model.addAttribute("clubMemberDto",clubMemberList);
		model.addAttribute("clubDto",clubDto);
		model.addAttribute("major",major);
		model.addAttribute("zipDto",zipDto);
		model.addAttribute("joinButton",joinButton);
		

		return "club/detail";
		
	}
	
	
	@GetMapping("/edit")
	public String update(@RequestParam int clubNo,
			Model model) {
		
		List<MajorCategoryDto> majorList = categoryDao.majorcategoryList();
		
	
		
		ClubImageVO clubDto = clubDao.clubDetail(clubNo);
		
		ZipCodeDto zipCodeDto = zipDao.findZip(clubNo);
		
		log.debug("zipCodeDto={}",zipCodeDto);
		
		
		int minorNo = clubDto.getClubCategory();
		MajorCategoryDto majorCategoryDto = categoryDao.findMajor(minorNo);
		
		
		model.addAttribute("majorList",majorList);
		model.addAttribute("majorDto",majorCategoryDto);
		model.addAttribute("clubDto",clubDto);
		model.addAttribute("zipDto",zipCodeDto);
		
		
		
		
	
		

		return "club/edit";	
	}
	
	@PostMapping("/edit")
	public String update(ClubDto clubDto,
			@RequestParam MultipartFile attach) 
					throws IllegalStateException, IOException {
		
		clubDao.edit(clubDto);
		
		log.debug("clubDto={}",clubDto);
		
		int clubNo = clubDto.getClubNo();
		
		if(!attach.isEmpty()) {
			
			//파일이 있으면
			//파일 삭제 - 기존 파일이 있을 경우에만 처리
			AttachDto attachDto = clubDao.findImage(clubNo);
			String home = System.getProperty("user.home");
			File dir = new File(home,"upload");
			
			
			
			if(attachDto != null) {
				
				attachDao.delete(attachDto.getAttachNo());
			File target = new File(dir,String.valueOf(attachDto.getAttachNo()));
			target.delete();
			}
			
			//파일 추가 및 연결
			int attachNo = attachDao.sequence();
			
			
			File insertTarget = new File(dir,String.valueOf(attachNo));
			attach.transferTo(insertTarget);
			
			AttachDto insertDto = new AttachDto();
			insertDto.setAttachNo(attachNo);
			insertDto.setAttachName(attach.getOriginalFilename());
			insertDto.setAttachSize(attach.getSize());
			insertDto.setAttachType(attach.getContentType());
			attachDao.insert(insertDto);
			
			clubDao.connect(clubNo, attachNo);
		}

		return "redirect:detail?clubNo="+clubDto.getClubNo();
		
	}
	
	//파일 다운로드
		//-파일번호(attach_no)를 이용하여 정보를 조회
		//-실물 파일을 불러와서 사용자에게 전송
		//-화면이 아니라 파일을 전송해야 하므로 RestController처럼 처리
		//-매핑 위에 @ResponseBody라고 추가하면 가능
		@ResponseBody
		@RequestMapping("/image")
		public ResponseEntity<ByteArrayResource> 
								image(@RequestParam int clubNo) throws IOException {
			//[1] 클럽 번호로 파일 번호를 찾아야 한다
			//[2] 파일 번호로 파일 정보를 불러와야 한다
			//[3] 실제 파일을 불러와야 한다
			//[4] 앞에서 불러온 모든 정보로 ResponseEntity를 생성한다
			//[5] 사용자한테 준다
			
			//1,2
			AttachDto attachDto = clubDao.findImage(clubNo);
			
			if(attachDto == null) {
//				throw new NoTargetException("파일 없음");
				//내가 만든 예외로 통합
				
				return ResponseEntity.notFound().build();
				//404로 반환
				
			}
			
			//3
			String home = System.getProperty("user.home");
			File dir = new File(home,"upload");
			File target = new File(dir, String.valueOf(attachDto.getAttachNo()));
			
			byte[] data = FileUtils.readFileToByteArray(target);// 실제파일정보 불러오기
			ByteArrayResource resource = new ByteArrayResource(data);
			
			//4,5 - header(정보), body(내용)
			return ResponseEntity.ok()
//					.header("Content-Encoding","UTF-8")
					.header(HttpHeaders.CONTENT_ENCODING, StandardCharsets.UTF_8.name())
//					.header("Content-Length",String.valueOf(attachDto.getAttachSize()))
					.contentLength(attachDto.getAttachSize())
//					.header("Content-Type",attachDto.getAttachType())//저장된 유형
					.header(HttpHeaders.CONTENT_TYPE,attachDto.getAttachType())
//					.header("Content-Type","application/octet-stream")//무조건 다운로드
//					.contentType(MediaType.APPLICATION_OCTET_STREAM)
//					.header("Content-Disposition","attachment; filename="+attachDto.getAttachName())
					.header(HttpHeaders.CONTENT_DISPOSITION,
						ContentDisposition.attachment().filename(attachDto.getAttachName(),StandardCharsets.UTF_8)
						.build().toString()
							)
					
				.body(resource);	
		}
		
		
		
	
	
	
	
	
	

}
