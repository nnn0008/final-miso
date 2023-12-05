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
		.btn-miso{
	font-size: 20px;	
		}
	
</style>
<script>
	window.contextPath = "${pageContext.request.contextPath}";
	$(function () {
		const urlParams = new URLSearchParams(window.location.search);
		console.log(urlParams);
		const errorParam = urlParams.get('error');
		console.log(errorParam);
		if(errorParam){
			$(".error-feed").css("display", "inline-block");
		}
	});
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
                        <div class="col-sm-6 offset-sm-3 col-lg-10 offset-lg-1 text-center">
                     <img src="${pageContext.request.contextPath}/images/miso_logo.png" width="70%">
                        </div>
                    </div>
                    <span class="error-feed text-danger">아이디 혹은 비밀번호가 틀렸습니다</span>
                    <form class="form-group" action="./login" method="post">
                        <div class="row mt-4">
                            <div class="col-sm-6 offset-sm-3 col-lg-10 offset-lg-1">
                                <div class="form-floating">
                                    <input type="text" name="memberId" id="memberId" class="form-control" placeholder="이글자는안보임" value="${cookie.saveId.value}" autocomplete="off">
                                    <label for="memberId" class="is-valid">아이디
                                        <span class="fa-solid fa-asterisk text-danger"></span>
                                    </label>
<!--                                     <div class="invalid-feedback">아이디를 다시 입력하세요</div> -->
                                </div>
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1">
                                 <div class="form-floating">
                                    <input type="password" name="memberPw" class="form-control" placeholder="이글자는안보임" id="memberPw">
                                    <label for="exampleInputPassword1" class="is-invalid">비밀번호
                                        <span class="fa-solid fa-asterisk text-danger"></span>
                                    </label>
<!--                                     <div class="invalid-feedback">비밀번호를 다시 입력하세요</div> -->
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
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
                        <div class="row mt-3">
                            <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1">
                                <button class="btn btn-miso bg-miso btn-lg w-100">
                                <strong>로그인</strong>
                                </button>
                            </div>
                        </div>
                    </form>
                    <div class="row mt-4">
                        <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1 text-center">
                            <a href="./searchId" class="link-body-emphasis link-underline link-underline-opacity-0">아이디 찾기</a>  | 
                            <a href="./searchPw" class="link-body-emphasis link-underline link-underline-opacity-0">비밀번호 찾기</a>  | 
                            <a href="./join" class="link-body-emphasis link-underline link-underline-opacity-0">회원가입</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</article>
</section>
    </main>
