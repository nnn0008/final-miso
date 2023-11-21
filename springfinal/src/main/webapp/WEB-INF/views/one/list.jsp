<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<script>
    function goToDetail(oneNo) {
        window.location = 'detail?oneNo=' + oneNo;
    }
</script>
    <style>
.pagination .page-link, .pagination .page-item.active .page-link {
    background-color: #ACCEFF;
}


    </style>
	<div class="container">
	<div class="row mt-4">
                            <div class="col text-start d-flex align-items-center ms-3 mt-3">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2">1대 1 문의</strong>
                            </div>
                        </div>
		
		<c:if test="${vo.search}">
	<div class="row mt-4">
	<div class="col">
		&quot;${vo.keyword}&quot;에 대한 검색 결과
		</div>
	</div>
	</c:if>
		
		<div class="row mt-4">
			<div class="col">
				<table class="table table-hover">
					<thead>
						<tr class="table-secondary">
							<th style="background-color:#ACCEFF;">카테고리</th>
							<th style="background-color:#ACCEFF;">게시글번호</th>
							<th  style="background-color:#ACCEFF;" width="30%">제목</th>
							<th  style="background-color:#ACCEFF;">작성일</th>
							<th  style="background-color:#ACCEFF;">작성자</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="OneDto" items="${list}">
						<tr class="table-secondary" onclick="goToDetail(${OneDto.oneNo})" style="cursor: pointer;">
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
							${OneDto.oneTitle}
							</td>
							<td>${OneDto.oneDate}</td>
							<td>${OneDto.oneMember}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 페이지네이션 -->
		<div class="row mt-4">
   		 <div class="col">
			       <ul class="pagination pagination-md justify-content-center">
			   			<!-- 이전 버튼 -->
		<c:if test="${!vo.first}">
			<li class="page-item">
				<a class="page-link" href="list?${vo.prevQueryString}">&laquo;</a>
			</li>
		</c:if>
		
		<!-- 네비게이터 버튼 -->
		<c:forEach var="i" begin="${vo.begin}" end="${vo.end}" step="1">
			<li class="page-item ${i eq vo.page ? 'active' : ''}">
				<a class="page-link" href="list?${vo.getQueryString(i)}">${i}</a>
			</li>
		</c:forEach>
		
		<!-- 다음 버튼 -->
		<c:if test="${!vo.last}">
			<li class="page-item">
				<a class="page-link" href="list?${vo.nextQueryString}">&raquo;</a>
			</li>
		</c:if>

			  			</ul>
    		</div>
		</div>
<!-- 검색창 -->
<form action="list" method="get">
    <div class="row mt-4 justify-content-center">
        <div class="col-3 p-1">
            <div class="input-group">
                <c:choose>
                    <c:when test="${param.type == 'one_member'}">
                        <select name="type" required class="form-select rounded-pill">
                            <option value="one_title">제목</option>
                            <option value="one_member" selected>작성자</option>
                        </select>
                    </c:when>
                    <c:otherwise>
                        <select name="type" required class="form-select rounded-pill">
                            <option value="one_title">제목</option>
                            <option value="one_member">작성자</option>
                        </select>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="col-9 p-1">
            <div class="input-group">
                <input type="search" name="keyword" class="form-control rounded-pill me-2"  placeholder="검색어 입력" value="${param.keyword}">
                <div class="input-group-append">
                    <button type="submit" name="search" class="btn btn-outline-primary rounded-pill">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</form>

		
	</div>
	
	
	
	
	
	<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>