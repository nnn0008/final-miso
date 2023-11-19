package com.kh.springfinal.error;

import lombok.NoArgsConstructor;

/**
 * 대상이 없을 경우 발생하는 예외
 * 1. Exception을 상속받는다
 * 		-RuntimeExcption을 상속받으면 예외 전가를 작성하지 않아도 된다
 * 2. 기본생성자 메시지를 설정할 수 있는 생성자를 구현한다
 */
@NoArgsConstructor
public class NoTargetException extends RuntimeException{

	public NoTargetException(String message) {
		super(message);
	}

}
