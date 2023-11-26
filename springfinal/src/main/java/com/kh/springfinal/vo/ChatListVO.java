package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ChatListVO {

	private int chatRoomNo; //룸 번호
	private int clubNo; //동호회 번호
	private String clubName; //동호회 이름
	private String clubExplain; //동호회 설명

	private int attachNo; //동호회 사진 번호
	private String chatContent; //동호회 채팅 마지막메시지
	private String chatBlind;
}
