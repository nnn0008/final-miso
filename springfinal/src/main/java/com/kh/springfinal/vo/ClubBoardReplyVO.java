package com.kh.springfinal.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class ClubBoardReplyVO {
	private int clubBoardReplyNo;
	private String clubBoardReplyContent;
	private Date clubBoardReplyDate;
	private int clubBoardReplyGroup;
	private Integer clubBoardReplyParent;
	private int clubBoardReplyDepth;
	private String clubBoardReplyWriter;
	private int clubMemberNo;
	private int clubBoardNo;
	private boolean match;
}
