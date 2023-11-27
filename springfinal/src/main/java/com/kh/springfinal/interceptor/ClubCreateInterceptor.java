//package com.kh.springfinal.interceptor;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.servlet.HandlerInterceptor;
//
//import com.kh.springfinal.dao.ClubDao;
//import com.kh.springfinal.dao.ClubMemberDao;
//import com.kh.springfinal.dao.MemberDao;
//import com.kh.springfinal.dto.MemberDto;
//import com.kh.springfinal.vo.ClubImageVO;
//
//public class ClubCreateInterceptor implements HandlerInterceptor {
//
//@Autowired
//private ClubDao clubDao;
//
//@Autowired
//private ClubMemberDao clubMemberDao;
//
//@Autowired
//private MemberDao memberDao;
//
//@Override
//public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//		throws Exception {
//	
//	
//	HttpSession session = request.getSession();
//	String memberId = (String)session.getAttribute("name");
//	String stringClubNo = request.getParameter("clubNo");
//	
//	
//	MemberDto memberDto = memberDao.loginId(memberId);
//	String memberRank = memberDto.getMemberLevel();
//	int memberJoinClubCount = clubMemberDao.memberJoinClubCount(memberId);
//	
//	
//	boolean isLogin = memberId != null;
//	
//	
//	
//	if(!isLogin) { //가장 처음으로 로그인 안된 계정은 로그인으로 리 다이렉트
//		response.sendRedirect(request.getContextPath() + "/member/login");
//		return false;
//	}
//	
//	
//	else if(memberRank.equals("일반유저")) {
//		
//		if(memberJoinClubCount>=5) {
//			
//			throw new AuthorityException("만들 수 있는 동호회 수 초과");
//		}
//		
//		else {
//			
//			return true;
//		}
//		
//		
//	}
//	else if(memberRank.equals("파워유저")) {
//		
//		if(memberJoinClubCount>=12) {
//			
//			throw new AuthorityException("만들 수 있는 동호회 수 초과");
//		}
//		else {
//			
//			return true;
//		}
//		
//	}
//	
//	else {
//		return true;
//	}
//}
//}
