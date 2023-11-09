<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
	<form method="post" action="insert" autocomplete="off">
	<div class="container">
		<div class="row mt-4">
			<div class="col">
				<h2>새글 작성</h2>
			</div>
		</div>
		
		<div class="row mt-4">
			<div class="col">
				<select name="oneCategory" required class="form-control">
					<option  disabled selected hidden>종류를 선택해주세요.</option>
					<option>회원</option>
					<option>동호회</option>
					<option>신고</option>
					<option>고소</option>
					<option>결제</option>
					<option>기타문의</option>
				</select>
			</div>
		</div>
		
		<div class="row mt-4">
			<div class="col">
				<input type="text" name="oneTitle" class="form-control" placeholder="제목">
			</div>
		</div>
		
		<div class="row mt-4">
			<div class="col">
				<textarea name="oneContent" class="form-control" placeholder="내용" rows="10" cols="80"></textarea>
			</div>
		</div>
		
		<div class="row mt-4">
			<div class="col">
				<button type="submit" class="btn  btn-info w-100 mt-3">등록</button>
			</div>
		</div>
		
		
		
		
		
		
	</div>
	</form>













<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>

