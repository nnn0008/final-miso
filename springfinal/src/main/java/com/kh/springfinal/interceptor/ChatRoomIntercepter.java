package com.kh.springfinal.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.springfinal.dao.ChatRoomDao;
import com.kh.springfinal.error.AuthorityException;

//회원인지 아닌지 검사하여 비회원을 차단하는 인터셉터 구현

@Component
public class ChatRoomIntercepter implements HandlerInterceptor {

    @Autowired
    private ChatRoomDao chatRoomDao;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        // URL 경로에서 chatRoomNo 추출
        String path = request.getRequestURI();
        String[] pathSegments = path.split("/");
        String chatRoomNoStr = pathSegments[pathSegments.length - 1];

        // chatRoomNo를 정수로 변환
        int chatRoomNo;
        try {
            chatRoomNo = Integer.parseInt(chatRoomNoStr);
        } catch (NumberFormatException e) {
            // chatRoomNo가 정수로 변환할 수 없는 경우 처리
        	throw new AuthorityException("error");
        }

        // 세션에서 회원 아이디 추출
        HttpSession session = request.getSession();
        String memberId = (String) session.getAttribute("name");

     // 채팅방 회원 여부 확인
        if (isChatRoomMember(memberId, chatRoomNo) || isMeetingRoomMember(memberId, chatRoomNo) 
        		|| isOneChatRoomMember(memberId, chatRoomNo)) {
            // 채팅방 회원이면 통과
            return true;
        } else {
            // 채팅방 회원이 아니면 chatRoomError.jsp로 포워딩
            throw new AuthorityException("채팅방 멤버가 아닙니다.");
        }
    }


    private boolean isChatRoomMember(String memberId, int chatRoomNo) {
        int result = chatRoomDao.isChatRoomMember(memberId, chatRoomNo);

        // 0이면 채팅방 회원이 아님
        return result > 0;
    }
    
    private boolean isMeetingRoomMember(String memberId, int chatRoomNo) {
    	int result = chatRoomDao.isMeetingRoomMember(memberId, chatRoomNo);
    	return result > 0;
    }
    
    private boolean isOneChatRoomMember(String memberId, int chatRoomNo) {
    	int result = chatRoomDao.isOneChatRoomMember(memberId, chatRoomNo);
    	return result > 0;
    }
    
    
}

