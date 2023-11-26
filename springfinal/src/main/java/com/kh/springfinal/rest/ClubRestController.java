package com.kh.springfinal.rest;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.CategoryDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dao.WishlistDao;
import com.kh.springfinal.dao.ZipCodeDao;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.dto.MinorCategoryDto;
import com.kh.springfinal.dto.ZipCodeDto;
import com.kh.springfinal.vo.ClubImageVO;
import com.kh.springfinal.vo.ClubListVO;
import com.kh.springfinal.vo.ClubMemberVO;
import com.kh.springfinal.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;

@CrossOrigin
@RestController
@RequestMapping("/rest")
@Slf4j
public class ClubRestController {
		
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private ZipCodeDao zipCodeDao;
	
	@Autowired
	private CategoryDao categoeyDao;
	
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@Autowired
	private WishlistDao wishlistDao;
	
	@Autowired
	private MemberDao memberDao;
	
	
	
	@GetMapping("/category")
	public List<MinorCategoryDto> category(@RequestParam int majorCategoryNo) {
		
		return categoeyDao.minorCategoryList(majorCategoryNo);
	
	}
	
//	@GetMapping("/zip")
//	public List<String> zipList(@RequestParam String keyword){
//		List<String> resultList = new ArrayList<>();
//		
//		List<ZipCodeDto> zipList = zipCodeDao.list(keyword);
//		
//		for(int i=0; i<zipList.size();i++) {
//			StringBuilder sb = new StringBuilder();
//			
//		sb.append(zipList.get(i).getSido());
//		sb.append(zipList.get(i).getSigungu());
//		sb.append(zipList.get(i).getEupmyun());
//		sb.append(zipList.get(i).getDoro());
//		sb.append(zipList.get(i).getBuildName());
//		sb.append(zipList.get(i).getDongName());
//		sb.append(zipList.get(i).getHdongName());
//		
//		String result = sb.toString();
//		resultList.add(result);
//		}
//
//		return resultList;
//		
//	}
	
	@GetMapping("/zip")
	public List<ZipCodeDto> zipList(@RequestParam String keyword) {
	    List<ZipCodeDto> zipList = zipCodeDao.list(keyword);
	    return zipList;
	}
	
	@GetMapping("/zipPage")
	public List<ZipCodeDto> zipPageList(@ModelAttribute(name ="vo") PaginationVO vo) {
		
		int count = zipCodeDao.countList(vo);
		vo.setCount(count);
		
	    List<ZipCodeDto> zipList = zipCodeDao.selectListByPage(vo);
	    return zipList;
	}
	
	@PostMapping("/clubMember")
	public void join(@ModelAttribute ClubMemberDto clubMemberDto,HttpSession session) {
		
		boolean noMember =  session.getAttribute("name") ==null;
		
		
		
		int clubMemberNo = clubMemberDao.sequence();
		
		clubMemberDto.setClubMemberRank("일반");
		clubMemberDto.setClubMemberNo(clubMemberNo);
		
		clubMemberDao.insert(clubMemberDto);
		
		
	}
	
	@GetMapping("/existMember")
	public boolean exist(@RequestParam int clubNo,
			@RequestParam String memberId) {
		
		boolean exist = clubMemberDao.
				existMember(clubNo, 
						memberId);
		
		if(exist) {
		
		return true;
		
	}
		else {
			return false;
			
		}
	
	}
	
	
	
	@GetMapping("/clubSearchPageList")
	public List<ClubListVO> searchList(@ModelAttribute(name ="vo") PaginationVO vo,
			HttpSession session){
		
		String memberId = (String) session.getAttribute("name");
		
		int count = clubDao.searchCount(vo);
		
		vo.setWhereString(memberId);
		vo.setSize(6);
		vo.setCount(count);
		
		List<ClubListVO> clubList= clubDao.clubSearchPageList(vo);
		
			for(ClubListVO list : clubList) {
			
			int memberCount = clubMemberDao.memberCount(list.getClubNo());
			list.setMemberCount(memberCount);
			
			int clubNo = list.getClubNo();
			
			
			boolean likeClub = wishlistDao.doLike(memberId, clubNo);
			
			list.setLikeClub(likeClub);
			log.debug("likeClub={}",likeClub);
		}
		
		return clubList;
		
		
	}
	
	@GetMapping("memberPreferList")
	public List<ClubListVO> memberPreferClubList(
			@ModelAttribute(name ="vo") PaginationVO vo,
			HttpSession session){
		
		
		
		String memberId = (String) session.getAttribute("name");
		
		
		vo.setWhereString(memberId);
		vo.setSize(6);
		
		int count = clubDao.preferCount(vo);
		List<ClubListVO> clubList= clubDao.clubListPage(vo);
		
		for(ClubListVO list : clubList) {
			
			int memberCount = clubMemberDao.memberCount(list.getClubNo());
			list.setMemberCount(memberCount);
			
			int clubNo = list.getClubNo();
			
			
			boolean likeClub = wishlistDao.doLike(memberId, clubNo);
			
			list.setLikeClub(likeClub);
			
		}
		
		
		return clubList;
		
		
	}
	
	@GetMapping("majorCategoryClubList")
	public List<ClubListVO> majorCategoryClubList(@ModelAttribute(name ="vo") PaginationVO vo,
			HttpSession session){
		
		
		
		String memberId = (String) session.getAttribute("name");
		
		
		vo.setWhereString(memberId);
		
		vo.setSize(6);
		
		List<ClubListVO> clubList= clubDao.majorClubListPage(vo);
		
		for(ClubListVO list : clubList) {
			
			int memberCount = clubMemberDao.memberCount(list.getClubNo());
			list.setMemberCount(memberCount);
			
			int clubNo = list.getClubNo();
			
			
			boolean likeClub = wishlistDao.doLike(memberId, clubNo);
			
			list.setLikeClub(likeClub);
			
		}
		
		
		return clubList;
		
		
	}
	
	@GetMapping("minorCategoryClubList")
	public List<ClubListVO> minorCategoryClubList(@ModelAttribute(name ="vo") PaginationVO vo,
			HttpSession session){
		
		
		
		String memberId = (String) session.getAttribute("name");
		
		
		vo.setWhereString(memberId);
		
		vo.setSize(6);
		
		List<ClubListVO> clubList= clubDao.minorClubListPage(vo);
		
				for(ClubListVO list : clubList) {
			
			int memberCount = clubMemberDao.memberCount(list.getClubNo());
			list.setMemberCount(memberCount);
			
			int clubNo = list.getClubNo();
			
			
			boolean likeClub = wishlistDao.doLike(memberId, clubNo);
			
			list.setLikeClub(likeClub);
			
		}
		
		
		return clubList;
		
		
	}
	
	
	@PostMapping("wishInsert")
	public void add(HttpSession session, int clubNo) {
		
		String memberId= (String) session.getAttribute("name");
		
		wishlistDao.insert(memberId, clubNo);
		
		
	}
	
	@PostMapping("wishDelete")
	public void delete(HttpSession session, int clubNo) {
		
		String memberId= (String) session.getAttribute("name");
		
		wishlistDao.delete(memberId, clubNo);
		
		
	}
	
	@GetMapping("clubMemberList")
	public List<ClubMemberVO> clubMemberList(int clubNo,HttpSession session){
		
		String memberId= (String) session.getAttribute("name");
		
		boolean master = clubMemberDao.editPossible(clubNo, memberId);
		
		log.debug("isMaster={}",master);
		
		List<ClubMemberVO> clubMemberList = clubMemberDao.memberInfo(clubNo);
		SimpleDateFormat joinDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		for(ClubMemberVO dto : clubMemberList) {
			
		String date = joinDateFormat.format(dto.getJoinDate());
		
		dto.setMasterRank(master);	
		dto.setJoinDateString(date);
		}
		
		
		
		return clubMemberList;
	}
	
	@GetMapping("/upgradeRank")
	public boolean upgrade(int clubMemberNo) {
		
		boolean result = clubMemberDao.upgradeRank(clubMemberNo);
		
		return result; 
		
		
		
	}
	
	@GetMapping("/joinPossible")
	public int joinPossible(HttpSession session,int clubNo){
		
		String memberId = (String) session.getAttribute("name");
		int memberJoinCount = clubMemberDao.memberJoinClubCount(memberId);
		MemberDto memberDto = memberDao.loginId(memberId);
		ClubImageVO clubDto = clubDao.clubDetail(clubNo);
		
		int clubMemberCount = clubMemberDao.memberCount(clubNo);
		int clubMaxMember = clubDto.getClubPersonnel();
		
		log.debug("memberJoinCount={}",memberJoinCount);
		
		if(clubMemberCount>=clubMaxMember) {
			
			return 1;
			
			
		}
		
		else if(memberDto.getMemberLevel().equals("일반유저")) {
			
			if(memberJoinCount>=5) {
				
				return 2;
			}
			return 4;
		}
		
		else {
			
				
				if(memberJoinCount>=60) {
					
					return 3;
					
				}
				
				return 4;
			
		}
		

	}
	
	@GetMapping("/clubMakePossible")
	public int joinPossible(HttpSession session){
		
		String memberId = (String) session.getAttribute("name");
		int memberJoinCount = clubMemberDao.memberJoinClubCount(memberId);
		MemberDto memberDto = memberDao.loginId(memberId);
		

		if(memberDto.getMemberLevel().equals("일반유저")) {
			
			if(memberJoinCount>=5) {
				
				return 1;
			}
		}
		
		else {
			
				
				if(memberJoinCount>=50) {
					
					return 2;
					
				}
				
			
		}
		
		return 3;
		

	}
	
	
	
	
	
	
	
	
	
	
	
}
