	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
	
	<div class="contain-fluid">
	        <div class="row">
	            <div class="col">
					
					<div class="row">
                    <div class="col text-center">
                        <h1>회원 정보 수정 페이지</h1>
                    </div>
                </div>

                <div class="row">
                    <div class="col text-center">
                        <c:choose>
                            <c:when test="${attachDto==null}">
                                <img src="https://dummyimage.com/150x150/000/fff" class="rounded-circle profile">
                            </c:when>
                            <c:otherwise>
                                <img src="/rest/member/profileShow?memberId=${memberDto.memberId}" class="rounded-circle profile" style="width:150px; height: 150px;">
                            </c:otherwise>
                        </c:choose>
                        <div class="position-relative ">
	                        <a href="./edit" style="width: 60px; height: 60px;"><i class="fa-solid fa-camera fa-2xl"></i></a>
                        </div>
                    </div>
                </div>

                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text" id="inputGroup-sizing-default">이름</span>
							  </div>
							  <input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberName}">
							</div>
                    	</div>
                    </div>
                    
                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text" id="inputGroup-sizing-default">자기소개</span>
							  </div>
							  <input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberName}">
							</div>
                    	</div>
                    </div>
			
					<div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text" id="inputGroup-sizing-default">지역</span>
							  </div>
							  <input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberAddr}">
							</div>
                    	</div>
                    </div>
                    
                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text" id="inputGroup-sizing-default">이메일</span>
							  </div>
							  <input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberEmail}">
							</div>
                    	</div>
                    </div>
                    
                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text" id="inputGroup-sizing-default">전화번호</span>
							  </div>
							  <input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberContact}">
							</div>
                    	</div>
                    </div>
                    
                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text" id="inputGroup-sizing-default">생년월일</span>
							  </div>
							  <input type="text" class="form-control" aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberBirth}">
							</div>
                    	</div>
                    </div>
                    
                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mb-3">
							  <div class="input-group-prepend">
							    <button class="btn btn-outline-secondary" type="button">남</button>
							    <button class="btn btn-outline-secondary" type="button">여</button>
							  </div>
							  <input type="text" class="form-control" placeholder="" aria-label="" aria-describedby="basic-addon1">
							</div>
                    	</div>
                    </div>
                    
                    <hr>
	      		          
	      		    <div class="row">
	      		    	<div class="col-6 text-start">
	      		    		<h4>관심사</h4>
	      		    	</div>
	      		    	<div class="col text-end">
	      		    		<div class="h5"><p>편집</p></div>
	      		    	</div>
	      		    </div>
	      		    
	      		    <div class="row">
	      		    	<div class="col">
			      		    <span class="badge rounded-pill bg-primary fs-5">운동</span>
			      		    <span class="badge rounded-pill bg-primary fs-5">운동</span>
	      		    	</div>
	      		    </div>
	            
	            
	            <div class="row mt-5">
	      		    	<div class="col text-start">
			      		    <span class="badge rounded-pill bg-danger w-75" style="font-size:40px;">취소</span>
	      		    	</div>
	      		    	<div class="col text-end ">
			      		    <span class="badge rounded-pill bg-info w-75" style="font-size:40px;">완료</span>
	      		    	</div>
	      		    </div>
	            
	            </div>
	        </div>
	    </div>
	
	<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>