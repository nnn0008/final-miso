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
.categori-text{
font-size: 13px;
}
</style>
 
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // 동호회 설명 길이 제한 함수
        function truncateClubDescription() {
            const clubDescriptions = document.querySelectorAll('.club-explain');

            clubDescriptions.forEach(function (description) {
                const maxLength = 30; // 최대 길이 설정
                const text = description.textContent;

                if (text.length > maxLength) {
                    description.textContent = text.substring(0, maxLength) + '...';
                }
            });
        }

        // 페이지 로드 시 동호회 설명 길이 제한 실행
        truncateClubDescription();
    });
</script>


<div class="container text-center">
    <div class="row align-items-start">
        <c:forEach var="majorCategory" items="${categoryList}" varStatus="loopStatus">
            <div class="col-2 clickable-category">
                <a href="list2?majorCategoryNo=${majorCategory.majorCategoryNo}" 
                class="d-flex flex-column align-items-center link-underline link-underline-opacity-0 link-dark">
                    <div class="icon-container">
                        <img src="../images/${majorCategory.imageName}" alt="${majorCategory.majorCategoryName} icon">
                    </div>
                    <span class="mt-2 categori-text">${majorCategory.majorCategoryName}</span>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<hr>
		
	 <div class="row">
                            <div class="col text-start d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2 main-text">추천 동호회</strong>
                            </div>
                        </div>
<div class="text-center">
    <span class="badge bg-miso mt-3">${memberPreferList[0].memberName}</span>님의 주소 
    <span class="badge bg-success">${memberPreferList[0].sido}</span>
    지역을 중심으로 한 카테고리 동호회<br>
    <c:forEach var="memberPrefer" items="${memberPreferList}">
        <span class="badge bg-info mt-2">${memberPrefer.majorCategoryName}</span>
    </c:forEach>
</div>

	
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
            <span class="club-explain ">${clubListVO.clubExplain}</span>
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