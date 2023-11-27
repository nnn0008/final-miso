package com.kh.springfinal.reactRest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.OneDao;
import com.kh.springfinal.dto.OneDto;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@CrossOrigin(value = {"http://localhost:3000", "http://localhost:5500"})
@RestController
@RequestMapping("/rest/onereq")
public class OneReactController {
	@Autowired
	private OneDao oneDao;
	
	@GetMapping("/")
	public List<OneDto> selectAdminList(){
		return oneDao.selectAdminList();
	}
	
	@PostMapping("/")
	public void insert(@RequestBody OneDto targetChange) {
		log.debug(targetChange.toString());
		int oneNo = oneDao.sequence();
		OneDto oneDto = new OneDto();
		oneDto.setOneNo(oneNo);//번호 넣고
		oneDto.setOneTitle("RE:"+targetChange.getOneTitle());
		oneDto.setOneContent(targetChange.getOneContent());
			oneDto.setOneGroup(targetChange.getOneGroup());
			oneDto.setOneParent(targetChange.getOneNo());
			oneDto.setOneDepth(targetChange.getOneDepth()+1);
			oneDto.setOneStatus(1);
		oneDao.oneAnswer(oneDto);
		oneDao.insert(oneDto);//글쓰기
	}
}
