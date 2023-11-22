package com.kh.springfinal.reactRest;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.OneDao;
import com.kh.springfinal.dto.OneDto;

@CrossOrigin(value = {"http://localhost:3000", "http://localhost:5500"})
@RestController
@RequestMapping("/rest/onereq")
public class OneReactController {
	@Autowired
	private OneDao oneDao;
	
	@GetMapping("/")
	public List<OneDto> selectList(){
		return oneDao.selectList();
	}
	
	@PostMapping("/{oneDto}")
	public void insert(@PathVariable OneDto oneDto, HttpSession session) {
		int oneNo = oneDao.sequence();
		oneDto.setOneNo(oneNo);//번호 넣고
		
		String memberId=(String)session.getAttribute("name");
		oneDto.setOneMember(memberId);//작성자 넣고
		
		//새글/답글
		if(oneDto.getOneParent()==null) {//새글일떄
			oneDto.setOneGroup(oneNo);//그룹번호는 글번호
			oneDto.setOneParent(null);//상위글없으니 null
			oneDto.setOneDepth(0);
		}
		else {//답글일때
			OneDto originDto = oneDao.selectOne(oneDto.getOneParent());
			oneDto.setOneGroup(originDto.getOneGroup());
			oneDto.setOneParent(originDto.getOneNo());
			oneDto.setOneDepth(originDto.getOneDepth()+1);
		}
		
		oneDao.insert(oneDto);//글쓰기
	}
}
