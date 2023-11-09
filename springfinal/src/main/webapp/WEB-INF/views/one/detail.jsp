<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<style>
    .table-rounded {
        border-radius: 10px;
        overflow: hidden; 
    }
</style>


	<div class="container">
		<div class="row mt-4">
			<div class="col">
				<table class="table table-rounded">
					<tr>
						<th>제목</th>
						<td>${OneDto.oneTitle}</td>
						</tr>
						<tr>
						<th>내용</th>
						<td>${OneDto.oneContent}</td>
						</tr>
						<tr>
						<th>작성자</th>
						<td>${OneDto.oneMember}</td>
						</tr>
						<tr>
						<th>작성일</th>
						<td>${OneDto.oneDate}</td>
						</tr>
				</table>
			</div>
		</div>
		<%-- 각종 버튼이 위치하는 곳 --%>
	<div class="row mt-4">
	<div class="col">
		<%-- 회원일 때만 글쓰기,수정,삭제가 나와야 한다 --%>
		<c:if test="${sessionScope.name != null}">
		<a class="btn btn-positive" href="insert">
			<i class="fa-solid fa-pen"></i>
			새글
		</a>
		<a class="btn btn-positive" href="insert?oneParent=${OneDto.oneNo}">
			<i class="fa-solid fa-pen"></i>
			답글
		</a>
		
		<%-- 수정/삭제는 소유자일 경우만 나와야 한다 --%>
		<c:if test="${sessionScope.name == OneDto.oneMember}">
		<a class="btn btn-negative" href="edit?oneNo=${OneDto.oneNo}">
		<i class="fa-solid fa-pen"></i>
			수정
		</a>
		<a class="btn btn-negative" href="delete?oneNo=${OneDto.oneNo}">
		<i class="fa-solid fa-pen"></i>
			삭제
		</a>
		</c:if>
		</c:if>
		<a class="btn" href="list">
		<i class="fa-solid fa-pen"></i>
			목록
		</a>
	</div>
	</div>
	</div>







	<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>