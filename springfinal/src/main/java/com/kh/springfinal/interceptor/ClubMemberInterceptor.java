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
//public class ClubMemberInterceptor implements HandlerInterceptor {
//	
//	@Autowired
//	private ClubDao clubDao;
//	
//	@Autowired
//	private ClubMemberDao clubMemberDao;
//	
//	@Autowired
//	private MemberDao memberDao;
//	
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//		
//		
//		HttpSession session = request.getSession();
//		String memberId = (String)session.getAttribute("name");
//		String stringClubNo = request.getParameter("clubNo");
//		int clubNo = Integer.parseInt(stringClubNo);
//		
//		ClubImageVO clubDto = clubDao.clubDetail(clubNo);
//		int clubMemberCount = clubMemberDao.memberCount(clubNo);
//		
//		MemberDto memberDto = memberDao.loginId(memberId);
//		String memberRank = memberDto.getMemberLevel();
//		int memberJoinClubCount = clubMemberDao.memberJoinClubCount(memberId);
//		int clubMemberNo = clubMemberDao.findClubMemberNo(clubNo, memberId);
//		
//		boolean maneger = clubMemberDao.editPossible(clubNo, memberId);	//운영진인지
//		
//		boolean isLogin = memberId != null;
//		boolean joinedClub = clubMemberDao.joinedClub(clubNo, memberId);
//		
//		
//		if(stringClubNo==null) {
//			
//			throw new Exception("존재하지 않는 동호회");
//			
//		}
//		else if(!isLogin) { //가장 처음으로 로그인 안된 계정은 로그인으로 리 다이렉트
//			response.sendRedirect(request.getContextPath() + "/member/login");
//			return false;
//		}
//		else if(clubMemberNo==0) {
//			
//			throw new Exception("동호회 회원이 아닙니다");
//		}
//		return joinedClub;
//
//	}
//}
