<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<style>
.profile-text{
font-size: 20px;
}
.text-gray{
color: gray;
}
 .profile-box {
    position: relative;
  }

  .edit-icon {
    position: absolute;
    top: 100px;
    left: 110px;
  }


</style>
<script>
$(function() {
	$(".edit-p").click(function() {
		$(".edit-modal").modal("show");	
	});
	
	$(".profile-set-btn").click(function () {
	    var formData = new FormData();
	    formData.append('attach', $('#formFile')[0].files[0]);

	    $.ajax({
	        url: "http://localhost:8080/rest/member/profileUpdate",
	        method: "post",
	        data: formData,
	        contentType: false,
	        processData: false,
	        success: function (response) {
	        	$(".profile").attr("src", "https://localhost:8080/rest/member/profileShow?memberId=" + response.memberId);
	        }
	    });
	});
	$(".changeSelf").click(function() {
		$(".self-modal").modal().show();
	})
	
	$(".save-btn").click(function () {
		var memberSelf = $("#self-content").val();
		var memberId = "${sessionScope.name}";
		$.ajax({
			url:"http://localhost:8080/rest/member/memberEditSelf",
			method: "post",
			data: {
				memberSelf : memberSelf,
				memberId : memberId
				},
				success: function (response) {
					$(this).modal().hide();
				}
		});
	})
		
	});
</script>

<div class="contain-fluid">
        <div class="row ms-2">
            <div class="col-12	">
                <c:choose>
                	<c:when test="${sessionScope.name==memberDto.memberId}">
                			 <div class="row">
                            <div class="col text-start d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2 main-text">프로필</strong>
                            </div>
                        </div>

                        <div class="row mt-3 d-flex align-items-center profile-box">
                            <div class="col-3">
                                <c:choose>
                                    <c:when test="${memberDto==null}">
										<img src="${pageContext.request.contextPath}/images/avatar50.png" width="35%">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/rest/member/profileShow?memberId=${memberDto.memberId}" class="rounded-circle profile" style="width:120px; height: 120px;" >
                                    </c:otherwise>
                                </c:choose>
                                <a href="./edit" class="edit-icon"><i class="fa-solid fa-pen edit-p"></i></a>
                            </div>
                            <div class="col-9">
                                <div class="col">
                                    <strong>${memberDto.memberName}</strong> 
                                </div>
                                <div class="col mt-2">
                                    <span class="text-gray">지역 | ${memberDto.memberBirth}</span> 
                                </div>
                                <div class="col mt-2 changeSelf">
                                <c:choose>
                                	<c:when test="${memberDto.memberSelf==null}">
                                		<span class="">자신을 소개하세요</span>
                                	</c:when>
                                	<c:otherwise>
	                                    <span>${memberDto.memberSelf}</span> 
                                	</c:otherwise>
                                </c:choose>
	                                    <button class="btn btn-sm changeSelf"  data-bs-toggle="modal" data-bs-target="#self-modal"><i class="fa-solid fa-pen"></i></button>
                                </div>
                            </div>
                    </div>
						<!-- Modal -->
						<div class="modal fade" id="self-modal" tabindex="-1" role="dialog" aria-labelledby="self-modalLabel" aria-hidden="true">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="self-modalLabel">자기소개</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						        <div class="form-group">
							      <textarea class="form-control" name="memberSelf" id="self-content" rows="5" pl>${memberDto.memberSelf}</textarea>
							    </div>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						        <button type="button" class="btn btn-primary save-btn" data-bs-dismiss="modal">저장</button>
						      </div>
						    </div>
						  </div>
						</div>
                    
                    
<!--                     관심 카테고리 -->
                    <div class="col mt-2">
                        <span class="badge bg-info rounded-pill">${like0}</span>
                        <span class="badge bg-info rounded-pill">${like1}</span>
                        <span class="badge bg-info rounded-pill">${like2}</span>
                    </div>
                    
                    <c:choose>
                    <c:when test="${wishList == null}">
							  <div class="row d-flex align-items-center mt-3">
					                <div class="col-3 text-start">
					                    <img src="${pageContext.request.contextPath}/images/open-door.png" width="100%">
					                </div>
					                	 <div class="col">
					                                	<div class="col">
					                                    <h5>찜한 모임이 없습니다.</h5>
					                                	</div>
					                                	<div class="col">
					                                    <h1>모임을 찜해보세요!</h1>
					                                	</div>
					                                </div>
					                                <div class="row p-1 mt-4 text-center">
					                    </div>
					            </div>
						</c:when>
						
						
					<c:otherwise>
					<div class="row">
                            <div class="col d-flex align-items-center mt-3 me-3">
                                <div class="col-6">
                                    <img src="${pageContext.request.contextPath}/images/logo-door.	png" width="5%">
                                    <strong class="ms-2 text-start">찜한 정모</strong>
                                </div>
                                <div class="col-6 text-end">
                                    <strong>전체보기</strong>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                        <c:forEach var="wishListDto" items="${wishList}">
                                <div class="col-2 ms-2">
                                    <div class="alert alert-dismissible alert-light">
                                    
                                        <a
											href="${pageContext.request.contextPath}/club/detail?clubNo=${wishListDto.clubNo}"
											class="link"
											style="height: 100%; padding: 0; box-sizing: border-box;"> <img
											src="${pageContext.request.contextPath}/club/image?clubNo=${wishListDto.clubNo}"  class="club-image">
										</a>
                                    </div>
                                        <span>${wishListDto.clubName}</span>
                                </div>
                        </c:forEach>
                        </div>
					</c:otherwise>
                    </c:choose>
                    
                        
                        

                        

                	</c:when>
                	
                	<c:otherwise>
                	 
                	
                		 <div class="row">
                            <div class="col d-flex align-items-center mt-3 me-3">
                                <div class="col-6">
                                    <img src="${pageContext.request.contextPath}/images/logo-door.	png" width="5%">
                                    <strong class="ms-2 text-start">${memberDto.memberName}의 마이페이지</strong>
                                </div>
                                <div class="col-6 text-end">
                                    <strong>전체보기</strong>
                                </div>
                            </div>
                        </div>
                        <c:choose>
                        	<c:when test="${empty clubList}">
                        	 
                        	<div class="row d-flex align-items-center mt-3">
					                <div class="col-3 text-start">
					                    <img src="${pageContext.request.contextPath}/images/open-door.png" width="100%">
					                </div>
					                	 <div class="col">
					                                	<div class="col">
					                                    <h3>${memberDto.memberName}님은 아직 가입한 동호회가 없습니다</h3>
					                                	</div>
					                                </div>
					                                <div class="row p-1 mt-4 text-center">
					                    </div>
					            </div>
                        	
                         
                        	</c:when>
                        	<c:otherwise>
                        	<div class="row">
                                <c:forEach var="clubDto" items="${clubList}">
                            <div class="col-2 mt-2">
                                <div class="alert alert-dismissible alert-light">
                                    <a
											href="${pageContext.request.contextPath}/club/detail?clubNo=${clubDto.clubNo}"
											class="link"
											style="height: 100%; padding: 0; box-sizing: border-box;"> <img
											src="${pageContext.request.contextPath}/club/image?clubNo=${clubDto.clubNo}"  class="club-image">
										
										</a>
                                </div>
                                <span>${clubDto.clubName}</span>
                            </div>
                                </c:forEach>
                    </div>
                        	</c:otherwise>
                        </c:choose>
                        
                        
                       
                    
                    
                    
                        
                	</c:otherwise>
                	</c:choose>
                        
		
<div class="row mt-4">
     <div class="col text-start d-flex align-items-center">
         <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
        <strong class="ms-2 main-text">나의 구독내역</strong>
    </div>
</div>

<c:forEach var="paymentRegularListVO" items="${list2}">

	<!-- 대표 정보 -->

<div class="row mt-3">	
<div class="col text-start d-flex align-items-center btn btn-miso">
    <a href="${pageContext.request.contextPath}/club/detail?clubNo=${paymentRegularListVO.paymentRegularDto.paymentRegularClubNo}"
        class="link"
        style="height: 100%; padding: 0; box-sizing: border-box; text-decoration: none; color: inherit;">
        모임명 : <strong class="ms-2 main-text">${paymentRegularListVO.clubDto.clubName}</strong>
    </a></div>

<!-- 		<div class="col text-end"> -->
<%-- 	<c:if test="${paymentRegularListVO.paymentRegularDto.paymentRegularRemain > 0 }"> --%>
<%-- 	<a href="regularCancelAll?paymentRegularNo=${paymentRegularListVO.paymentRegularDto.paymentRegularNo}" class="btn btn-danger"> --%>
<!-- 	구독 취소</a> -->
<%-- 	</c:if>		 --%>
<!-- </div> -->
	</div>
	
		 <div class="row mt-2">
		<div class="col-6">
	${paymentRegularListVO.paymentRegularDto.paymentRegularName}		
		</div>
		<div class="col">
		<i class="fa-solid fa-hourglass-start"></i>
	${paymentRegularListVO.paymentRegularDto.paymentRegularTime}
		</div>
		<div class="col">
		<i class="fa-solid fa-hourglass-end"></i>
	${paymentRegularListVO.paymentRegularDto.paymentRegularEnd}
		</div>
	</div>
	
	
	
	<hr>
</c:forEach>
                        
        <c:forEach var="paymentRegularListVO" items="${list2}">

	<!-- 대표 정보 -->

<div class="row mt-3">	
<div class="col text-start d-flex align-items-center btn btn-miso">
    <a href="${pageContext.request.contextPath}/club/detail?clubNo=${paymentListVO.paymentDto.paymentClubNo}"
        class="link"
        style="height: 100%; padding: 0; box-sizing: border-box; text-decoration: none; color: inherit;">
        모임명 : <strong class="ms-2 main-text">${paymentListVO.clubDto.clubName}</strong>
    </a></div>

<!-- 		<div class="col text-end"> -->
<%-- 	<c:if test="${paymentRegularListVO.paymentRegularDto.paymentRegularRemain > 0 }"> --%>
<%-- 	<a href="regularCancelAll?paymentRegularNo=${paymentRegularListVO.paymentRegularDto.paymentRegularNo}" class="btn btn-danger"> --%>
<!-- 	구독 취소</a> -->
<%-- 	</c:if>		 --%>
<!-- </div> -->
	</div>
	
		 <div class="row mt-2">
		<div class="col-6">
	${paymentListVO.paymentDto.paymentName}		
		</div>
		<div class="col">
		<i class="fa-solid fa-hourglass-start"></i>
	${paymentListVO.paymentDto.paymentTime}
		</div>
		<div class="col">
		<i class="fa-solid fa-hourglass-end"></i>
	${paymentListVO.paymentDto.paymentEnd}
		</div>
	</div>
	
	
	
	<hr>
</c:forEach>                
		</div>
	</div>


<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>