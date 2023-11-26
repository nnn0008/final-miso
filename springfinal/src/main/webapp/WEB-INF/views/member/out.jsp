<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
  <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>miso</title>


 <!-- 아이콘 사용을 위한 Font Awesome 6 CDN-->
 <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
   

<!-- 부트스트랩 CDN -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/zephyr/bootstrap.min.css" rel="stylesheet">

<!-- 스타일시트 로딩 코드 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
    <link href="${pageContext.request.contextPath}/css/misolayout.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/miso.css" rel="stylesheet">
<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->


<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


    
<script>
	window.contextPath = "${pageContext.request.contextPath}";
</script>

<style>
	.error-feed{
		display: none;
	}
</style>
</head>
<body>

<script>
	$(function () {
		$("#delete").click(function () {
			var memberId = "${sessionScope.name}";
			var memberPw = $("#memberPw").val();
			console.log("jsp중간체크")
			$.ajax({
				url: "http://localhost:8080/rest/member/delete",
				method: "post",
				data:{
					memberId:memberId,
					memberPw:memberPw,
				},
				success: function (response) {
					console.log(response);
					$(".error-feed").show();
					window.location.href = "http://localhost:8080/member/outFinish";
				  },
			});
		});
	});
</script>

            <!-- 헤더 -->
<article class="main-content">

<!-- 아이디를 찾았을 때 띄울 템플렛 -->

	<div class="row">
		<div class="col">

					 <div class="row d-flex align-items-center  mt-5">
                <div class="col-5 text-center">
                    <img src="${pageContext.request.contextPath}/images/open-door.png" width="80%">
                </div>
                <div class="col  text-center">
                	<div class="col">
                    <h5>정말 탈퇴하시겠습니까?</h5>
                	</div>
                	<div class="col mt-3">
                    <button type="button" class="btn btn-miso btn-lg" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
						 탈퇴하기
						</button>
                	</div>
                </div>
            </div>

				<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h1 class="modal-title fs-5" id="staticBackdropLabel">비밀번호를 적어주세요</h1>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				       <div class="form-group">
						  <input type="password" class="form-control form-control-lg" type="text" id="memberPw">
						</div>
						<span class="error-feed text-danger">비밀번호가 틀렸습니다</span>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				        <button type="button" class="btn btn-danger" id="delete">탈퇴하기</button>
				      </div>
				    </div>
				  </div>
				</div>
		</div>
	</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>