package com.kh.springfinal.rest;

import java.text.DecimalFormat;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.messaging.MessagingException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springfinal.dao.CertDao;
import com.kh.springfinal.dto.CertDto;

@RestController
@RequestMapping("cert")
public class CertRestController {
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private JavaMailSender sender;
	
	@PostMapping("/send")
	public void send(@RequestParam String certEmail) throws MessagingException, javax.mail.MessagingException{
		//인증번호 생성
		Random r = new Random();
		int number = r.nextInt(1000000);
		DecimalFormat fm = new DecimalFormat("000000");
		String certNumber = fm.format(number);
		//이메일 발송
		MimeMessage message=sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		
		helper.setTo("hahanul987@gmail.com");
		helper.setSubject("[miso] 인증번호를 확인해주세요");
		//DB 저장
		certDao.delete(certEmail);
		CertDto certDto = new CertDto();
		certDto.setCertEmail(certEmail);
		certDto.setCertNumber(number);
		certDao.insert(certDto);
		
	}
}