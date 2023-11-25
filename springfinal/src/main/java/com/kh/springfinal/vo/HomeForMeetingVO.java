package com.kh.springfinal.vo;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class HomeForMeetingVO {
	private int meetingNo;
	private String meetingName;
	private String meetingLocation;
	private int clubNo;
	private String meetingDate;
	private String dday;
	private String clubName;
	private int attachNo;
	
	 public String getFormattedMeetingDate() throws ParseException {
        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat newFormat = new SimpleDateFormat("MM월 dd일 HH시 mm분");

       Date date = originalFormat.parse(meetingDate);
	      
       return newFormat.format(date);   
	 }

    public String getFormattedDday() {
        double number = Double.parseDouble(dday);

        DecimalFormat decimalFormat = new DecimalFormat("#");
        return decimalFormat.format(number);
    }
}
