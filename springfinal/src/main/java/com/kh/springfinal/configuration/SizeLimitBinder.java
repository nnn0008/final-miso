package com.kh.springfinal.configuration;

import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.support.WebBindingInitializer;

public class SizeLimitBinder implements WebBindingInitializer{
	@Override
	public void initBinder(WebDataBinder binder) {
		binder.setAutoGrowCollectionLimit(Integer.MAX_VALUE);
	}
}
