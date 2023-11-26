<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
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


  <style>
	.error-feed{
		display: none;
	}
</style>
<script>
	window.contextPath = "${pageContext.request.contextPath}";
	$(function () {
		const urlParams = new URLSearchParams(window.location.search);
		const errorParam = urlParams.get('error');
		if(errorParam){
			$(".error-feed").css("display", "inline-block");
		}
	})
</script>

</head>
<body>


<main>
 <header>
           
                 
              
        </header>
        <nav>
        </nav>
        <section>


            <!-- 헤더 -->
<article class="main-content">

<!-- 아이디를 찾았을 때 띄울 템플렛 -->

<div class="contain-fluid">
	<div class="row">
		<div class="col">

			<div class="row mt-5 pt-5">
				<div class="col">
					<h1>아이디 찾기</h1>
				</div>
			</div>

			<form action="searchId" method="post">
				<div class="row">
					<div class="col">
						<div class="form-group">
							<label class="col-form-label mt-4" for="memberName">이름</label> <input
								type="text" class="form-control" name="memberName"
								id="memberName">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<div class="form-group">
							<label class="col-form-label mt-4" for="inputDefault">이메일</label>
							<input type="text" class="form-control" name="memberEmail"
								id="inputDefault">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col text-end">
						<button class="btn btn-primary btn-search">찾기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

</article>
</section>
    </main>
