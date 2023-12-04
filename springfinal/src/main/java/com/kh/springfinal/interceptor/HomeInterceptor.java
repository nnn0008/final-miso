package com.kh.springfinal.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class HomeInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//홈에서 처리해야되는건? 비로그인이 못들어오게 하는 것 하나
		HttpSession session = request.getSession();
		String memberId = (String)session.getAttribute("name");
		
		boolean isLogin = memberId != null;
		
		if(isLogin) {
			return true;
		}
		else {
			response.sendRedirect(request.getContextPath() + "/member/login");
			return false;
		}
		
	}
}
