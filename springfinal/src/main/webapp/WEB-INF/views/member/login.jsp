<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<div class="contain-fluid w-120">
            <div class="row">
                <div class="col">

                   
                    <div class="row mt-5 pt-5">
                        <div class="col-sm-6 offset-sm-3 text-center">
                            <h1>로그인</h1>
                        </div>
                    </div>
                    <form class="form-group" action="./login" method="post">
                        <div class="row">
                            <div class="col-sm-6 offset-sm-3 col-lg-10 offset-lg-1">
                                <div class="form-group">
                                    <label for="exampleInputId1" class="form-label mt-4 is-valid">아이디</label>
                                    <input type="text" class="form-control" name="memberId" id="memberId" autocomplete="off">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1">
                                <div class="form-group">
                                    <label for="exampleInputPassword1" class="form-label mt-4">비밀번호</label>
                                    <input type="password" class="form-control" name="memberPw" id="memberPw" autocomplete="off">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="saveId">
                                    <label class="form-check-label" for="saveId">
                                        아이디 저장하기
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1">
                                <button class="btn btn-primary w-100">로그인</button>
                            </div>
                        </div>
                    </form>
                    <div class="row">
                        <div class="col-sm-6 offset-sm-3  col-lg-10 offset-lg-1">
                            <a href="#"><button class="btn">아이디 찾기</button></a>
                            <a href="#"><button class="btn">비밀번호 찾기</button></a>
                            <a href="./join"><button class="btn btn-primary">회원가입</button></a>
                        </div>
                    </div>
                

                </div>
            </div>
        </div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>