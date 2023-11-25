package com.kh.springfinal.rest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.HomeDao;
import com.kh.springfinal.vo.HomeForMeetingVO;
import com.kh.springfinal.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
@RequestMapping("/rest/home")
public class HomeRestController {
	
	@Autowired
	private HomeDao homeDao;
	
	@GetMapping("page")
	public List<HomeForMeetingVO> page(@ModelAttribute("vo")PaginationVO vo, @RequestParam(required=false) int page, HttpSession session){
		String memberId = (String)session.getAttribute("name");
		int count = homeDao.meetingCount(vo, memberId);
		vo.setPage(page);
		vo.setCount(count);
		List<HomeForMeetingVO> list = homeDao.selectList(vo, memberId);
		
		log.debug("page = {}", page);
		log.debug("vo = {}", vo);
		log.debug("list = {}", list);
		return list;
	}
}
