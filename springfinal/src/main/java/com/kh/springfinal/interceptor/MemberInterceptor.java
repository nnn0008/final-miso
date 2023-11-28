package com.kh.springfinal.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

//회원인지 아닌지 검사하여 비회원을 차단하는 인터셉터 구현

@Component
public class MemberInterceptor implements HandlerInterceptor{

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		 // 세션이 주어지지 않으므로, 요청 정보에서 세션 객체를 추출하여 사용
	    HttpSession session = request.getSession();
	    String memberId = (String) session.getAttribute("name");
	    boolean isLogin = memberId != null;

	    if (isLogin) {
	        // 회원이면
	        return true;
	    } else {
	        // 비회원이면 로그인 페이지로 리다이렉트
	        response.sendRedirect(request.getContextPath() + "/member/login");
	        return false;
	    }
	}
}
