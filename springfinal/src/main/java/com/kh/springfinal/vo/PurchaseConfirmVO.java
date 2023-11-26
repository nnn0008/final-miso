package com.kh.springfinal.vo;

import com.kh.springfinal.dto.ClubDto;
import com.kh.springfinal.dto.ProductDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//구매 확인을 위해 정보를 한번 더 출력하는 용도
@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class PurchaseConfirmVO {
	private PurchaseVO purchaseVO;
	private ProductDto productDto;
	private ClubDto clubDto;
	
	public int getTotal() {
		return purchaseVO.getQty() * productDto.getProductPrice();
	}
}
