<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
    
    
    

	<div class="container text-center">
  <div class="row align-items-start">
  <c:forEach var="majorCategory" items="${categoryList}" varStatus="loopStatus">
    <div class="col-3">
      <a href="list2?majorCategoryNo=${majorCategory.majorCategoryNo}"><img src="../images/${majorCategory.imageName}" width="30%"></a>
      ${majorCategory.majorCategoryName}
    </div>
  </c:forEach>
    </div>
</div>
<hr>
		
	<h1>추천 동호회 리스트</h1>
	
	<div>
	${memberPreferList[0].memberName}님의 주소 '${memberPreferList[0].sido}' 지역을 중심으로 한 
	<c:forEach var = "memberPreferList" items="${memberPreferList}">
		<${memberPreferList.majorCategoryName}>
	</c:forEach>
	카테고리 동호회 결과
	</div>
	
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
		<img src="${pageContext.request.contextPath}/images/basic-profile.png" class="rounded-circle" width="80" height="80">
		</c:otherwise>
		</c:choose>
		</a>
		<div>클럽 이름 : ${clubListVO.clubName}</div>
		<div>클럽 설명 : 
			<span class="d-inline-block text-truncate" style="max-width: 550px;">
  				${clubListVO.clubExplain}
						</span>
			</div>
		<div>${clubListVO.sido} ${clubListVO.sigungu}</div>
		<div>${clubListVO.majorCategoryName}-${clubListVO.minorCategoryName}</div>
		<div>멤버 수 : ${clubListVO.memberCount}</div>
         </div>
          </div>
		
		
	</div>
	</c:forEach>




 
    
    
    
    
    
    
      <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>