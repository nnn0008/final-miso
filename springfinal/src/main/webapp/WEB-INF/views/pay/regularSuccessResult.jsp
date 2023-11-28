<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<style>
.card{
width: 600px;
}
</style>

<div class="mt-4 p-4 bg-miso rounded">
	<h1>결제 완료</h1>
	<p class="mt-2">고객님의 주문에 대한 결제가 성공적으로 완료되었습니다</p>
</div>

 <div class="row d-flex align-items-center mt-3">
			<div class="row mt-2">
                <div class="col text-center">
                    <img src="${pageContext.request.contextPath}/images/logo-door.png" width="50%">
                </div>
                </div>

			<div class="col mt-3">
				<a href="${pageContext.request.contextPath}/member/mypage?memberId=${sessionScope.name}" class="btn btn-miso btn-lg w-100">마이페이지 가기</a>
			</div>
			</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>