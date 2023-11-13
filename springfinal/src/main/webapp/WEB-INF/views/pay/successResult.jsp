<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>


<div class="mt-4 p-4 text-light bg-dark rounded">
	<h1>결제 완료</h1>
	<p>고객님의 주문에 대한 결제가 성공적으로 완료되었습니다</p>
</div>

<div class="row mt-4">
	<div class="col">
		<div class="card">
			<div class="card-body">
				<h5 class="card-title">주문에 대한 결제번호는 <span class="text-danger text-bold">${paymentDto.paymentTid}</span> 입니다</h5>
				<p class="card-text">
					주문에 대한 상세 내용이나 영수증이 필요하신 경우에는 
					<a href="">이곳</a>
					을 눌러주세요
				</p>
			</div>
			<div class="card-body text-end">
				<!-- <a href="../list2" class="card-link">나의 결제 내역 보기</a> -->
				<a href="${pageContext.request.contextPath}/pay/list" class="btn btn-primary">나의 결제 내역 보기</a>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>