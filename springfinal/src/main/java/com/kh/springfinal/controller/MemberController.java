package com.kh.springfinal.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.message.SimpleMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.CategoryDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dao.MemberCategoryDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dao.MemberProfileDao;
import com.kh.springfinal.dao.ZipCodeDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.MajorCategoryDto;
import com.kh.springfinal.dto.MemberCategoryDto;
import com.kh.springfinal.dto.MemberDto;
import com.kh.springfinal.dto.MemberEditDto;
import com.kh.springfinal.dto.MinorCategoryDto;
import com.kh.springfinal.dto.ZipCodeDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ZipCodeDao codeDao;
	
	@Autowired
	private MemberProfileDao memberProfileDao;
	
	@Autowired
	private MemberCategoryDao memberCategoryDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto,@RequestParam String StringmemberAddr, @RequestParam List<Integer> likeCategory) {
		//회원 정보 DB저장
		ZipCodeDto codeDto=codeDao.selectOneAddrNo(StringmemberAddr);
		memberDto.setMemberAddr(codeDto.getZipCodeNo());
		// 예제로 사용할 날짜 문자열
        String dateString = memberDto.getMemberBirth();

        // DateTimeFormatter를 사용하여 문자열을 LocalDate로 파싱
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate localDate = LocalDate.parse(dateString, formatter);

        // LocalDate를 다시 원하는 형식의 문자열로 변환
        String formattedDate = localDate.format(formatter);
        memberDto.setMemberBirth(formattedDate);
		memberDao.join(memberDto);
		MemberCategoryDto memberCategoryDto = new MemberCategoryDto();
		memberCategoryDto.setMemberId(memberDto.getMemberId());
		//관심 카테고리 저장
		for(int i = 0; i<likeCategory.size(); i++) {
			Integer likecategory = likeCategory.get(i);
			memberCategoryDto.setLikeCategory(likecategory);
			memberCategoryDao.insert(memberCategoryDto);
		}
		return "redirect:./login";
	}
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	//임시 로그인(아이디 새로 만든거 쓰실분은 아래 코드 주석풀어서 이용해주세요)
	  @PostMapping("/login")
	   public String login(@RequestParam String memberId, @RequestParam String memberPw, HttpSession session) {
		  	MemberDto memberDto = memberDao.loginId(memberId);
	         //세션에 아이디 저장+등급 저장
	         session.setAttribute("name", memberId);
	         session.setAttribute("level", memberDto.getMemberLevel());
	         session.setAttribute("memberName", memberDto.getMemberName());
	       
	         //메인페이지로 이동
	         return "redirect:/club/list"; 
	      };
	
//	@PostMapping("/login")
//	public String login(HttpServletResponse httpServletResponse,
//						@RequestParam String memberId, @RequestParam String memberPw,
//						@RequestParam(required = false) String saveId,
//								HttpSession session) {
////		db 유저 정보
//		MemberDto userDto = memberDao.selectOne(memberId, memberPw);
////		 id 틀리면 되돌림
//		if(userDto==null) {
//			if(saveId != null) {
//				Cookie cookie = new Cookie("saveId", memberId);
//				cookie.setMaxAge(4*7*24*60*60);//4주
//				httpServletResponse.addCookie(cookie);
//			}
//			else {
//				Cookie cookie = new Cookie("saveId", memberId);
//				cookie.setMaxAge(0);
//				httpServletResponse.addCookie(cookie);
//			}
//			return "redirect:login?error";
//		}
////		db Pw
//		String userPw = userDto.getMemberPw();
////		db Pw 와 입력값Pw 검사 후 session입력
//		if(userPw.equals(memberPw)) {
//			session.setAttribute("name", userDto.getMemberId());
//			session.setAttribute("level", userDto.getMemberLevel());
//      session.setAttribute("memberName", userDto.getMemberName());	
//			if(saveId != null) {
//				Cookie cookie = new Cookie("saveId", memberId);
//				cookie.setMaxAge(4*7*24*60*60);//4주
//				httpServletResponse.addCookie(cookie);
//			}
//			else {
//				Cookie cookie = new Cookie("saveId", memberId);
//				cookie.setMaxAge(0);//4주
//				httpServletResponse.addCookie(cookie);
//			}
//		}
//		else {
//			if(saveId != null) {
//				Cookie cookie = new Cookie("saveId", memberId);
//				cookie.setMaxAge(4*7*24*60*60);//4주
//				httpServletResponse.addCookie(cookie);
//			}
//			else {
//				Cookie cookie = new Cookie("saveId", memberId);
//				cookie.setMaxAge(0);
//				httpServletResponse.addCookie(cookie);
//			}
//			return "redirect:login?error";
//		}
////		로그인 완료창으로 보내기
//		return "redirect:../";	
//	}
	
			//ChatRoomDto chatRoomDto = chatRoomDao.selectOne(userDto.getMemberId());
			//log.debug("chatRoomDto: {}", chatRoomDto);
			//
			//if(chatRoomDto != null ) { //채팅방 번호가 있다면
			//	session.setAttribute("chatRoomNo", chatRoomDto.getChatRoomNo()); //채팅방 번호를 넣어라
			//}		
			
  	@RequestMapping("/logout")
	public String logout(HttpSession session){
		session.removeAttribute("name");
		session.removeAttribute("level");
		session.removeAttribute("memberName");
		return "redirect:./login";
	}		
	
	//아이디 찾기
	@GetMapping("/searchId")
	public String searchId() {
		return "member/searchId";
	}
	
	//아이디 찾기
	// 데이터를 searchId2로 넘기는 코드
	@PostMapping("/searchId")
	public String searchId2(@RequestParam String memberName, @RequestParam String memberEmail) {
	    try {
	        memberName = URLEncoder.encode(memberName, "UTF-8");
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace(); // 예외 처리 필요
	    }

	    return "redirect:./searchId2?memberName=" + memberName + "&memberEmail=" + memberEmail;
	}

	@RequestMapping("/searchId2")
	public String searchId2(Model model, @RequestParam String memberName, @RequestParam String memberEmail) {
	    try {
	        // 디코딩 추가
	        memberName = URLDecoder.decode(memberName, "UTF-8");
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace(); // 예외 처리 필요
	    }

	    List<MemberDto> idList = memberDao.memberIdListByEmail(memberName, memberEmail);
	   if(idList!=null) {
		   
	    // 문자열 제거
	    String idListString = idList.toString().replaceAll("[\\[\\]]", "");
	    // 데이터 Model에 담기
	    model.addAttribute("idList", idListString);
	    model.addAttribute("idCount", idList.size());
	    model.addAttribute("memberName", memberName);
	    return "member/searchId2";
	   }
	   return "./searchId?error";
	}
	
	@GetMapping("/searchPw")
	public String searchPw() {
		return "member/searchPw";
	}
	@PostMapping("/searchPw")
	public String searchPw(@RequestParam String memberId, @RequestParam String memberEmail) {
		MemberDto findDto  = memberDao.loginId(memberId);
		//아이디, 이메일 검사
		if(findDto!=null&&findDto.getMemberEmail().equals(memberEmail)) {
			// 알파벳 대문자, 소문자, 숫자를 조합하여 임시 비밀번호 생성
	        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	        StringBuilder tempPassword = new StringBuilder();
	        SecureRandom random = new SecureRandom();

	        for (int i = 0; i < 8; i++) {
	            int randomIndex = random.nextInt(characters.length());
	            tempPassword.append(characters.charAt(randomIndex));
	        }
	        
	        String temporaryPassword = tempPassword.toString();
			SimpleMailMessage message = new SimpleMailMessage();
			//메일 전송
			message.setTo(memberEmail);
			message.setSubject("[miso] 임시비밀번호가 도착하였습니다");
			message.setText(temporaryPassword);
			sender.send(message);
			//DB저장
			memberDao.changePw(memberId, temporaryPassword);
			
			return "redirect:./searchPwFinish";
		}
		else {
			return"redirect:./searchPw?error";
		}
	}
	
	@RequestMapping("/mypage")
	public String mypage(Model model, @RequestParam String memberId) {
		//회원 정보
		
		MemberDto memberDto = memberDao.loginId(memberId);
		//프로필 정보
		AttachDto attachDto = memberProfileDao.profileFindOne(memberId);
		//관심 카테고리
		List<MemberCategoryDto> likeList= memberCategoryDao.selectListLike(memberId);
		List<Integer> likeCategoryList = likeList.stream()
		        .map(MemberCategoryDto::getLikeCategory)
		        .collect(Collectors.toList());
		
		for(int i=0; i < likeList.size(); i++) {
			MinorCategoryDto minorCategoryDto = categoryDao.selectOneMajor(likeCategoryList.get(i));
			MajorCategoryDto majorCategoryDto =  memberCategoryDao.findLikemajor((likeCategoryList.get(i)));
			model.addAttribute("like"+i, majorCategoryDto.getMajorCategoryName()+"/"+minorCategoryDto.getMinorCategoryName());
		}
		//가입한 클럽 정보
		List<ClubDto> clubDto =  clubMemberDao.mypageClubList(memberId);
		if(clubDto!=null) model.addAttribute("clubDto", clubDto);
		if(attachDto!=null) {
			model.addAttribute("attachDto", attachDto);
		}
		model.addAttribute("memberDto", memberDto);
		return "member/mypage";
	}
	
	@GetMapping("/edit")
	public String edit(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("name");
		MemberDto memberDto = memberDao.loginId(memberId);
		AttachDto attachDto = memberProfileDao.profileFindOne(memberId);
		ZipCodeDto zipCodeDto = codeDao.selectOne(memberDto.getMemberAddr());
		if(zipCodeDto!=null) {
			String addr = (zipCodeDto.getSido() != null ? zipCodeDto.getSido() + ' ' : "") +
					(zipCodeDto.getSigungu() != null ? zipCodeDto.getSigungu() + ' ' : "") +
					(zipCodeDto.getEupmyun() != null ? zipCodeDto.getEupmyun() + ' ' : "") +
					(zipCodeDto.getHdongName() != null ? zipCodeDto.getHdongName() : "");
			model.addAttribute("addr", addr);
			
			List<MemberCategoryDto> likeList= memberCategoryDao.selectListLike(memberId);
			List<Integer> likeCategoryList = likeList.stream()
			        .map(MemberCategoryDto::getLikeCategory)
			        .collect(Collectors.toList());
			
			for(int i=0; i < likeList.size(); i++) {
				MinorCategoryDto minorCategoryDto = categoryDao.selectOneMajor(likeCategoryList.get(i));
				MajorCategoryDto majorCategoryDto =  memberCategoryDao.findLikemajor((likeCategoryList.get(i)));
				model.addAttribute("major"+i, majorCategoryDto.getMajorCategoryNo());
				model.addAttribute("minor"+i, minorCategoryDto.getMinorCategoryNo());
			}
			
		}

		
		model.addAttribute("attachDto", attachDto);
		model.addAttribute("memberDto", memberDto);
		return "member/edit";
	}
	
	@PostMapping("/edit")
	public String edit2(HttpSession httpSession, @ModelAttribute MemberEditDto memberDto, @RequestParam String memberAddrString, @RequestParam List<Integer> likeCategory
) {
		memberDto.setMemberId((String)httpSession.getAttribute("name"));
		//회원 정보 DB저장
				ZipCodeDto codeDto=codeDao.selectOneAddrNo(memberAddrString);
				memberDto.setMemberAddr(codeDto.getZipCodeNo());
				if(memberDto.getMemberBirth()!=null) {
					
				// 예제로 사용할 날짜 문자열
		        String dateString = memberDto.getMemberBirth();

		        // DateTimeFormatter를 사용하여 문자열을 LocalDate로 파싱
		        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		        LocalDate localDate = LocalDate.parse(dateString, formatter);

		        // LocalDate를 다시 원하는 형식의 문자열로 변환
		        String formattedDate = localDate.format(formatter);
		        memberDto.setMemberBirth(formattedDate);
				}
				log.debug(memberDto.toString());
				boolean result = memberDao.memberEdit(memberDto);
				memberCategoryDao.deleteLikeCategory(memberDto.getMemberId());
				MemberCategoryDto memberCategoryDto = new MemberCategoryDto();
				memberCategoryDto.setMemberId(memberDto.getMemberId());
				//관심 카테고리 저장
				for(int i = 0; i<likeCategory.size(); i++) {
					Integer likecategory = likeCategory.get(i);
					memberCategoryDto.setLikeCategory(likecategory);
					memberCategoryDao.insert(memberCategoryDto);
				}
				if(result) {
					return "redirect:./mypage?memberId="+memberDto.getMemberId();
				}
				else {
					return "500";
				}
		}
		@GetMapping("/out")
		public String out() {
			return "member/out";
		}
		@PostMapping("/out")
		public String out(@RequestParam String memberId, @RequestParam String memberPw) {
			MemberDto memberDto  = memberDao.selectOne(memberId, memberPw);
			if(memberDto!=null) {
				memberDao.deleteMember(memberId);
				return "redirect:./login";
			}
			return "redirect:./out?error";
		}
		@RequestMapping("/outFinish")
		public String outFinish() {
			return "member/outFinish";
		}
	}
