package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ChatOneVO {
	private int chatRoomNo;
	private String memberId;
	private String memberName;
	private String memberLevel;

}
