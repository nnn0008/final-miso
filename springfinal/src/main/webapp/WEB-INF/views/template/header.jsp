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
<style>
.circle {
        width: 100px;
        height: 100px;
        border-radius: 30%;
    }

    .circle-name {
        font-size: 12px;
        text-align: center;
    }

    .circle-time {
        height: 40px;
        border-radius: 15%;
    }

    .card-body{
        background-color:#FCFCFD;
        color: #495057;
    }
    
    .text-inc{
    font-size: 12px;
    }
</style>

<%-- 
	절대경로를 설정하기 위한 스크립트 작성
	- 절대경로라는 개념은 백엔드에만 있다
	- 자바스크립트에서 절대경로를 알 수 있는 방법이 없다
	- window에 절대경로 값을 탑재시켜 사용
--%>
    
<script>
	window.contextPath = "${pageContext.request.contextPath}";
</script>

<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>

<main>
 <header>
            <div class="col mt-2">
                <a href="#" class="link"><img src="${pageContext.request.contextPath}/images/miso_logo.png" width="200px"></a>
            </div>
            <div class="title">
                <div class="input-group d-flex justify-content-center">  

                    <input type=" search" class="form-control rounded" placeholder="Search" aria-label="Search"  
                  
                    aria-describedby="search-addon" />  
                  
                    <button type="button" class="btn btn-outline-primary">search</button>  
                  
                   </div>  
            </div>
            <div class="etc">
            </div>
        </header>
        <nav>
        </nav>
        <section>
          

            <!-- 헤더 -->
