package com.kh.springfinal.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ClubBoardReplyMemberVO {

	private String replyMemberId;
	private int replyMemberNo;
	private String boardMemberId;
	private int boardMemberNo;
	private String clubBoardTitle;
}
