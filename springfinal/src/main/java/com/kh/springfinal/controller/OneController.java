package com.kh.springfinal.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.springfinal.configuration.FileUploadProperties;
import com.kh.springfinal.dao.AttachDao;
import com.kh.springfinal.dao.MemberDao;
import com.kh.springfinal.dao.OneDao;
import com.kh.springfinal.dto.AttachDto;
import com.kh.springfinal.dto.OneDto;
import com.kh.springfinal.vo.PaginationVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/one")
public class OneController {
	@Autowired
	private OneDao oneDao;
	
	@Autowired
	private MemberDao memberDao; 
	
	@Autowired
	private AttachDao attachDao;
	
	@Autowired
	private FileUploadProperties props;
	
	private File dir;
	
	@PostConstruct
	public void init() {
		dir = new File(props.getHome());
		dir.mkdirs();
	}
	
	
	//등록
	@GetMapping("/insert")
	public String insert(Model model,
							@RequestParam(required = false) Integer oneParent) {
		//답글이라면 원본글 정보를 화면에 전달
		if(oneParent != null) {
			OneDto originDto = oneDao.selectOne(oneParent);
			model.addAttribute("originDto",originDto);//원본글
			model.addAttribute("isReply",true);//답글
		}
		else {
			model.addAttribute("isReply",false);
		}
		return "one/insert";
	}
	@PostMapping("/insert")
	public String insert(@ModelAttribute OneDto oneDto, HttpSession session,@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
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
		
		if(!attach.isEmpty()) {//파일이 있으면
			int attachNo= attachDao.sequence();
			log.debug("attachNo={}",attachNo);
			File target = new File(dir, String.valueOf(attachNo));//저장할 파일
			attach.transferTo(target);
			
			AttachDto attachDto = new AttachDto();
			attachDto.setAttachNo(attachNo);
			attachDto.setAttachName(attach.getOriginalFilename());
			attachDto.setAttachSize(attach.getSize());
			attachDto.setAttachType(attach.getContentType());
			attachDao.insert(attachDto);
			
			//연결
			oneDao.connect(oneNo, attachNo);
			
		}
		return "redirect:detail?oneNo="+oneNo;
	}
	
	// 상세조회
	@RequestMapping("/detail")
	public String detail(@RequestParam int oneNo,Model model,
								HttpSession session) {
		OneDto oneDto = oneDao.selectOne(oneNo);
		model.addAttribute("OneDto",oneDto);
//		//작성자 정보
//		String oneMemberId = oneDto.getOneMember();
//		if(oneMemberId != null) {
//			MemberDto memberDto = memberDao.selectOne(oneMemberId);
//			model.addAttribute("oneMemberId",memberDto);
//		}
		return"one/detail";
	}
	
	@ResponseBody
	@RequestMapping("/image")//이미지를 불러온다는 사실
	public ResponseEntity<ByteArrayResource> image(@RequestParam int oneNo) throws IOException{
		AttachDto attachDto = oneDao.findImage(oneNo);
		
		File target = new File(dir, String.valueOf(attachDto.getAttachNo()));//저장할 파일
	
		byte[] data = FileUtils.readFileToByteArray(target);//실제 파일 불러오기
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_ENCODING,StandardCharsets.UTF_8.name())
				.contentLength(attachDto.getAttachSize())
				.header(HttpHeaders.CONTENT_TYPE, attachDto.getAttachType())
				.header(HttpHeaders.CONTENT_DISPOSITION,
						ContentDisposition.attachment().filename(attachDto.getAttachName(),StandardCharsets.UTF_8).build().toString()
						)
				.body(resource);
	}
	
//목록
//	@RequestMapping("/list")
//	public String list(Model model) {
//		List<OneDto>list = oneDao.selectList();
//		model.addAttribute("list",list);
//		return "one/list";
//	}
//	@RequestMapping("/list")
//	public String list(Model model, @RequestParam(defaultValue = "1") int page) {
//	    int size = 20; // 페이지당 보여줄 아이템 수를 설정합니다.
//
//	    PaginationVO paginationVO = new PaginationVO();
//	    paginationVO.setPage(page);
//	    paginationVO.setSize(size);
//
//	    List<OneDto> list = oneDao.selectListByPage(paginationVO);
//
//	    model.addAttribute("list", list);
//	    model.addAttribute("pagination", paginationVO);
//
//	    return "one/list";
//	}
	@RequestMapping("/list")
	public String list( @ModelAttribute(name ="vo") PaginationVO vo, Model model) {
		int count = oneDao.countList(vo);
		vo.setCount(count);
		
		List<OneDto> list = oneDao.selectListByPage(vo);
	    model.addAttribute("list", list);
	   
	   
	    return "one/list";
	}
	
	

	
	//삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam int oneNo,HttpSession session) {
		OneDto oneDto = oneDao.selectOne(oneNo);
		AttachDto attachDto = oneDao.findImage(oneNo);
		String oneMember = oneDto.getOneMember();
		
		String memberId = (String) session.getAttribute("name");
		if(memberId.equals(oneMember)) {
			oneDao.delete(oneNo);
			if(attachDto != null) {
				File target = new File(dir, String.valueOf(attachDto.getAttachNo()));//저장할 파일
				target.delete();
				
				attachDao.delete(attachDto.getAttachNo());
			}
			
			return "redirect:list";
		}
		else {
//			throw new AuthorityException("글 작성자가 아닙니다");
			return"redirect:에러페이지주소";
	 }
	}
	//수정
	@GetMapping("/edit")
	public String edit(@RequestParam int oneNo, Model model, HttpSession session) {
		String memberId=(String) session.getAttribute("name");
		OneDto oneDto = oneDao.selectOne(oneNo);
		log.debug("oneDto={}",oneDto);
		if(oneDto.getOneMember().equals(memberId)) {
			model.addAttribute("OneDto",oneDto);
			return"one/edit";
		}
		else {
//			throw new NoTargetException();
			return"redirect:에러페이지주소";
		}
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute OneDto oneDto, HttpSession session,@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		String memberId=(String) session.getAttribute("name");
		OneDto findDto = oneDao.selectOne(oneDto.getOneNo());
		if(findDto.getOneMember().equals(memberId)) {
			boolean result =oneDao.update(oneDto);
			if(result) {
				if(!attach.isEmpty()) {
					AttachDto attachDto = oneDao.findImage(oneDto.getOneNo());
					
					if(attachDto != null) {
						attachDao.delete(attachDto.getAttachNo());
						
						File target = new File(dir, String.valueOf(attachDto.getAttachNo()));//저장할 파일
						target.delete();
					}
					 int attachNo = attachDao.sequence();
					 
					 File insertTarget = new File(dir, String.valueOf(attachNo));//저장할 파일
					 attach.transferTo(insertTarget);
					 
					 AttachDto insertDto = new AttachDto();
					 insertDto.setAttachNo(attachNo);
					 insertDto.setAttachName(attach.getOriginalFilename());
					 insertDto.setAttachSize(attach.getSize());
					 insertDto.setAttachType(attach.getContentType());
					 attachDao.insert(insertDto);
					 
					 oneDao.connect(oneDto.getOneNo(), attachNo);
				}
				return"redirect:detail?oneNo="+oneDto.getOneNo();
			}
			else {
				return"redirect:에러페이지주소?oneNo=" + oneDto.getOneNo();
			}
		}
		else {
			return"redirect:에러페이지주소?oneNo=" + oneDto.getOneNo();
//			throw new AuthorityException("존재하지 않는 글 번호");
		}
			
	}
	
	
	
}
