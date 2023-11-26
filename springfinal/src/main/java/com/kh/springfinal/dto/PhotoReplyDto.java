package com.kh.springfinal.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder @Data @AllArgsConstructor @NoArgsConstructor
public class PhotoReplyDto {
	private int photoReplyNo;
	private String photoReplyContent;
	private Date photoReplyDate;
	private int photoReplyGroup;
	private Integer photoReplyParent;
	private int photoNo;
	private int clubMemberNo;
}
