<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
	
	<form action="edit" method="post">
		<input type="hidden" name="oneNo" value="${OneDto.oneNo}">
	<div class="container">
		<div class="row mt-4">
			<div class="col">
			<table class="table">
				<tr>
					<th>카테고리</th>
					<th>
						<select name="oneCategory" required class="form-select">
					    <option disabled hidden>종류를 선택해주세요.</option>
					    <option value="회원" ${OneDto.oneCategory == '회원' ? 'selected' : ''}>회원</option>
					    <option value="동호회" ${OneDto.oneCategory == '동호회' ? 'selected' : ''}>동호회</option>
					    <option value="신고" ${OneDto.oneCategory == '신고' ? 'selected' : ''}>신고</option>
					    <option value="고소" ${OneDto.oneCategory == '고소' ? 'selected' : ''}>고소</option>
					    <option value="결제" ${OneDto.oneCategory == '결제' ? 'selected' : ''}>결제</option>
					    <option value="기타문의" ${OneDto.oneCategory == '기타문의' ? 'selected' : ''}>기타문의</option>
						</select>
					</th>
				</tr>
				<tr>
					<th>제목</th>
					<td>
					<input type="text" name="oneTitle" required class="form-control" value="${OneDto.oneTitle}">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
					<input type="text" name="oneContent" required class="form-control" value="${OneDto.oneContent}">
					</td>
				</tr>
			</table>
		</div>
		</div>
					<div class="row mt-4">
				<div class="row">
					<button type="submit" class="btn btn-success">수정</button>
				</div>
			</div>
	</div>
	</form>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>