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
		  <div class="col text-start d-flex align-items-center ms-3 mt-3">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2">1대 1 문의</strong>
                            </div>
                            
                      </div>
			<div class="col mt-4">
				<table class="table table-rounded">
						<tr>
						<td><i class="fa-solid fa-pen"></i> ${OneDto.oneTitle}</td>
						</tr>
						<tr>
						<td><i class="fa-solid fa-user"></i> ${OneDto.oneMember}</td>
						</tr>
						<tr>
						<td><i class="fa-regular fa-calendar"></i> ${OneDto.oneDate}</td>
						</tr>
					<td height="350px" style="background-color:#ACCEFF;">${OneDto.oneContent}</td>
					
				</table>
				
			</div>
		</div>
		<%-- 각종 버튼이 위치하는 곳 --%>
	<div class="row mt-4">
	<div class="col text-end">
		<%-- 회원일 때만 글쓰기,수정,삭제가 나와야 한다 --%>
		<c:if test="${sessionScope.name != null}">
		<a class="btn btn-outline-success" href="insert">
			<i class="fa-solid fa-pen"></i>
			새글
		</a>
		<a class="btn btn-outline-info" href="insert?oneParent=${OneDto.oneNo}">
			<i class="fa-solid fa-reply"></i>
			답글
		</a>
		
		<%-- 수정/삭제는 소유자일 경우만 나와야 한다 --%>
		<c:if test="${sessionScope.name == OneDto.oneMember}">
		<a class="btn btn-outline-warning" href="edit?oneNo=${OneDto.oneNo}">
		<i class="fa-solid fa-eraser"></i>
			수정
		</a>
		<a class="btn btn-outline-danger" href="delete?oneNo=${OneDto.oneNo}">
		<i class="fa-solid fa-trash-can"></i>
			삭제
		</a>
		</c:if>
		</c:if>
		<a class="btn btn-outline-light" href="list">
		<i class="fa-solid fa-bars"></i>
			목록
		</a>
	</div>
	</div>
	
		<div class="row mt-4">
			<div class="col">
				<img src="${pageContext.request.contextPath}/one/image?oneNo=${OneDto.oneNo}" width="200" height="200">
			</div>
		</div>
	</div>







	<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>