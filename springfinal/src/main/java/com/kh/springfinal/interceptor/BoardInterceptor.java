package com.kh.springfinal.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubDao;
import com.kh.springfinal.dao.ClubMemberDao;
import com.kh.springfinal.dto.ClubBoardDto;
import com.kh.springfinal.dto.ClubMemberDto;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@Component
public class BoardInterceptor implements HandlerInterceptor{
	
	@Autowired
	private ClubDao clubDao;
	@Autowired
	private ClubBoardDao clubBoardDao;
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	//게시판에서 일어날 수 있는 인터셉터
	// - 게시판 / 글쓰기 / 사진첩은 clubNo 사용
	// - 게시글 상세에서는 clubBoardNo 사용
	// - 가입 여부를 따져서 글쓰기 게시판을 들어갈 수 있는지를 따져본다.
	// - 동호회 홈( /club/detail?clubNo=?? ) 으로 리 다이렉트 시켜준다
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("name");
		boolean isLogin = memberId != null;
		
		//글 번호 혹은 게시글 번호
		String stringClubNo = request.getParameter("clubNo");
		String stringClubBoardNo = request.getParameter("clubBoardNo");
		log.debug("isLogin = {}", isLogin);
		log.debug("stringClubNo = {}", stringClubNo);
		log.debug("stringClubBoardNo = {}", stringClubBoardNo);
		//클럽 번호가 있는 곳은?
		if(!isLogin) { //가장 처음으로 로그인 안된 계정은 로그인으로 리 다이렉트
			response.sendRedirect(request.getContextPath() + "/member/login");
			return false;
		}
		
		else if(stringClubBoardNo != null) { //게시판 글쓰기 화면은 클럽 홈으로 리다이렉트
			int clubBoardNo = Integer.parseInt(stringClubBoardNo);
			ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(clubBoardNo);
			ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubBoardDto.getClubNo());
			if(clubMemberDto == null) { //로그인은 됐으나 가입은 안 된경우
				response.sendRedirect(request.getContextPath() + "/club/detail?clubNo=" + clubBoardDto.getClubNo());
				return false;
			}
			else { //로그인도 됐고 가입도 된 경우라면?
				return true;
			}
		}
		
		else if(stringClubNo != null) { //게시판 상세도 마찬가지
			int clubNo = Integer.parseInt(stringClubNo);
			ClubMemberDto clubMemberDto = clubBoardDao.selectOneClubMemberNo(memberId, clubNo);
			if(clubMemberDto == null) { //로그인은 됐으나 가입은 안 된경우
				response.sendRedirect(request.getContextPath() + "/club/detail?clubNo=" + clubNo);
				return false;
			}
			else { //로그인도 됐고 가입도 된 경우라면?
				return true;
			}
		}
		
		else {
			return true; 
		}
		
	}
	
	
	
}
