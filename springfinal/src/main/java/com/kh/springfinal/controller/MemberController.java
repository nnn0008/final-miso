package com.kh.springfinal.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.message.SimpleMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		//회원 정보 DB저장
		memberDao.join(memberDto);
		return "redirect:./login";
	}
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	@PostMapping("/login")
	public String login(HttpServletResponse httpServletResponse,
						@RequestParam String memberId, @RequestParam String memberPw,
						@RequestParam(required = false) String saveId,
								HttpSession session) {
		//db 유저 정보
		MemberDto userDto = memberDao.loginId(memberId, memberPw);
		// id 틀리면 되돌림
		if(userDto==null) {
			if(saveId != null) {
				Cookie cookie = new Cookie("saveId", memberId);
				cookie.setMaxAge(4*7*24*60*60);//4주
				httpServletResponse.addCookie(cookie);
			}
			else {
				Cookie cookie = new Cookie("saveId", memberId);
				cookie.setMaxAge(0);
				httpServletResponse.addCookie(cookie);
			}
			return "redirect:login?error";
		}
		//db Pw
		String userPw = userDto.getMemberPw();
		//db Pw 와 입력값Pw 검사 후 session입력
		if(userPw.equals(memberPw)) {
			session.setAttribute("name", userDto.getMemberId());
			session.setAttribute("level", userDto.getMemberLevel());
			if(saveId != null) {
				Cookie cookie = new Cookie("saveId", memberId);
				cookie.setMaxAge(4*7*24*60*60);//4주
				httpServletResponse.addCookie(cookie);
			}
			else {
				Cookie cookie = new Cookie("saveId", memberId);
				cookie.setMaxAge(0);//4주
				httpServletResponse.addCookie(cookie);
			}
		}
		else {
			if(saveId != null) {
				Cookie cookie = new Cookie("saveId", memberId);
				cookie.setMaxAge(4*7*24*60*60);//4주
				httpServletResponse.addCookie(cookie);
			}
			else {
				Cookie cookie = new Cookie("saveId", memberId);
				cookie.setMaxAge(0);//4주
				httpServletResponse.addCookie(cookie);
			}
			return "redirect:login?error";
		}
		//로그인 완료창으로 보내기
		return "redirect:../";	
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
	    Cookie cookie = new Cookie("searchId", null);
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
		MemberDto findDto  = memberDao.selectOne(memberId);
		//아이디, 이메일 검사
		if(findDto.getMemberEmail().equals(memberEmail)) {
			SimpleMessage message = new SimpleMessage();
//			message.setTo();
			return "redirect:./searchPwFinish";
		}
		else {
			return"redirect:./searchPw?error";
		}
	}
	
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		String memberId=(String) session.getAttribute("name");
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return "member/mypage";
	}

	
}