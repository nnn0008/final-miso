package com.kh.springfinal.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

//application.properties에 등록한 커스텀 속성 중 custom.fileupload로 시작하는 설정을 불러오는 파일
@Data
@Component
@ConfigurationProperties(prefix="custom.fileupload")
public class FileUploadProperties {
	private String home;
}
