<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<h1>정기결제 내역</h1>

<!-- 전체 목록 -->
<c:forEach var="paymentRegularListVO" items="${list2}">

<div style="border:1px solid black; margin:30px 0px; padding:10px">

	<!-- 대표 정보 -->
	<div style="border:1px solid blue; padding:10px">${paymentRegularListVO.paymentRegularDto}
	<hr>
	<%--전체취소 버튼은 잔여금액이 있을 떄만 출력되어야 한다 --%>
	<c:if test="${paymentRegularListVO.paymentRegularDto.paymentRegularRemain > 0 }">
	<a href="regularCancelAll?paymentRegularNo=${paymentRegularListVO.paymentRegularDto.paymentRegularNo}">구독 취소</a>
	</c:if>
	</div>
	
</div>
</c:forEach>


<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>