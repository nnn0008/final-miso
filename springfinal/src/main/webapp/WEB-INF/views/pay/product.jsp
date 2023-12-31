<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<style>
.card-body-regular{
background-color: #ffd2fc
}
.card-body-single{
background-color: #93ede2
}

 .fa-star{
color: #ffde00;
}
.fa-users-line{
color: #3c3ccd;
}
.fa-comments2{
color: #5f9ffa;
}
.fa-message{
color: #24c2ae;
}
.fa-lock{
color: #bfbfbf;
}
.list-group-item{
font-size: 13px;
}

.card-text,.card-subtitle{
font-size: 14px;
}

.card-footer{
height: 90px;
}

.text-footer{
font-size: 15px;
}
</style>

<div class="row mt-4">
     <div class="col text-start d-flex align-items-center ms-3 mt-3">
         <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
         <strong class="ms-2">miso 프리미엄 이용권</strong>
     </div>
 </div>
 
<div class="container">

  <div class="row">
    <div class="col-md-6">
      <div class="card mt-3 mb-3 text-center">
     <h5 class="card-header ">
  <strong>단건이용권</strong>
  </h5>
  
  <div class="card-body-regular">
  <strong class="card-title">한달 / 1년</strong>
    <h6 class="card-subtitle text-muted mt-1">5,900원 / 59,000원</h6>
    <h6 class="card-text">(부가세 포함)</h6>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item p-2"><i class="fa-solid fa-users-line"></i>
    <span class="ms-1">모임 정원 범위 확대</span>
    </li>
  </ul>
  <div class="card-body pe-3">
    <a href="singleList2" class="card-link btn bg-miso w-100">구매하기</a>
  </div>
  <div class="card-footer text-muted">
 <span class="text-footer">
   프리미엄 이용권은 구독결제의 특성상 환불이 불가합니다. 
 </span>
  </div>
</div>
</div>

<div class="col-md-6">
      <div class="card mt-3 mb-3 text-center">
   <h5 class="card-header ">
  <strong>정기이용권</strong>
  </h5>
  
  <div class="card-body-regular ">
     <strong class="card-title">한달 / 1년</strong>
    <h6 class="card-subtitle text-muted mt-1">5,900원 / 59,000원</h6>
    <h6 class="card-text">(부가세 포함)</h6>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item p-2"><i class="fa-solid fa-users-line"></i>
    <span class="ms-1">모임 정원 범위 확대</span>
    </li>
  </ul>
  <div class="card-body pe-3">
    <a href="regularList2" class="card-link btn bg-miso w-100">구매하기</a>
  </div>
  <div class="card-footer text-muted">
    <span class="text-footer">
   프리미엄 정기 이용권은 구독기간 중간에 구독취소나 환불이 불가합니다.
 </span>
  </div>
</div>
</div>
</div>



</div>

<div class="row">
     <div class="col text-start d-flex align-items-center ms-3 mt-3">
         <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
         <strong class="ms-2">miso 파워유저 회원권</strong>
     </div>
 </div>
 
 <div class="container mb-3">
 
  <div class="row">
    <div class="col-md-6">
      <div class="card mt-3 mb-3 text-center">
    <h5 class="card-header ">
  <strong>단건이용권</strong>
  </h5>
  
  <div class="card-body-single">
     <strong class="card-title">한달 / 1년</strong>
    <h6 class="card-subtitle text-muted mt-1">3,900원 / 39,000원</h6>
    <h6 class="card-text">(부가세 포함)</h6>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item p-2"><i class="fa-solid fa-star"></i>
     <span class="ms-1">가입모입 개수 증가(최대 10개)</span></li>
    <li class="list-group-item p-2"><i class="fa-solid fa-lock"></i>
    <span class="ms-1">가입한 모임 비공개</span></li>
    <li class="list-group-item p-2"><i class="fa-solid fa-comments fa-comments2"></i>
    <span class="ms-1">1대1 채팅 기능</span></li>
    <li class="list-group-item p-2"><i class="fa-solid fa-message"></i>
    <span class="ms-1">본인 메시지 삭제 기능</span></li>
  </ul>
  <div class="card-body pe-3">
     <c:choose>
    <c:when test="${sessionScope.memberLevel eq '파워유저'}">
        <a class="card-link btn bg-miso w-100" style="pointer-events: none; opacity: 0.6;">구매하기</a>
    </c:when>
    <c:otherwise>
        <a href="singleList" class="card-link btn bg-miso w-100">구매하기</a>
    </c:otherwise>
</c:choose>

  </div>
  <div class="card-footer text-muted">
  <span class="text-footer">
  파워 유저권은 구독결제의 특성상 환불이 불가합니다. 
  </span>
  </div>
</div>
</div>

<div class="col-md-6">
      <div class="card mt-3 mb-3 text-center">
  <h5 class="card-header ">
  <strong>정기이용권</strong>
  </h5>
  
  <div class="card-body-single">
    <strong class="card-title">한달 / 1년</strong>
    <h6 class="card-subtitle text-muted mt-1">3,900원 / 39,000원</h6>
    <h6 class="card-text">(부가세 포함)</h6>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item p-2"><i class="fa-solid fa-star"></i>
     <span class="ms-1">가입모입 개수 증가(최대 10개)</span></li>
    <li class="list-group-item p-2"><i class="fa-solid fa-lock"></i>
    <span class="ms-1">가입한 모임 비공개</span></li>
    <li class="list-group-item p-2"><i class="fa-solid fa-comments fa-comments2"></i>
    <span class="ms-1">1대1 채팅 기능</span></li>
    <li class="list-group-item p-2"><i class="fa-solid fa-message"></i>
    <span class="ms-1">본인 메시지 삭제 기능</span></li>
  </ul>
  <div class="card-body pe-3">
        <c:choose>
    <c:when test="${sessionScope.memberLevel eq '파워유저'}">
        <a class="card-link btn bg-miso w-100" style="pointer-events: none; opacity: 0.6;">구매하기</a>
    </c:when>
    <c:otherwise>
        <a href="regularList" class="card-link btn bg-miso w-100">구매하기</a>
    </c:otherwise>
</c:choose>

  </div>
  <div class="card-footer text-muted">
    <span class="text-footer">
 파워유저 정기 이용권은 구독기간 중간에 구독취소나 환불이 불가합니다.
  </span>
  </div>
</div>
</div>
</div>



</div>
  
<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>