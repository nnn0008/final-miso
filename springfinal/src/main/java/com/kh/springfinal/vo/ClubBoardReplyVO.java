package com.kh.springfinal.vo;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;
@Data
public class ClubBoardReplyVO {
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
	
	public String getFormattedClubBoardReplyDate() throws ParseException {
        // 형식 지정
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat outputFormat = new SimpleDateFormat("MM월 dd일 HH시 mm분");

            Date date = inputFormat.parse(clubBoardReplyDate);

            // Date 객체를 원하는 형식으로 변환
            return outputFormat.format(date);
       
    }
}
