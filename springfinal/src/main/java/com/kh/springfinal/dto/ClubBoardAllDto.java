package com.kh.springfinal.dto;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;

import com.kh.springfinal.dao.ClubBoardDao;
import com.kh.springfinal.dao.ClubBoardLikeDao;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class ClubBoardAllDto {
	private int clubBoardNo;
	private String clubMemberId;
	private Integer attachNoMp;
	private String clubMemberRank;
	private int clubNo;
	private String clubBoardTitle;
	private String clubBoardContent;
	private String clubBoardCategory;
	@DateTimeFormat(pattern = "yyyyMMddHHmm") String clubBoardDate;
	private int clubBoardLikecount;
	private int clubBoardReplyCount;
	private String clubBoardName;
	private Integer attachNoCbi;
	private Integer attachNoCbi2;
	private Integer attachNoCbi3;
	private boolean liked;
	
//	public boolean isLiked(clubBoardNo) {
//		@Autowired
//		private ClubBoardDao clubBoardDao;
//		@Autowired
//		private ClubBoardLikeDao clubBoardLikeDao;
//		
//		public boolean isLike(clubBoardNo, HttpSession session) {
//			ClubBoardDto clubBoardDto = clubBoardDao.selectOnes(clubBoardNo);
//			String memberId = (String)session.getAttribute("name");
//			boolean isCheck = clubBoardLikeDao.isLike(clubBoardDto.getClubMemberNo(), clubBoardNo);
//		}
//	}
	
}
