<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

		<form method="post" action=""> 
	<div class="row m-2 mt-4">
		

		<div class="row">
			<div class="col">
				게시글 카테고리
				<select name="clubBoardCategory" class="form-select mt-2">
					<option>자유</option>
					<option>관심사</option>
					<option>모임후기</option>
					<option>가입인사</option>
					<option>공지사항</option>
				</select>
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-12">
				<input type="text" class="form-control w-100" placeholder="제목(40자)">
			</div>
		</div>
	
		<div class="row mt-2">
			<div class="col-12">
				<hr>
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-12">
				<textarea class="form-control w-100" placeholder="내용" rows="10"></textarea>
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-6">
				<label>게시글 상위고정
				<input type="checkbox" class="text-end">
				</label>
			</div>
			<div class="col-6 text-end">
				0 / 1300
			</div>
		</div>
		
		<div class="row mt-4">
			<div class="col-12">
				여기에 파일첨부
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-12">
				<button type="submit" class="btn btn-success w-100">작성하기</button>
			</div>
		</div>
		
	
	</div>
		</form> 

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>