<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/zephyr/bootstrap.min.css" rel="stylesheet">
    <!-- <link href="test.css" rel="stylesheet"> -->
</head>

<style>
    .bg-miso{
        background-color: #99BCED;
        color: #000000;
    }
</style>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-6 offset-md-3">

             
                <div class="row mt-5 pt-5">
                    <div class="col"> 
                        
                        <div class="row mt-5">
                            <div class="col text-center">
                               <img src="${pageContext.request.contextPath}/images/miso_logo.png" width="30%">
                            </div>
                        </div>

<form class="form-group" action="./login" method="post">
                        <div class="row mt-4">
                            <div class="col-md-6 offset-md-3 col-sm-8 offset-sm-2">
                                <div class="form-floating">
                                    <input type="text" name="memberId" id="memberId" class="form-control" placeholder="이글자는안보임" value="${cookie.saveId.value}" autocomplete="off">
                                    <label for="memberId">아이디
                                        <span class="fa-solid fa-asterisk text-danger"></span>
                                    </label>
                                    <div class="invalid-feedback">아이디를 다시 입력하세요</div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-3">
                            <div class="col-md-6 offset-md-3 col-sm-8 offset-sm-2">
                                <div class="form-floating">
                                    <input type="password" name="memberPw" class="form-control" placeholder="이글자는안보임" id="memberPw">
                                    <label for="exampleInputPassword1">비밀번호
                                        <span class="fa-solid fa-asterisk text-danger"></span>
                                    </label>
                                    <div class="invalid-feedback">비밀번호를 다시 입력하세요</div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-md-6 offset-md-3 col-sm-8 offset-sm-2">
                               <div class="form-check">
                                	<c:choose>
                                		<c:when test="${cookie.saveId.value != null}">
                                			<input class="form-check-input" type="checkbox" name="saveId" value="save" id="saveId" checked>
                                		</c:when>
                                		<c:otherwise>
		                                    <input class="form-check-input" type="checkbox" name="saveId" value="save" id="saveId">
                                		</c:otherwise>
                                	</c:choose>
                                    <label class="form-check-label" for="saveId">
                                        아이디 저장하기
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-md-6 offset-md-3 col-sm-8 offset-sm-2">
                                    <button type="button" class="btn btn-lg bg-miso w-100">로그인</button>
                            </div>
                        </div>
                    </form>

                        <hr class="col-md-6 offset-md-3 col-sm-8 offset-sm-2">
                        <div class="row">
                            <div class="col-md-6 offset-md-3 col-sm-8 offset-sm-2 text-center mb-5">
							<a href="./searchId" class="link-underline link-underline-opacity-0 link-underline-opacity-75-hover">아이디 찾기</a>
                                |
                                <a href="#" class="link-underline link-underline-opacity-0 link-underline-opacity-75-hover">비밀번호 찾기</a>
                                |
                                <a href="./join" class="link-underline link-underline-opacity-0 link-underline-opacity-75-hover">회원가입</a>
                            </div>
                        </div>
                        
                    </div>
                </div>
               

            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>