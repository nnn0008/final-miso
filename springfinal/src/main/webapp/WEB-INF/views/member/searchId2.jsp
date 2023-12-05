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


    
<script>
	window.contextPath = "${pageContext.request.contextPath}";
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

<script>
	$(function() {
	});
</script>
<div class="contain-fluid">
	<div class="row">
		<div class="col">

		<c:choose>
			<c:when test="${idCount!=0}">
			<div class="row mt-5 pt-5">
				<div class="col">
					<h1>아이디를 찾았습니다</h1>
				</div>
			</div>


			<div class="row mt-4">
				<div class="col">
					<div class="card border-primary border border-2 mb-3 w-100 h-100">
						<div class="card-header">아이디</div>
						<div class="card-body">
							<h4 class="card-text">${memberName}님의 아이디의 개수는 ${idCount}개 입니다</h4>
							<div class="card-text mt-2 fs-4">${idList}</div>
						</div>
					</div>
			</div>
			<div class="row mt-4">
				<div class="col">
					<a href="./login"><button class="btn fs-4">로그인</button></a>
				</div>
			</div>
		</div>
			</c:when>
			<c:otherwise>
				<div class="row mt-4">
				<div class="col">
					<div class="card border-primary border border-2 mb-3 w-100 h-100">
						<div class="card-body">
							<h4 class="card-text">등록되지 않은 회원입니다</h4>
							<hr class="my-4">
				            <p>자세한 정보는 웹 사이트를 방문하세요.</p>
				            <a class="btn btn-primary btn-lg mt-3" href="./join" role="button">가입하기</a>
						</div>
					</div>
			</div>
			</div>
			
			
			</c:otherwise>
		</c:choose>
	</div>
</div>
</div>

</article>
</section>
    </main>
