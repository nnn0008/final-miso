<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <!-- 부트스트랩 CDN -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/zephyr/bootstrap.min.css" rel="stylesheet">
    <!-- 스타일시트 로딩 코드 -->
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
    <link href="${pageContext.request.contextPath}/css/misolayout.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/miso.css" rel="stylesheet">
    
    
 <!-- 왼쪽 사이드바 -->
            <aside class="left-sidebar">
                   
                    <div class="row mt-4">
                        <div class="col">
                            <div class="col d-flex justify-content-center">
                                <c:choose>
			                    	<c:when test="${sessionScope.name==null}">
		                                <img src="${pageContext.request.contextPath}/images/avatar50.png" width="35%">
			                    	</c:when>
			                    	<c:otherwise>
				                        <img src="/rest/member/profileShow?memberId=${sessionScope.name}" class="rounded-circle profile" style="width:80px; height: 80px;">
			                    	</c:otherwise>
			                    </c:choose>
                            </div>
                            <div class="col d-flex justify-content-center mt-3">
                            	<c:choose>
                            	<c:when test="${sessionScope.memberLevel=='일반유저'}">
                            	<span class="badge rounded-pill bg-miso">일반</span>
                            	</c:when>
                            	<c:when test="${sessionScope.memberLevel=='파워유저'}">
                            	<span class="badge bg-success rounded-pill bg-miso">파워</span>
                            	</c:when>
                            	<c:otherwise>
                            	<span class="badge bg-primary rounded-pill">마스터</span>
                            	</c:otherwise>
                            	</c:choose>
                               <strong class="ms-1">${sessionScope.memberName}</strong>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-3 p-2 align-items-center">
                        <div class="col">
                            <a href="/" class="link d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/images/Vector-3.png" width="20%">
                                <strong class="ms-3">홈</strong> 
                            </a>
                        </div>
                    </div>

                    <div class="row p-2 align-items-center">
                        <div class="col">
                            <a href="/club/list" class="link d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/images/Vector.png" width="20%">
                                <strong class="ms-3">모임 찾기</strong> 
                            </a>
                        </div>
                    </div>

                    <div class="row p-2 align-items-center">
                        <div class="col">
                            <a href="/chat/roomList" class="link d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/images/Vector-1.png" width="20%">
                                <strong class="ms-3">채팅</strong> 
                            </a>
                        </div>
                    </div>

                    <div class="row p-2 align-items-center">
                        <div class="col">
                            <a href="/member/mypage?memberId=${sessionScope.name}" class="link d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/images/Vector-2.png" width="20%">
                                <strong class="ms-3">프로필</strong>
                            </a>
                        </div>
                    </div>

                    <div class="row p-1 mt-4">
                        <div class="col">
                            <a href="/club/insert" class="badge rounded-pill bg-miso btn-miso p-3 link">
                                모임 만들기
                            </a>
                        </div>
                    </div>

<!--                     <div class="row mt-4"> -->
<!--                         <div class="col text-center d-flex align-items-center justify-content-center login"> -->
<%--                             <a href="${pageContext.request.contextPath}/member/login" class="link"> --%>
<%--                                 <img src="${pageContext.request.contextPath}/images/Vector-4.png" width="20%"> --%>
<%--                                 <c:choose> --%>
<%--                                 	<c:when test="${sessionScope.name!=null}"> --%>
<!-- 										<strong class="ms-2">로그아웃</strong> -->
<%--                                 	</c:when> --%>
<%--                                 	<c:otherwise> --%>
<!-- 		                                <strong class="ms-2">로그인</strong>   -->
<%--                                 	</c:otherwise> --%>
<%--                                 </c:choose> --%>
<!--                             </a> -->
<!--                         </div> -->
<!--                     </div> -->
                    
     </aside>
     
     <article class="main-content">