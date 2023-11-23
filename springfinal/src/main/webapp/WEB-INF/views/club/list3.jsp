<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
    
  <c:choose>
<c:when test="${empty clubList}">
<h3>해당 카테고리 동호회가 존재하지 않습니다. 직접 만들어보세요!</h3>
<a href="/club/insert">모임 만들기</a>
</c:when>
<c:otherwise>
<h1><${clubList[0].minorCategoryName}> 동호회 리스트</h1>
</c:otherwise>
</c:choose>

	<c:forEach var="clubListVO" items="${clubList}">
	<div class="row">
		<div class="col">
		<div class="alert alert-dismissible alert-light">
		<a href="/club/detail?clubNo=${clubListVO.clubNo}">
		<c:choose>
		<c:when test="${clubListVO.attachNo!=0}">
		<img src="${pageContext.request.contextPath}/club/image?clubNo=${clubListVO.clubNo}" class="rounded-circle" width="100" height="100">
		</c:when>
		<c:otherwise>
		<img src="${pageContext.request.contextPath}/images/noimage.jpg" class="rounded-circle" width="100" height="100">
		</c:otherwise>
		</c:choose>
		</a>
		<div>클럽 이름 : ${clubListVO.clubName}</div>
		<div>클럽 설명 : ${clubListVO.clubExplain}</div>
		<div>지역 :  ${clubListVO.sido} ${clubListVO.sigungu}</div>
		<div>카테고리 이름 : ${clubListVO.majorCategoryName}-${clubListVO.minorCategoryName}</div>
		<div>멤버 수 : ${clubListVO.memberCount}</div>
		</div>
		</div>
	</div>
	</c:forEach>





    
    
       <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>