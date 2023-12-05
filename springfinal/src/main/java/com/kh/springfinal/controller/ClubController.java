package com.kh.springfinal.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
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

import com.kh.springfinal.configuration.FileUploadProperties;
import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.CategoryDao;
import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.MeetingDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dao.PhotoDao;
import com.kh.springfinal.dao.ZipCodeDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ChatRoomDto;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.dto.MeetingDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.dto.MinorCategoryDto;
import com.kh.springfinal.dto.PhotoDto;
import com.kh.springfinal.dto.ZipCodeDto;
import com.kh.springfinal.vo.ClubDetailBoardListVO;
import com.kh.springfinal.vo.ClubImageVO;
import com.kh.springfinal.vo.ClubListVO;
import com.kh.springfinal.vo.MemberPreferInfoVO;
import com.kh.springfinal.vo.PaginationVO;

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
	
	@Autowired
	private MeetingDao meetingDao;
	
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@Autowired
	private PhotoDao photoDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}
	
	
	
	@GetMapping("/insert")
	public String insert(Model model,HttpSession session) {
		String memberId = (String) session.getAttribute("name");
		
		List<MajorCategoryDto> majorList = categoryDao.majorcategoryList();
//		List<ZipCodeDto> zipList = zipDao.list();
		
		model.addAttribute("majorCategory",majorList);
//		model.addAttribute("zipList",zipList);
		
		
		 
		MemberDto memberDto = memberDao.loginId(memberId);
		int memberClubCount = clubMemberDao.memberJoinClubCount(memberId);
		
		log.debug("memberMakeClubCount={}",memberClubCount);
		
		if(memberDto.getMemberLevel().equals("일반유저")) {
			
			if(memberClubCount>=5) {
				
				return "redirect:/pay/product";
				
			}
			
			else {
				
				
				
				return "club/insert";
			}
		}
		else {
			
			return "club/insert";
		}
		 
		
		
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute ClubDto clubDto,
			HttpSession session) {
		
	
		String memberId = (String) session.getAttribute("name");	
		
		
		
		
		ClubMemberDto clubMemberDto = new ClubMemberDto();
		ChatRoomDto chatRoomDto = new ChatRoomDto();
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
		
		
		clubDao.insert(clubDto);
		clubMemberDao.insert(clubMemberDto);
		
		

		return "redirect:/club/detail?clubNo="+clubNo;
		
	}
	@RequestMapping("/detail")
	public String detail(@RequestParam int clubNo,
			Model model,HttpSession session) throws ParseException {
		
		String memberId = (String) session.getAttribute("name");
		ClubImageVO clubDto = clubDao.clubDetail(clubNo);
		MajorCategoryDto major = categoryDao.findMajor(clubDto.getClubCategory());
		ZipCodeDto zipDto = zipDao.findZip(clubNo);
		List<ClubDetailBoardListVO> clubDetailBoardList  = clubBoardDao.clubDetailBoardList(clubNo);
		
		
		List<PhotoDto> photoList = photoDao.selectList(clubNo);
		
		int clubMemberNo = clubMemberDao.findClubMemberNo(clubNo, memberId);
		
		
		
		boolean joinButton = !clubMemberDao.existMember(clubNo, memberId) && (memberId!=null);
		boolean editPossible = clubMemberDao.editPossible(clubNo, memberId);
		
//		List<ClubMemberVO> clubMemberList = clubMemberDao.memberInfo(clubNo);
		
		
//		SimpleDateFormat joinDateFormat = new SimpleDateFormat("yyyy-MM-dd");
//		for(ClubMemberVO dto : clubMemberList) {
//			
//		String date = joinDateFormat.format(dto.getJoinDate());
//			
//		dto.setJoinDateString(date);
//		}
		
		int meetingCount = meetingDao.count(clubNo);
		
		
		int memberCount = clubMemberDao.memberCount(clubNo);
		List<MeetingDto> meetingList = meetingDao.selectList(clubNo);
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd E a hh:mm:ss");
		for(MeetingDto dto : meetingList) {
			//스트링 날짜 설정
		 	Date date = dto.getMeetingDate();
	        String formattedDate = dateFormat.format(date);
	        dto.setDateString(formattedDate); 
	        
	        int dday = (int) dto.getDday();
	        
	        
	        dto.setDday(dday);
	        
	        //디데이 설정
	        
	        
		
			}


			
			
		
		
		
		
		model.addAttribute("memberCount",memberCount);
		model.addAttribute("editPossible",editPossible);
//		model.addAttribute("clubMemberDto",clubMemberList);
		model.addAttribute("clubDto",clubDto);
		model.addAttribute("major",major);
		model.addAttribute("zipDto",zipDto);
		model.addAttribute("joinButton",joinButton);
		model.addAttribute("meetingList",meetingList);
		model.addAttribute("photoList",photoList);
		model.addAttribute("meetingCount",meetingCount);
		
		
		model.addAttribute("clubMemberNo",clubMemberNo);
		
		model.addAttribute("clubDetailBoardList",clubDetailBoardList);
		

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
		//현재 회원이 고른 majorCategory
		
		
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
		
		@RequestMapping("/list")
		public String list(HttpSession session,Model model) {
			
			String memberId = (String) session.getAttribute("name");
			
			List<MajorCategoryDto> categoryList = categoryDao.majorcategoryList();
			List<MemberPreferInfoVO> memberPreferList = clubDao.memberPreferInfo(memberId); 
			
			model.addAttribute("categoryList",categoryList);
			model.addAttribute("memberPreferList",memberPreferList);
			
			
			return "club/list";
		}
		
		@RequestMapping("/list2")
		public String list2(HttpSession session,Model model, @RequestParam int majorCategoryNo) {
			
			List<MinorCategoryDto> categoryList = 
					categoryDao.minorCategoryList(majorCategoryNo);
			
			String memberId = (String) session.getAttribute("name");
			
			List<ClubListVO> clubList = clubDao.majorClubList(memberId,majorCategoryNo);
			
			String majorName = categoryDao.majorName(majorCategoryNo);
			
			
			model.addAttribute("clubList",clubList);
			model.addAttribute("categoryList",categoryList);
			model.addAttribute("majorName",majorName);
			
			
			return "club/list2";
			
			
			
		}
		
		@RequestMapping("/list3")
		public String list3(HttpSession session,Model model, @RequestParam int minorCategoryNo,
				@RequestParam(required=false) int majorCategoryNo) {
			
			List<MinorCategoryDto> categoryList = 
					categoryDao.minorCategoryList(majorCategoryNo);
			
			/*
			 * List<MinorCategoryDto> minorCategoryList =
			 * categoryDao.minorCategoryList(majorCategoryNo);
			 */
			
			String memberId = (String) session.getAttribute("name");
			
			List<ClubListVO> clubList = clubDao.minorClubList(memberId,minorCategoryNo);
			String minorName = categoryDao.minorName(minorCategoryNo);
			
			
			model.addAttribute("clubList",clubList);
			model.addAttribute("categoryList",categoryList);
			model.addAttribute("minorName",minorName);
			
			return "club/list3";
			
			
			
		}
		
		@GetMapping("/searchList")
		public String searchList(@RequestParam String keyword,HttpSession session,
				@ModelAttribute(name ="vo") PaginationVO vo,
				Model model) {
			
			String memberId = (String) session.getAttribute("name");
			vo.setWhereString(memberId);
			int count=clubDao.searchCount(vo);
			
			
			model.addAttribute("count",count);
			
			return "club/clubSearchList";
		}
		
		
		@GetMapping("/deleteClubMember")
		public String deleteClubMember(@RequestParam int clubMemberNo,@RequestParam int clubNo) {
			
			boolean deleteMemberLevel = clubMemberDao.isManeger(clubMemberNo);
			
			clubMemberDao.deleteClubMember(clubMemberNo);
			
			int count = clubMemberDao.memberCount(clubNo);
			
			if(count<=0) {
				
				clubDao.deleteClub(clubNo);
				
			}
			else {
				
				if(deleteMemberLevel) {
					
			boolean managerExist = clubMemberDao.managerExist(clubNo);	
				if(!managerExist) {
					
					List<ClubMemberDto> list = clubMemberDao.memberList(clubNo);
					
					clubMemberDao.upgradeRank(list.get(0).getClubMemberNo());
					
					
				}
				}
			}
			
			
			
			return "redirect:/club/list";
			
			
		}
			
		
			
			
		
		
		
		
	
	
	
	
	
	

}
