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

	});
</script>

<div class="contain-fluid">
        <div class="row ms-2">
            <div class="col-12	">
                
                        <div class="row">
                            <div class="col mb-3">
                                <strong class="profile-text">프로필</strong> 
                            </div>
                        </div>

                        <div class="row mt-3 d-flex align-items-center profile-box">
                            <div class="col-3">
                                <c:choose>
                                    <c:when test="${attachDto==null}">
                                        <img src="https://dummyimage.com/40x40/000/fff" class="rounded-circle profile">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/rest/member/profileShow?memberId=${memberDto.memberId}" class="rounded-circle profile" style="width:120px; height: 120px;">
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
                                <div class="col mt-2">
                                    <span>자기소개 넣어야 함</span> 
                                </div>
                            </div>
                    </div>
                    <div class="col mt-2">
                        <span class="badge bg-info rounded-pill">헬스/크로스핏</span>
                        <span class="badge bg-info rounded-pill">헬스/크로스핏</span>
                    </div>

                        
                        <div class="row">
                            <div class="col d-flex align-items-center mt-3 me-3">
                                <div class="col-6">
                                    <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                    <strong class="ms-2 text-start">찜한 정모</strong>
                                </div>
                                <div class="col-6 text-end">
                                    <strong>전체보기</strong>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                                <div class="col-2 mt-2">
                                    <div class="alert alert-dismissible alert-light">
                                        <a href="#" class="link">정모1</a>
                                    </div>
                                        <span>정모이름</span>
                                </div>
                        </div>

                        <div class="row">
                            <div class="col d-flex align-items-center mt-3 me-3">
                                <div class="col-6">
                                    <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                    <strong class="ms-2 text-start">찜한 모임</strong>
                                </div>
                                 <div class="col-6 text-end me-3">
                                    <strong>전체보기</strong>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-2 mt-2">
                                <div class="alert alert-dismissible alert-light">
                                    <a href="#" class="link">찜한 모임</a>
                                </div>
                                <span>모임이름</span>
                            </div>
                    </div>

                        
                        <div class="row">
                            <div class="col d-flex align-items-center mt-3 me-3">
                                <div class="col-6">
                                    <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                    <strong class="ms-2 text-start">최근 본 모임</strong>
                                </div>
                                 <div class="col-6 text-end me-3">
                                    <strong>전체보기</strong>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-2 mt-2">
                                <div class="alert alert-dismissible alert-light">
                                    <a href="#" class="link">최근 본 모임</a>
                                </div>
                                <span>모임이름</span>
                            </div>
                    </div>
                        

		
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>