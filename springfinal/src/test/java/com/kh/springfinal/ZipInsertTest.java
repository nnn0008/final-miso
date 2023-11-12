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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class ZipInsertTest {

    @Autowired
    private ZipCodeDao zipCodeDao;

    @Test
    public void test() throws FileNotFoundException {
        File target = new File("C:\\Users\\l08il\\zipcode_DB\\경기도.txt");
        Scanner sc = new Scanner(target);

        String patternStr = "(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)\\|(.*?)";
        Pattern pattern = Pattern.compile(patternStr);

        while (sc.hasNextLine()) {
            String line = sc.nextLine();
            Matcher matcher = pattern.matcher(line);
            if (matcher.find()) {
                AddressDto addressDto = AddressDto.builder()
                        .sido(matcher.group(2))
                        .sigungu(matcher.group(4))
                        .eupmyun(matcher.group(6))
                        .hdongName(matcher.group(20))
                        .build();
        
                log.debug("Inserted ZipCodeDto: {}", addressDto);
                
                

                try {
                    zipCodeDao.insert(ZipCodeDto.builder()
                            .sido(matcher.group(2))
                            .sigungu(matcher.group(4))
                            .eupmyun(matcher.group(6))
                            .hdongName(matcher.group(20))
                            .build());
                } catch (Exception e) {
                }
            }
            }
        

        sc.close();
    }

//    private boolean empty(String sido, String hdong, String sigungu, String eupmyun) {
//        try {
//            List<ZipCodeDto> list = zipCodeDao.selectList(sido, hdong, sigungu, eupmyun);
//            
//            log.debug("list: {}", list);
//            
//            return list.size() == 0;
//        } catch (Exception e) {
//            // 예외가 발생하면 로그에 출력
//            log.error("Exception while checking if data is empty", e.fillInStackTrace());
//            return false; // 또는 예외 발생 시 처리할 방식을 결정
//        }
//    }

    
}


