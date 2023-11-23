package com.kh.springfinal.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class PhotoReplyVO {
	private int photoReplyNo;
	private String photoReplyContent;
	private Date photoReplyDate;
	private int photoReplyGroup;
	private Integer photoReplyParent;
	private int photoNo;
	private int clubMemberNo;
	private boolean match;
	private String photoReplyWriter;
	private String photoReplyId;
}
