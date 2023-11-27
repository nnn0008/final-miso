package com.kh.springfinal.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubBoardReplyDto {
	private int clubBoardReplyNo;
	private String clubBoardReplyContent;
	private String clubBoardReplyDate;
	private int clubBoardReplyGroup;
	private Integer clubBoardReplyParent;
	private int clubBoardReplyDepth;
	private String clubBoardReplyWriter;
	private int clubMemberNo;
	private int clubBoardNo;
	private boolean match;
	
	//댓글 작성자 출력용 메소드
	public String getClubBoardReplyWriter() {
		if(clubBoardReplyWriter == null) return "탈퇴한 유저";
		else return clubBoardReplyWriter;
	}
	
	public String getFormattedClubBoardReplyDate() throws ParseException {
        // 형식 지정
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat outputFormat = new SimpleDateFormat("MM월 dd일 HH시 mm분");

            Date date = inputFormat.parse(clubBoardReplyDate);

            // Date 객체를 원하는 형식으로 변환
            return outputFormat.format(date);
       
    }
}
