<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 매번 페이지 코드를 복사할 수 없으니 미리 만든 것을 불러오도록 설정 
		- 템블릿 페이지(template page)라고 부름
		- 절대경로를 사용할 것
--%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>


 <div class="row m-2 mt-4">


                    <div class="row mb-3">
                        <div class="col">
                            <span class="badge rounded-pill bg-miso">찜한 모임 정모</span>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="alert alert-dismissible alert-light">
                            <a href="#" class="link">정모1</a>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="alert alert-dismissible alert-light">
                            <a href="#" class="link">정모1</a>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="alert alert-dismissible alert-light">
                            <a href="#" class="link">정모1</a>
                        </div>
                    </div>

                </div>



                <div class="row m-2 mt-3">

                    <div class="row mb-3">
                        <div class="col">
                            <span class="badge rounded-pill bg-miso">가입한 모임</span>
                        </div>
                    </div>

                    <div class="col d-flex flex-column align-items-start">
                        <div class="alert alert-dismissible alert-light circle">
                          <a href="#" class="link d-flex justify-content-center align-items-center" 
                          style="height: 100%; padding: 0; box-sizing: border-box;">
                            <i class="fa-solid fa-plus"></i></a>
                        </div>
                      
                        <div>
                          <label class="circle-name text-center">Java 개발자스터디</label>
                        </div>
                      
                        <div class="alert alert-dismissible alert-light circle circle-time">
                          <a href="#" class="link"></a>
                        </div>

                      </div>

                </div>

                <div class="row m-2 mt-3">

                    <div class="row mb-3">
                        <div class="col">
                            <span class="badge rounded-pill bg-miso">내 모임 정모</span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">

                            <div class="card text-white bg-miso mb-3" style="max-width: 600rem;">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    java 개발자 스터디
                                    <button type="button" class="btn btn-light rounded-pill ml-auto">참석</button>
                                </div>
                                <div class="card-body">
                                    정모합시다
                                </div>
                                <div class="card-header">
                                    화요일 31일 오후 3:30
                                </div>
                                <div class="card-body">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">

                            <div class="card text-white bg-miso mb-3" style="max-width: 600rem;">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    java 개발자 스터디
                                    <button type="button" class="btn btn-light rounded-pill ml-auto">참석</button>
                                </div>
                                <div class="card-body">
                                    정모합시다
                                </div>
                                <div class="card-header">
                                    화요일 31일 오후 3:30
                                </div>
                                <div class="card-body">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                     <div class="row">
                        <div class="col">

                            <div class="card text-white bg-miso mb-3" style="max-width: 600rem;">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    java 개발자 스터디
                                    <button type="button" class="btn btn-light rounded-pill ml-auto">참석</button>
                                </div>
                                <div class="card-body">
                                    정모합시다
                                </div>
                                <div class="card-header">
                                    화요일 31일 오후 3:30
                                </div>
                                <div class="card-body">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                     <div class="row">
                        <div class="col">

                            <div class="card text-white bg-miso mb-3" style="max-width: 600rem;">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    java 개발자 스터디
                                    <button type="button" class="btn btn-light rounded-pill ml-auto">참석</button>
                                </div>
                                <div class="card-body">
                                    정모합시다
                                </div>
                                <div class="card-header">
                                    화요일 31일 오후 3:30
                                </div>
                                <div class="card-body">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                </div>
                            </div>
                        </div>
                    </div>


                </div>



<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>