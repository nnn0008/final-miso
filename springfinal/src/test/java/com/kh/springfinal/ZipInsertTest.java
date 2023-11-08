package com.kh.springfinal;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.kh.springfinal.dao.ZipCodeDao;
import com.kh.springfinal.dto.ZipCodeDto;

@SpringBootTest
public class ZipInsertTest {
	
	@Autowired
	private ZipCodeDao zipCodeDao;
	
	@Test
	public void test() throws FileNotFoundException {
		File target = new File("C:\\Users\\user1\\Downloads\\zipcode_DB\\경기도.txt");
		Scanner sc = new Scanner(target);
		
		String patternStr = "(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)";
		Pattern pattern = Pattern.compile(patternStr);
		
		List<AddressDto> list = new ArrayList<>();
		
		while(sc.hasNextLine()) {
			String line = sc.nextLine();//한줄 읽고
			Matcher matcher = pattern.matcher(line);//패턴으로 분석
			if(matcher.find()) {//패턴을 찾았으면
//				for(int i=0; i < 26; i++) {
//					//System.out.println("group " + i + " = " + matcher.group(i));
//				}
				list.add(AddressDto.builder()
							.sido(matcher.group(2))
							.sigungu(matcher.group(4))
							.eupmyun(matcher.group(6))
							.doro(matcher.group(9))
							.buildName(matcher.group(16))
							.dongName(matcher.group(18))
							.hdongName(matcher.group(20))
						.build());
				
				zipCodeDao.insert(ZipCodeDto.builder()
						.sido(matcher.group(2))
						.sigungu(matcher.group(4))
						.eupmyun(matcher.group(6))
						.doro(matcher.group(9))
						.buildName(matcher.group(16))
						.dongName(matcher.group(18))
						.hdongName(matcher.group(20))
						.build());
			}
		}
		
		sc.close();

		
	}
}
