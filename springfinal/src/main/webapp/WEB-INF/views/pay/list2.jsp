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
	
	<!-- 상세 목록 정보(못쓸듯) -->
	<div style="border:1px solid red; padding:10px; margin-top:10px">
		<c:forEach var="regularDetailDto" items="${paymentRegularListVO.regularDetailList}">
			<div style="border:1px solid gray; padding:10px; margin-top:10px;">
				${regularDetailDto}
				<hr>
				
				<%--취소가 가능한 상황일 경우에만 개별내역취소 버튼을 출력--%>
				<c:if test="${regularDetailDto.regularDetailStatus == '활성화'}">
			    <a href="regularCancel?regularDetailNo=${regularDetailDto.regularDetailNo}">
			        개별내역취소
			    </a>
				</c:if>
			</div>
		</c:forEach>
	</div>
	
</div>
</c:forEach>


<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>