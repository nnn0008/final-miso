<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<h1>결제 내역</h1>

<!-- 전체 목록 -->
<c:forEach var="paymentListVO" items="${list}">

<div style="border:1px solid black; margin:30px 0px; padding:10px">

	<!-- 대표 정보 -->
	<div style="border:1px solid blue; padding:10px">${paymentListVO.paymentDto}
	<hr>
	<%--전체취소 버튼은 잔여금액이 있을 떄만 출력되어야 한다 --%>
	<c:if test="${paymentListVO.paymentDto.paymentRemain > 0 }">
	<a href="cancelAll?paymentNo=${paymentListVO.paymentDto.paymentNo}">전체(잔여)금액 취소</a>
	</c:if>
	</div>
	
	<!-- 상세 목록 정보 -->
	<div style="border:1px solid red; padding:10px; margin-top:10px">
		<c:forEach var="paymentDetailDto" items="${paymentListVO.paymentDetailList}">
			<div style="border:1px solid gray; padding:10px; margin-top:10px;">
				${paymentDetailDto}
				<hr>
				
				<%--취소가 가능한 상황일 경우에만 개별내역취소 버튼을 출력--%>
				<c:if test="${paymentDetailDto.paymentDetailStatus == '완료'}">
				<a href="cancel?paymentDetailNo=${paymentDetailDto.paymentDetailNo}">
					개별내역취소
				</a>
				</c:if>
			</div>
		</c:forEach>
	</div>
	
</div>
</c:forEach>


<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>