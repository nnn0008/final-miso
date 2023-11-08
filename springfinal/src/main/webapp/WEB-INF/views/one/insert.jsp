<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<form method="post" action="insert" autocomplete="off">
	<div class="container">
		<div class="row mt-4">
			<div class="col">
				새글 작성
			</div>
		</div>
		
		<div class="row mt-4">
			<div class="col">
				<input type="text" name="oneTitle" class="form-control" placeholder="제목">
			</div>
		</div>
		
		<div class="row p-3">
			<div class="col">
				<textarea name="oneContent" class="form-control" placeholder="내용" rows="10" cols="50"></textarea>
			</div>
		</div>
		
		<div class="row p-3">
			<div class="col">
				<button type="submit" class="btn  btn-info w-100 mt-3">등록</button>
			</div>
		</div>
		
		
		
		
		
		
	</div>
	</form>













<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

