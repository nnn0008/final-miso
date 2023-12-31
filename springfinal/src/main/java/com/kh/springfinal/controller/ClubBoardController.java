package com.kh.springfinal.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubBoardImage2Dao;
import com.kh.springfinal.dao.ClubBoardImage3Dao;
import com.kh.springfinal.dao.ClubBoardImageDao;
import com.kh.springfinal.dao.ClubBoardLikeDao;
import com.kh.springfinal.dao.ClubBoardReplyDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dao.MemberProfileDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ClubBoardAllDto;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubBoardImage2Dto;
import com.kh.springfinal.dto.ClubBoardImage3Dto;
import com.kh.springfinal.dto.ClubBoardImageDto;
import com.kh.springfinal.dto.ClubBoardLikeDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.dto.MemberProfileDto;
import com.kh.springfinal.vo.ClubImageVO;
import com.kh.springfinal.vo.FileLoadVO;
import com.kh.springfinal.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/clubBoard")
public class ClubBoardController {
	@Autowired
	private ClubBoardDao clubBoardDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private FileLoadVO fileLoadVO;
	
	@Autowired
	private ClubBoardReplyDao clubBoardReplyDao;
	
	@Autowired
	private ClubBoardImageDao clubBoardImageDao;
	
	@Autowired
	private ClubBoardImage2Dao clubBoardImage2Dao;
	
	@Autowired
	private ClubBoardImage3Dao clubBoardImage3Dao;
	
	@Autowired
	private MemberProfileDao memberProfileDao;
	
	@Autowired
	private ClubBoardLikeDao clubBoardLikeDao;
	
	@GetMapping("/write")
	public String write(@RequestParam int clubNo, Model model) {
		model.addAttribute("clubNo", clubNo);
		return "clubBoard/write";
	}	
	
	@PostMapping("/write")
	public String write(@ModelAttribute ClubBoardDto clubBoardDto, @ModelAttribute MemberDto memberDto, @ModelAttribute ClubMemberDto clubMemberDto, 
			HttpSession session, @RequestParam int clubNo, @ModelAttribute ClubBoardImageDto clubBoardImageDto, @ModelAttribute ClubBoardImage2Dto clubBoardImage2Dto,
			@ModelAttribute ClubBoardImage3Dto clubBoardImage3Dto, @RequestParam MultipartFile attach,
			@RequestParam MultipartFile attachSecond, @RequestParam MultipartFile attachThird) throws Exception, IOException{

		String memberId = (String)session.getAttribute("name"); //회원 아이디
		memberDto = memberDao.loginId(memberId);
		memberDto.setMemberId(memberId);
		
		int clubBoardNo = clubBoardDao.sequence();
		clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
		
//		log.debug("clubNo ={}" , clubNo);
//		log.debug("memberId ={}" , memberId);
//		log.debug("clubMemberDto ={}" , clubMemberDto);
		
		int clubMemberNo = clubMemberDto.getClubMemberNo();
		
		clubBoardDto.setClubBoardName(memberDto.getMemberName());
		clubBoardDto.setClubBoardNo(clubBoardNo);
		clubBoardDto.setClubMemberNo(clubMemberNo);
		clubBoardDto.setClubNo(clubNo);
		clubBoardDao.insert(clubBoardDto);

		//사진 첨부
		if(!attach.isEmpty() || !attachSecond.isEmpty() || !attachThird.isEmpty()) {
			fileLoadVO.upload(clubBoardImageDto, clubBoardImage2Dto, clubBoardImage3Dto, clubBoardNo, attach, attachSecond, attachThird);
		}
		return "redirect:/clubBoard/detail?clubBoardNo="+clubBoardNo;
	}
	
	@RequestMapping("/list")
	public String list(Model model, @ModelAttribute("vo") PaginationVO vo, @RequestParam int clubNo) {
		int count = clubBoardDao.clubBoardCount(vo, clubNo); // 게시글의 총 게시글 수를 조회
		vo.setCount(count);
		List<ClubBoardAllDto> list = clubBoardDao.selectListByPage(vo, clubNo);
		model.addAttribute("clubNo", clubNo);
		model.addAttribute("list", list);
		
		//상단 바로가기 메뉴
		ClubImageVO clubDto = clubDao.clubDetail(clubNo);
		
		model.addAttribute("clubDto",clubDto);
		
		log.debug("list={}", list);
		log.debug("count={}", count);
		log.debug("clubNo={}", clubNo);

		return "clubBoard/list";
	}
	
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int clubBoardNo) {
		ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(clubBoardNo);
		ClubMemberDto clubMemberDto = clubMemberDao.selectOne(clubBoardDto.getClubMemberNo());
		AttachDto attachDto = memberProfileDao.profileFindOne(clubMemberDto.getClubMemberId());
		//ClubBoardLikeDto clubBoardLikeDto = clubBoardLikeDao.selectOne(clubBoardNo);
		ClubBoardImageDto clubBoardImageDto = clubBoardImageDao.selectOne(clubBoardNo);
		ClubBoardImage2Dto clubBoardImage2Dto = clubBoardImage2Dao.selectOne(clubBoardNo);
		ClubBoardImage3Dto clubBoardImage3Dto = clubBoardImage3Dao.selectOne(clubBoardNo);
		
		ClubBoardLikeDto clubBoardLikeDto = new ClubBoardLikeDto();
		clubBoardLikeDto.setClubBoardNo(clubBoardNo);
		clubBoardLikeDto.setClubMemberNo(clubBoardDto.getClubMemberNo());
		boolean isLiked = clubBoardLikeDao.check(clubBoardLikeDto);
		int likeCount = clubBoardLikeDao.count(clubBoardNo);
		clubBoardDto.setClubBoardLikecount(likeCount);
		if(clubBoardImageDto != null) model.addAttribute("clubBoardImageDto", clubBoardImageDto);
		if(clubBoardImage2Dto != null) model.addAttribute("clubBoardImage2Dto", clubBoardImage2Dto);
		if(clubBoardImage3Dto != null) model.addAttribute("clubBoardImage3Dto", clubBoardImage3Dto);
		
		MemberProfileDto memberProfileDto = memberProfileDao.selectOne(clubMemberDto.getClubMemberId());
		
		model.addAttribute("likeCount", likeCount);
		model.addAttribute("isLiked", isLiked);
		model.addAttribute("clubMemberDto", clubMemberDto);
		model.addAttribute("clubBoardDto", clubBoardDto);
		//model.addAttribute("attachDto", attachDto);
		model.addAttribute("memberProfileDto", memberProfileDto);
		//model.addAttribute("likeDto", clubBoardLikeDto);
		log.debug("memberProfileDto={}", memberProfileDto);
		return "clubBoard/detail";
	}
	
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam int clubBoardNo) {
		ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(clubBoardNo);
		ClubBoardImageDto clubBoardImageDto = clubBoardImageDao.selectOne(clubBoardNo);
		ClubBoardImage2Dto clubBoardImage2Dto = clubBoardImage2Dao.selectOne(clubBoardNo);
		ClubBoardImage3Dto clubBoardImage3Dto = clubBoardImage3Dao.selectOne(clubBoardNo);
//		log.debug("clubBoardImageDto ={}", clubBoardImageDto);
//		log.debug("clubBoardImage2Dto ={}", clubBoardImage2Dto);
//		log.debug("clubBoardImage3Dto ={}", clubBoardImage3Dto);
		model.addAttribute("clubBoardDto",clubBoardDto);
		model.addAttribute("clubBoardImageDto", clubBoardImageDto);
		model.addAttribute("clubBoardImage2Dto", clubBoardImage2Dto);
		model.addAttribute("clubBoardImage3Dto", clubBoardImage3Dto);
		return "clubBoard/edit";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute ClubBoardDto clubBoardDto, @ModelAttribute MemberDto memberDto,
			HttpSession session, @RequestParam int clubNo, @RequestParam MultipartFile attach, 
			@RequestParam MultipartFile attachSecond, @RequestParam MultipartFile attachThird) throws IllegalStateException, IOException {
//		log.debug("clubBoardDto = {}", clubBoardDto);
//		log.debug("clubBoardNo = {}", clubBoardDto.getClubBoardNo());
//		ClubBoardDto newBoardDto = clubBoardDao.selectOnes(clubBoardDto.getClubBoardNo());
		clubBoardDao.update(clubBoardDto, clubBoardDto.getClubBoardNo());
		ClubBoardImageDto clubBoardImageDto = clubBoardImageDao.selectOne(clubBoardDto.getClubBoardNo());
		ClubBoardImage2Dto clubBoardImage2Dto = clubBoardImage2Dao.selectOne(clubBoardDto.getClubBoardNo());
		ClubBoardImage3Dto clubBoardImage3Dto = clubBoardImage3Dao.selectOne(clubBoardDto.getClubBoardNo());
//		log.debug("attach ={}", attach);
//		log.debug("attachSecond ={}", attachSecond);
//		log.debug("attachThird ={}", attachThird);
//		log.debug("clubBoardImageDto ={}", clubBoardImageDto);
//		log.debug("clubBoardImage2Dto ={}", clubBoardImage2Dto);
//		log.debug("clubBoardImage3Dto ={}", clubBoardImage3Dto);
		
		if(!attach.isEmpty()) { //사진을 미리 등록해뒀거나 수정에서 추가한 경우
			fileLoadVO.delete(clubBoardImageDto, attach, clubBoardDto.getClubBoardNo());
		}
		if(!attachSecond.isEmpty()) {
			fileLoadVO.delete2(clubBoardImage2Dto, attachSecond, clubBoardDto.getClubBoardNo());
		}
		if(!attachThird.isEmpty()) {
			fileLoadVO.delete3(clubBoardImage3Dto, attachThird, clubBoardDto.getClubBoardNo());
		}
		return "redirect:/clubBoard/detail?clubBoardNo="+clubBoardDto.getClubBoardNo();
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam int clubBoardNo) {
		ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(clubBoardNo);
		boolean result = clubBoardDao.delete(clubBoardNo);
		if(result) {
			return "redirect:/clubBoard/list?clubNo="+clubBoardDto.getClubNo();
		}
		else {
			return "error/500";
		}
	}
	
	//파일 다운로드
	@RequestMapping("/download")
	public ResponseEntity<ByteArrayResource> download(@RequestParam int attachNo) throws IOException{
//		log.debug("fileLoadVO = {}", fileLoadVO);
		return fileLoadVO.download(attachNo);
	}
	
	
}