package com.kh.springfinal.vo;

import java.util.List;

import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.ClubMemberDto;
import com.kh.springfinal.dto.MemberDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PurchaseClubListVO {
	 private List<ClubMemberDto> clubMembers;
	    private List<ClubDto> clubs;
	    private List<MemberDto> members;
}
