package com.kh.springfinal.vo;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Data
public class HomeForMeetingVO {
	private int meetingNo;
	private String meetingName;
	private String meetingLocation;
	private int clubNo;
	private String meetingDate;
	private String dday;
	private String clubName;
	private Integer attachNo;
	private boolean attended;
	
	 public String getFormattedMeetingDate() throws ParseException {
        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat newFormat = new SimpleDateFormat("MM월 dd일 HH시 mm분");

       Date date = originalFormat.parse(meetingDate);
	      
       return newFormat.format(date);   
	 }

    public String getFormattedDday() {
        double number = Double.parseDouble(dday);
        int roundedNumber = (int) Math.ceil(number);
        DecimalFormat decimalFormat = new DecimalFormat("#,###");        	
        return decimalFormat.format(roundedNumber);
    }
    
    public String getCalculateDday() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

	    LocalDate currentDate = LocalDate.now();
	    LocalDate meetingLocalDate = LocalDate.parse(this.meetingDate, formatter);
	    
	    // 날짜 차이 계산
	    long dday = ChronoUnit.DAYS.between(currentDate, meetingLocalDate);
	    
	    if(dday == 0) {
	    	return "오늘";
	    }
	    else if(dday > 0) {
	    	return dday + "일 남음";
	    }
	    else {
	    	return "지나간 정모";
	    }
    }
    
}
