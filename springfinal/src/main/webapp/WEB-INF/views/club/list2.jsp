<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
    
   <div class="container text-center">
  <div class="row px-3">
    <c:forEach var="category" items="${categoryList}">
      <div class="col-2 mb-2">
        <a href="list3?minorCategoryNo=${category.minorCategoryNo}"><span class="badge text-bg-info">${category.minorCategoryName}</span></a>
      </div>
    </c:forEach>
  </div>
</div>
<hr>
<h1>${clubList[0].majorCategoryName} 동호회 리스트</h1>
	<c:forEach var="clubListVO" items="${clubList}">
	<div class="row">
		<div class="col">
		<img src="${pageContext.request.contextPath}/club/image?clubNo=${clubListVO.clubNo}" class="rounded-circle" width="100" height="100">
		클럽 이름 : ${clubListVO.clubName}
		클럽 설명 : ${clubListVO.clubExplain}
		지역 : ${clubListVO.sigungu}
		카테고리 이름 : ${clubListVO.majorCategoryName}
		멤버 수 : ${clubListVO.memberCount}
		</div>
	</div>
	</c:forEach>





    
    
       <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>