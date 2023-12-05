package com.kh.springfinal.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import lombok.extern.slf4j.Slf4j;

/**
 * 컨트롤러를 간섭하여 예외 상황을 다르게 처리하도록 하는 객체
 * - 등록 시 @ControllerAdvice라고 등록
 * - @RestController를 간섭할 경우는 @RestControllerAdvice 를 사용 
 * - 적용 대상을 옵션으로 지정
 */
@Slf4j
//@ControllerAdvice(basePackages = {"com.kh.springhome.controller"}) //배열이기 때문에 중괄호 사용
@ControllerAdvice(annotations = {Controller.class})
public class ExceptionControllerAdvice {
	/**
	 * 예외는 @ExceptionHandler 메소드로 처리가능
	 * - 처리할 예외의 종류 지정 가능
	 * - 메소드의 형태는 컨트롤러와 같음
	 * - try 구문의 catch 블록과 같은 역할을 수행
	 * - 이 메소드에는 컨트롤러처럼 매개변수를 선언하면 사용할 수 있다
	 * 		- Model, HttoSession 등 기본적인 컨트롤러의 도구 사용 가능
	 * 		- catch 처럼 예외 처리 객체를 선언할 수 있다
	 */
	
	@ExceptionHandler(Exception.class)
	public String error(Exception e) {
		//e.printStackTrace();
		//error 로그에는 예외 객체를 한 개 첨부시킬 수 있다(자동 print stack trace)
		log.error("오류",e);
		return "error/500";
	}
	
	/**
	 * 내가 지정한 예외들을 처리하도록 추가 핸들러(처리기) 설정
	 */
	
	@ExceptionHandler(NoTargetException.class)
	public String noTarget(NoTargetException e) {
		//e.printStackTrace();
		return "error/noTarget";
	}
	
	@ExceptionHandler(AuthorityException.class)
	public String authority(AuthorityException e) {
		e.printStackTrace();
		return "error/authority";
	}
	

}
