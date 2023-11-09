<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>


	<form method="post" action="insert" autocomplete="off">
	<%-- 답글일 때만 추가 정보를 전송 --%>
	<c:if test="${isReply}">
	<input type="hidden" name="oneParent" value="${originDto.oneNo}">
	</c:if>
	<div class="container">
		<div class="row mt-4">
			<div class="col">
				<c:choose>
	            <c:when test="${isReply}">
					<h1>답글 작성</h1>
				</c:when>
				<c:otherwise>
					<h1>게시글 작성</h1>
				</c:otherwise>
            </c:choose>
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
			<c:choose>
				<c:when test="${isReply}">
				<input type="text" name="oneTitle" class="form-control" placeholder="제목" value="RE:${orginDto.oneTitle}">
				</c:when>
				<c:otherwise>
				<input type="text" name="oneTitle" class="form-control" placeholder="제목" >
				</c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class="row mt-4">
			<div class="col">
				<textarea name="oneContent" class="form-control" placeholder="내용" rows="10" cols="80"></textarea>
			</div>
		</div>
		
		<div class="row mt-4">
			<div class="col">
				<button type="submit" class="btn  btn-info w-100 mt-3">
				<i class= "fa-solid fa-pen"></i>
				등록
				</button>
			</div>
		</div>
		
		
		
		
		
		
	</div>
	</form>













<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>

