<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

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
                        <img src="https://dummyimage.com/150/150/000/" class="rounded-circle">
                    </div>
                    <div class="col-lg-8 col-md-8 text-start mt-5	">
                        <span class="h2">${memberDto.memberName}</span>
                        <div class="h4">지역, ${memberDto.memberBirth}</div>
                        <div class="h4">자기소개</div>
                    </div>
                </div>

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