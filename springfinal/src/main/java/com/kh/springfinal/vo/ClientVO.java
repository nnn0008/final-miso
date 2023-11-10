package com.kh.springfinal.vo;

import java.io.IOException;
import java.sql.Date;
import java.util.Map;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

//웹소켓 통신에서 사용자를 조금 더 편하게 관리하기 위한 클래스
@Data 
@EqualsAndHashCode(of = "session") //session이라는 필드가 같으면 같은 객체라고 생각해라
@ToString(of = {"memberId", "memberLevel", "chatRoomNo"}) //출력할 때 작성한 항목만 출력해라
public class ClientVO {
	@JsonIgnore //Json으로 변환하는 과정에서 이 필드는 제외한다
	private WebSocketSession session;
	private String memberId, memberLevel;
	private Integer chatRoomNo;
//	private Integer clubNo;
	
	public ClientVO(WebSocketSession session) {
		this.session = session;
		Map<String, Object> attr = session.getAttributes();
		this.memberId = (String) attr.get("name");
		this.memberLevel = (String) attr.get("level");
		this.chatRoomNo = (Integer) attr.get("chatRoomNo");
//		this.clubNo = (Integer) attr.get("clubNo");
	}
	
	public boolean isMember() {
		return memberId != null && memberLevel != null; //둘 다 null이 아니어야 회원
	}
	
	public void send(TextMessage message) throws IOException {
		session.sendMessage(message);
	}
	
}
