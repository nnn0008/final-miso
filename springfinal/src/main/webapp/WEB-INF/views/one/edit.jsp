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