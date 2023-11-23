<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
  <link href="${pageContext.request.contextPath}/css/club.css" rel="stylesheet"> 
  
  <style>

     .badge.bg-miso{
     font-size: 16px;
     }
     
     .badge.rounded-pill.bg-gray{
     font-size: 14px;
     }
    
</style>
    
  <c:choose>
<c:when test="${empty clubList}">
<div class="row d-flex align-items-center mt-3">
                                <div class="col-3 text-start">
                                    <img src="${pageContext.request.contextPath}/images/open-door.png" width="100%">
                                </div>
                                <div class="col">
                                	<div class="col">
                                    <h5>해당 카테고리 동호회가 존재하지 않습니다. </h5>
                                	</div>
                                	<div class="col">
                                    <h1>직접 만들어보세요!</h1>
                                	</div>
                                </div>
                            </div>
<div class="row p-1 mt-4 text-center">
                        <div class="col">
                            <a href="/club/insert" class="badge rounded-pill bg-miso btn-miso p-3 link w-100">
                                모임 만들기
                            </a>
                        </div>
                    </div>
</c:when>
<c:otherwise>
<div class="col text-start d-flex align-items-center mb-3 mt-3">
            <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
            
            <span class="badge bg-miso ms-2">${clubList[0].minorCategoryName}</span>
            <strong class="ms-2 main-text">동호회 리스트</strong>
        </div>
</c:otherwise>
</c:choose>

	<c:forEach var="clubListVO" items="${clubList}">
	
	<div class="row mt-4 mb-3 d-flex align-items-center club-box" onclick="location.href='/club/detail?clubNo=${clubListVO.clubNo}'">
    <div class="col-2">
        <div class="d-flex align-items-center">
            <c:choose>
                <c:when test="${clubListVO.attachNo!=0}">
                    <img src="${pageContext.request.contextPath}/club/image?clubNo=${clubListVO.clubNo}"
                        width="80" height="80" class="club-image-list">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/basic-profile2.png"
                        width="80" height="80">
                </c:otherwise>
            </c:choose>

            <span class="badge rounded-pill bg-danger badge-new ms-2">NEW</span>
        </div>
    </div>
    <div class="col-10">
        <div class="col">
            <strong class="club-name">${clubListVO.clubName}</strong>
        </div>
        <div class="col mt-1">
            <span class="club-explain">${clubListVO.clubExplain}</span>
        </div>
        <div class="col mt-1">
            <strong class="club-sidos">${clubListVO.sido} ${clubListVO.sigungu}</strong> |
            <span class="club-member">멤버 ${clubListVO.memberCount}</span> |
            <span class="badge bg-info">${clubListVO.majorCategoryName}</span>
            <span class="badge rounded-pill bg-gray">${clubListVO.minorCategoryName}</span>
        </div>
    </div>
</div>
	
	
<!-- 	<div class="row"> -->
<!-- 		<div class="col"> -->
<!--        <div class="alert alert-dismissible alert-light"> -->
<%-- 		<a href="/club/detail?clubNo=${clubListVO.clubNo}"> --%>
<%-- 		<c:choose> --%>
<%-- 		<c:when test="${clubListVO.attachNo!=0}"> --%>
<%-- 		<img src="${pageContext.request.contextPath}/club/image?clubNo=${clubListVO.clubNo}" class="rounded-circle" width="100" height="100"> --%>
<%-- 		</c:when> --%>
<%-- 		<c:otherwise> --%>
<%-- 		<img src="${pageContext.request.contextPath}/images/basic-profile.png" class="rounded-circle" width="80" height="80"> --%>
<%-- 		</c:otherwise> --%>
<%-- 		</c:choose> --%>
<!-- 		</a> -->
<%-- 		<div>클럽 이름 : ${clubListVO.clubName}</div> --%>
<!-- 		<div>클럽 설명 :  -->
<!-- 			<span class="d-inline-block text-truncate" style="max-width: 550px;"> -->
<%--   				${clubListVO.clubExplain} --%>
<!-- 						</span> -->
<!-- 			</div> -->
<%-- 		<div>${clubListVO.sido} ${clubListVO.sigungu}</div> --%>
<%-- 		<div>${clubListVO.majorCategoryName}-${clubListVO.minorCategoryName}</div> --%>
<%-- 		<div>멤버 수 : ${clubListVO.memberCount}</div> --%>
<!--          </div> -->
<!--           </div> -->
		
		
	</div>
	</c:forEach>





    
    
       <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>