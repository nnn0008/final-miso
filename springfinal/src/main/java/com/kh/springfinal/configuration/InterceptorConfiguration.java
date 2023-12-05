package com.kh.springfinal.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.springfinal.interceptor.BoardInterceptor;
import com.kh.springfinal.interceptor.ChatRoomIntercepter;
import com.kh.springfinal.interceptor.HomeInterceptor;
import com.kh.springfinal.interceptor.MemberInterceptor;

/**
 	스프링에서 제공하는 설정파일
 	- application.properties에서 설정할 수 없는 내용들을 설정하는 파일
 	
 	만드는 법
 	1. 등록(@Configuration)
 	2. 필요시 상속(WebMvcConfigurer)
 	3. 상황에 맞는 메소드 재정의 및 코드 작성
 */
@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer{
	
	@Autowired
	private MemberInterceptor memberInterceptor;	
	
	@Autowired
	private ChatRoomIntercepter chatRoomIntercepter;
	
	@Autowired
	private HomeInterceptor homeInterceptor;
	
	@Autowired
	private BoardInterceptor boardInterceptor;
	
//	@Autowired
//	private ClubJoinInterceptor clubJoinInterceptor;
	
//	@Autowired
//	private ClubManagerInterceptor clubManagerInterceptor;
	
//	@Autowired
//	private ClubMemberInterceptor clubMemberInterceptor;
	
//	@Autowired
//	private ClubCreateInterceptor clubCreateInterceptor;
	
	//인터셉트를 추가할 수 있는 설정 메소드(registry 저장소에 설정)
	//등록 시 주소의 패턴 설정 방법
	//- *이 한 개면 동일한 엔드포인트 내에서만 적용
	//- *이 두 개면 하위 엔드포인트를 포함하여 적용
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
//		//[1] TestInterceptor를 모든 주소 처리과정에 간섭할 수 있도록 설정하겠다
//		registry.addInterceptor(testInterceptor)
//		.addPathPatterns("/**"); //몽땅. 전체 다 라는 뜻임
		
//		//[2] MemberInterceptor를 회원 전용 페이지 처리과정에 간섭할 수 있도록 설정
//		//- addPathPatterns를 사용하면 추가할 주소를 설정할 수 있다
//		//- excludePathPatterns를 사용하면 제외할 주소를 설정할 수 있다
//		registry.addInterceptor(memberInterceptor)
//		.addPathPatterns( 
//									"/**"
//				) //멤버로 시작하는 모든 주소는 검사하겠다 
//		.excludePathPatterns(
//				"/member/join*",
//				"/member/login*",
//				"/member/logout*",
//				"/member/search*",
//				"/member/exitFinish",
//				"/**/*.css", 
//				"/**/*.js",
//				"/images/**/*.*",
//				"/board/list",
//				"/board/detail*",
//				"/rest/reply/list",
//				"/rest/member/checkId",
//				"/rest/member/searchAddr",
//				"/rest/member/minorList"
//				); 
		
		registry.addInterceptor(chatRoomIntercepter)
		.addPathPatterns("/chat/enterRoom/**"
				);
		
		registry.addInterceptor(homeInterceptor)
		.addPathPatterns("/")
		.addPathPatterns("/club/detail");
		registry.addInterceptor(boardInterceptor)
		.addPathPatterns("/clubBoard/write")
		.addPathPatterns("/clubBoard/edit")
		.addPathPatterns("/photo/list")
		.addPathPatterns("/clubBoard/list")
		.addPathPatterns("/clubBoard/detail");
		
	}
}		

