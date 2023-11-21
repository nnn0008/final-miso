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
</style>

<div class="row mt-4">
     <div class="col text-start d-flex align-items-center ms-3 mt-3">
         <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
         <strong class="ms-2">miso 정기이용권</strong>
     </div>
 </div>
 
<div class="container">
  <div class="row">
    <div class="col-md-6">
      <div class="card mt-3 mb-3 text-center">
  <h3 class="card-header ">정기이용권</h3>
  
  <div class="card-body-regular">
    <h5 class="card-title">매월</h5>
    <h6 class="card-subtitle text-muted">15,500원</h6>
    <h6 class="card-text">(부가세 포함)</h6>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item"><i class="fa-regular fa-face-smile"></i>모임 정원 범위 확대</li>
    <li class="list-group-item"><i class="fa-regular fa-envelope"></i>1:1 메시지 기능</li>
    <li class="list-group-item">추가</li>
  </ul>
  <div class="card-body pe-3">
    <a href="regularList" class="card-link btn bg-miso w-100">구매하기</a>
  </div>
  <div class="card-footer text-muted">
   정기구독의 특성상 최초 1회의 결제금액은 과금되며 환불이 불가합니다.
  </div>
</div>
</div>

<div class="col-md-6">
      <div class="card mt-3 mb-3 text-center">
  <h3 class="card-header ">정기이용권</h3>
  
  <div class="card-body-regular ">
    <h5 class="card-title">매년</h5>
    <h6 class="card-subtitle text-muted">159,000원</h6>
    <h6 class="card-text">(부가세 포함)</h6>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item">모임 정원 범위 확대</li>
    <li class="list-group-item">추가</li>
    <li class="list-group-item">추가</li>
  </ul>
  <div class="card-body pe-3">
    <a href="regularList" class="card-link btn bg-miso w-100">구매하기</a>
  </div>
  <div class="card-footer text-muted">
   정기구독의 특성상 최초 1회의 결제금액은 과금되며 환불이 불가합니다.
  </div>
</div>
</div>
</div>

</div>

<div class="row">
     <div class="col text-start d-flex align-items-center ms-3 mt-3">
         <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
         <strong class="ms-2">miso 단기이용권</strong>
     </div>
 </div>
 
 <div class="container mb-3">
  <div class="row">
    <div class="col-md-6">
      <div class="card mt-3 mb-3 text-center">
  <h3 class="card-header ">단기이용권</h3>
  
  <div class="card-body-single">
    <h5 class="card-title">매월</h5>
    <h6 class="card-subtitle text-muted">15,500원</h6>
    <h6 class="card-text">(부가세 포함)</h6>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item">모임 정원 범위 확대</li>
    <li class="list-group-item">추가</li>
    <li class="list-group-item">추가</li>
  </ul>
  <div class="card-body pe-3">
    <a href="singleList" class="card-link btn bg-miso w-100">구매하기</a>
  </div>
  <div class="card-footer text-muted">
   정기구독의 특성상 최초 1회의 결제금액은 과금되며 환불이 불가합니다.
  </div>
</div>
</div>

<div class="col-md-6">
      <div class="card mt-3 mb-3 text-center">
  <h3 class="card-header ">단기이용권</h3>
  
  <div class="card-body-single">
    <h5 class="card-title">매년</h5>
    <h6 class="card-subtitle text-muted">159,000원</h6>
    <h6 class="card-text">(부가세 포함)</h6>
  </div>
  <ul class="list-group list-group-flush">
    <li class="list-group-item">모임 정원 범위 확대</li>
    <li class="list-group-item">추가</li>
    <li class="list-group-item">추가</li>
  </ul>
  <div class="card-body pe-3">
    <a href="singleList" class="card-link btn bg-miso w-100 ">구매하기</a>
  </div>
  <div class="card-footer text-muted">
   정기구독의 특성상 최초 1회의 결제금액은 과금되며 환불이 불가합니다.
  </div>
</div>
</div>
</div>

</div>
  
<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>