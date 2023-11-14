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
	<div class="contain-fluid">
            <div class="row">
                <div class="col">

                    <div class="row mt-5 pt-5">
                        <div class="col-sm-6 offset-sm-3 text-center">
                            <h1>로그인</h1>
                        </div>
                    </div>
                    <form class="form-group" action="./login" method="post">
                        <div class="row">
                            <div class="col-sm-6 offset-sm-3 col-lg-10 offset-lg-1">
                                <div class="form-group">
                                    <label for="memberId" class="form-label mt-4 is-valid">아이디</label>
	                                    <input type="text" class="form-control" name="memberId" id="memberId" value="${cookie.saveId.value}" autocomplete="off">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1">
                                <div class="form-group">
                                    <label for="exampleInputPassword1" class="form-label mt-4">비밀번호</label>
                                    <input type="password" class="form-control" name="memberPw" id="memberPw" autocomplete="off">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1">
                                <div class="form-check">
                                	<c:choose>
                                		<c:when test="${cookie.saveId.value != null}">
                                			<input class="form-check-input" type="checkbox" name="saveId" value="save" id="saveId" checked>
                                		</c:when>
                                		<c:otherwise>
		                                    <input class="form-check-input" type="checkbox" name="saveId" value="save" id="saveId">
                                		</c:otherwise>
                                	</c:choose>
                                    <label class="form-check-label" for="saveId">
                                        아이디 저장하기
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1">
                                <button class="btn btn-primary w-100">로그인</button>
                            </div>
                        </div>
                    </form>
                    <div class="row mt-3">
                        <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1">
                            <a href="./searchId"><button class="btn">아이디 찾기</button></a>
                            <a href="./searchPw"><button class="btn">비밀번호 찾기</button></a>
                            <a href="./join"><button class="btn">회원가입</button></a>
                        </div>
                    </div>
                

                </div>
            </div>
        </div>
</article>
</section>
    </main>