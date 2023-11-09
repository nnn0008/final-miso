<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

	<div class="container">
		<div class="row mt-4">
			<div class="col">
				<h2>1대1 문의</h2>			
			</div>		
		</div>
		
		<div class="row mt-4">
			<div class="col">
				<table class="table table-hover">
					<thead>
						<tr class="table-secondary">
							<th>카테고리</th>
							<th>게시글번호</th>
							<th width="30%">제목</th>
							<th >작성일</th>
							<th>작성자</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="OneDto" items="${list}">
						<tr class="table-secondary">
							<td>${OneDto.oneCategory}</td>
							<td>${OneDto.oneNo}</td>
							<td class="text-left">
							<%-- for(int i=1; i <= 차수; i++) { --%>
							<c:forEach var="i" begin="1" end="${OneDto.oneDepth}" step="1">
							&nbsp;&nbsp;
							</c:forEach>
						
							<%-- 띄어쓰기 뒤에 화살표 표시 --%>
							<c:if test="${OneDto.oneDepth > 0}">
								<i class="fa-solid fa-reply fa-rotate-180"></i>
							</c:if>
							<a href="detail?oneNo=${OneDto.oneNo}">${OneDto.oneTitle}</a>
							</td>
							<td>${OneDto.oneDate}</td>
							<td>${OneDto.oneMember}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	
	
	
	
	<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>