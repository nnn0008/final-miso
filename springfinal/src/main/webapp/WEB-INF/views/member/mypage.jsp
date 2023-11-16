<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<script>
$(function() {
	$(".edit-p").click(function() {
		
		$(".edit-modal").modal().show();	
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
	            console.log("성공", response);
	        }
	    });
	});

	});
</script>

<div class="contain-fluid">
        <div class="row">
            <div class="col-12	">
                
                <div class="row">
                    <div class="col">
                        <h1 class="text-center">마이페이지</h1>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-lg-4 col-md-4">
                    <c:choose>
                    	<c:when test="${attachDto==null}">
                    		<img src="https://dummyimage.com/40x40/000/fff" class="rounded-circle">
                    	</c:when>
                    	<c:otherwise>
                    	
	                        <img src="/rest/member/profileShow?attachNo=${attachDto.attachNo}" class="rounded-circle" style="width:70px; height: 70px;">
                    	</c:otherwise>
                    </c:choose>
                    <button class="edit-p" data-bs-toggle="modal" data-bs-target="#edit-modal"><i class="fa-solid fa-pen edit-p"></i></button>
                    </div>
                    <div class="col-lg-6 col-md-8 text-start mt-5	">
                        <span class="h2">${memberDto.memberName}</span>
                        <div class="h4">지역, ${memberDto.memberBirth}</div>
                        <div class="h4">자기소개</div>
                    </div>
                </div>
                
<!--                 프로필 업로드를 위한 모달 -->
               <form enctype="multipart/form-data" method="post" action="/your-upload-endpoint">
                <div class="modal" id="edit-modal">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title">프로필 설정</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true"></span>
				        </button>
				      </div>
				      <div class="modal-body">
				        <div class="mb-3">
						  <label for="formFile" class="form-label">이미지를 선택해 주세요</label>
						  <input class="form-control" type="file" name="attach" id="formFile" accept="image/*">
						</div>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-primary profile-set-btn">설정</button>
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				      </div>
				    </div>
				  </div>
				</div>
				</form>

                <div class="row mt-5">
                    <div class="col">
                        <div class="h4">찜한 정모</div>
                        <div class="card mb-3" style="width: 14rem;">
                            <img src="https://dummyimage.com/30/30/000/" class="card-img-top">
                            <div class="card-body">
                              <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            </div>
                          </div>
                    </div>
                </div>

                <div class="row mt-5">
                    <div class="col">
                        <div class="h4">찜한 모임</div>
                        <div class="card mb-3" style="width: 14rem;">
                            <img src="https://dummyimage.com/30/30/000/" class="card-img-top">
                            <div class="card-body">
                              <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            </div>
                          </div>
                    </div>
                </div>


                <div class="row mt-5">
                    <div class="col">
                        <div class="h4">
                            최근 본 모임
                        </div>
                        <div class="card mb-3" style="width: 14rem;">
                            <img src="https://dummyimage.com/30/30/000/" class="card-img-top">
                            <div class="card-body">
                              <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                            </div>
                          </div>
                    </div>
                </div>

		
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>