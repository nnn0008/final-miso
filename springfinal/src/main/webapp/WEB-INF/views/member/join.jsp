<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>miso</title>


            <!-- 아이콘 사용을 위한 Font Awesome 6 CDN-->
            <link rel="stylesheet" type="text/css"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">


            <!-- 부트스트랩 CDN -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/zephyr/bootstrap.min.css"
                rel="stylesheet">

            <!-- 스타일시트 로딩 코드 -->
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
            <link href="${pageContext.request.contextPath}/css/misolayout.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/css/miso.css" rel="stylesheet">
            <!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->


            <!-- jquery cdn -->
            <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>



            <script>
                window.contextPath = "${pageContext.request.contextPath}";
            </script>

            <style>
                .check {
                    display: none;
                }

                .btn-join, .email-check {
                    pointer-events: none;
                    opacity: 0.5;
                    /* 또는 다른 값을 사용하여 투명도 조절 가능 */
                }
            </style>
        </head>

        <body>


            <main>
                <header> </header>
                <nav></nav>
                <section>

                    <!-- 헤더 -->
                    <article class="main-content">

                        <script>
                            $(function () {

                                // ID 문자열 검사 코드
                                $("[name=memberId]")
                                    .blur(
                                        function () {
                                            var regex = /^[a-z][a-z0-9]{4,19}$/;
                                            var inputId = $(this).val(); // Updated to refer to $(this) directly
                                            console.log(inputId);
                                            var isValid = regex.test(inputId); // Updated to use 'id' directly
                                            //긍정, 부정 class 제거
                                            $(this).removeClass(
                                                "is-valid is-invalid");
                                            $(".id-feedback").removeClass(
                                                "is-valid is-invalid");
                                            //기본 설명문 생성
                                            $('.d-id-feedback').removeClass(
                                                "text-danger").show();
                                            if (isValid && inputId != null) {
                                                // 이미 사용중이 아이디인지 체크
                                                $.ajax({
                                                    url: "http://localhost:8080/member/checkId",
                                                    method: "post",
                                                    data: {
                                                        memberId: inputId
                                                    },
                                                    success: function (
                                                        response) {
                                                        if (response === "Y") {
                                                            $('.d-id-feedback').hide();
                                                            $("[name=memberId]").addClass("is-invalid");
                                                            $(".id-feedback").addClass("is-invalid")
                                                            $("[name=check1]").prop("checked", false);
                                                        }
                                                        else {
                                                            $('.d-id-feedback').hide();
                                                            $("[name=memberId]").addClass("is-valid");
                                                            $(".id-feedback").addClass("is-valid");
                                                            $("#check1").prop("checked", true);
                                                        }
                                                    }
                                                });
                                            } else {
                                                $(this).addClass("is-invalid");
                                                $('.d-id-feedback').addClass(
                                                    "text-danger");
                                                $("[name=check1]").prop(
                                                    "checked", false);
                                            }
                                        });

                                //비밀번호 문자열 검사코드
                                $("[name=memberPw]").blur(
                                    function () {
                                        var inputPw = $(this).val();
                                        var regex = /^(?=.*[a-zA-Z])(?=.*\d).{8,}$/;
                                        var isValid = regex.test(inputPw);
                                        $(".d-pw-feedback").removeClass(
                                            "text-danger");
                                        $("[name=checkPw]").removeClass("is-invalid is-valid");
                                        $(this).removeClass("is-invalid");
                                        if (!isValid) {
                                            $(this).addClass("is-invalid");
                                            $(".d-pw-feedback").addClass(
                                                "text-danger");
                                            if ($("[name=checkPw]").val() != "" && $("[name=checkPw]").val() != $(this).val()) {
                                                $("[name=checkPw]").addClass("is-invalid");
                                                $("[name=check2]").prop("checked", false);
                                                $(".checkPw-feed").addClass("is-invalid");
                                            }
                                        }
                                        else {
                                            $(this).addClass("is-valid");
                                            if ($("[name=checkPw]").val() != "" && $("[name=checkPw]").val() != $(this).val()) {
                                                $("[name=checkPw]").addClass("is-invalid");
                                                $("[name=check2]").prop("checked", false);
                                                $(".checkPw-feed").addClass("is-invalid");
                                            }
                                        }
                                    });


                                //비밀번호 체크
                                $("[name=checkPw]").blur(function () {
                                    $(this).removeClass("is-invalid is-valid");
                                    $(".checkPw-feed").removeClass("is-invalid");
                                    if($("[name=memberPw]").val()=="")return;
                                    if ($("[name=memberPw]").val() == $(this).val()) {
                                        $("[name=check2]").prop("checked", true);
                                        $(this).addClass("is-valid");
                                    }
                                    else {
                                        $(this).addClass("is-invalid");
                                        $("[name=check2]").prop("checked", false);
                                        $(".checkPw-feed").addClass("is-invalid");
                                    }
                                });

                                $("[name=memberName]").blur(function () {
                                    if ($("[name=memberName]").val() != "") {
                                        $(this).addClass("is-valid");
                                        $("[name=check3]").prop("checked", true);
                                    } else {
                                        $("[name=check3]").prop("checked", false);
                                    }
                                });

                                //이메일 형식 검사 코드
                                $("[name=memberEmail]").blur(
                                    function () {
                                        var inputEmail = $(this).val();
                                        var regex = /\S+@\S+\.\S+/;
                                        var isValid = regex.test(inputEmail)
                                        $(this).removeClass("is-valid is-invalid");
                                        $(".email-feedback").removeClass(
                                            "is-valid is-invalid");
                                        $(".d-e-feedback").removeClass(
                                            "text-danger");
                                        if (!isValid) {
                                            $(this).addClass("is-invalid");
                                            $(".email-feedback").addClass(
                                                "is-invalid");
                                            $(".d-e-feedback").addClass(
                                                "text-danger");
                                            $("[name=check4]").prop("checked",
                                                false);
                                            $(".email-check").css({
                                                "pointer-events": "none",
                                                "opacity": "0.5" 
                                            });
                                        } 
                                        else {
                                            $(this).addClass("is-valid");
                                            $("[name=check4]")
                                                .prop("checked", true);
                                            $(".email-check").css({
                                                "pointer-events": "auto",
                                                "opacity": "1" // 투명도를 1로 설정하여 다시 원래 상태로 만듭니다.
                                            });
                                        }
                                    });

                                //생년월일 형식 검사 코드
                                $("[name=memberBirth]").blur(function () {
                                	if($(this).val()=="") return;
                                    var inputContent = $(this).val();
                                    var regex = /^\d{8}$/;
                                    var isValid = regex.test(inputContent)
                                    $(this).removeClass("is-invalid is-valid");
                                    $(".d-brith-feedback").removeClass("text-danger");
                                    if (isValid) {
                                        $(this).addClass("is-valid");
                                    } else {
                                        $(this).addClass("is-invalid");
                                        $(".d-brith-feedback").addClass("text-danger");
                                    }
                                });

                                //연락처 형식 검사 코드
                                $("[name=memberContact]").blur(
                                    function () {
                                    	if($(this).val()=="") return;
                                        var inputContent = $(this).val();
                                        var regex = /^\d{10,11}$/;
                                        var isValid = regex.test(inputContent)
                                        $(this).removeClass("is-invalid is-valid");
                                        $(".d-content-feedback").removeClass(
                                            "text-danger");
                                        if (isValid) {
                                            $(this).addClass("is-valid");
                                        } 
                                        else {
                                            $(this).addClass("is-invalid");
                                            $(".d-content-feedback").addClass(
                                                "text-danger");
                                        }
                                    });
                                $(".check").change(function () {
                                            if ($(".check").length == $(".check:checked").length) {
                                                $(".btn-join").css({
                                                    "pointer-events": "auto",
                                                    "opacity": "1" // 투명도를 1로 설정하여 다시 원래 상태로 만듭니다.
                                                });
                                            } 
                                            else {
                                                (".btn-join").css({
                                                    "pointer-events": "none",
                                                    "opacity": "0.5" // 투명도를 1로 설정하여 다시 원래 상태로 만듭니다.
                                                });
                                            }
                                        })
                                
                                 //이메일 인증번호 발송		
                                $(".email-check").click(function (e) {
                                    e.preventDefault();
                                	$(".email-feedback").addClass("is-valid");
                                	$(this)
                                    .text("다시 전송하기")
                                    .css({
                                      "pointer-events": "none",
                                      "opacity": "0.5" // 투명도를 0.5로 설정하여 흐려지는 효과
                                    })
                                    .delay(5000)
                                    .queue(function (next) {
                                      // 애니메이션이 완료된 후에 실행될 코드
                                      $(this).css({
                                        "pointer-events": "auto",
                                        "opacity": "1" // 투명도를 1로 설정하여 다시 원래 상태로 만듭니다.
                                      });
                                      next(); // 다음 큐 아이템으로 진행
                                    });

                                    var memberEmail = $("[name=memberEmail]").val();
                                    if (memberEmail.length == 0) return;
                                    $.ajax({
                                        url: "http://localhost:8080/cert/send",
                                        method: "post",
                                        data: { certEmail: memberEmail },
                                        success: function (response) {
                                        	
                                        }
                                    });
                                });
								//이메일 인증번호 검사
								$("#checkNumber").blur(function(e) {
									e.preventDefault();
									var certNumber = $(this).val();
									var certEmail = $("[name=memberEmail]").val();
									$(".checkNumber-feed").removeClass("is-invalid");
									$("#checkNumber").removeClass("is-invalid is-valid");
									$.ajax({
										url:"http://localhost:8080/cert/check",
										method:"post",
										data:{
											certEmail:certEmail,
											certNumber:certNumber
										},
										 success: function(response) {
											if(response=="Y"){
												$("#checkNumber").addClass("is-valid");
												$(".check-number").prop("checked", true);
											}
											else{
												$(".checkNumber-feed").addClass("is-invalid");
												$("#checkNumber").addClass("is-invalid");
												$(".check-number").prop("checked", false);
											}
										}
									});
								});
                                
                            });
                        </script>

                        <body>
                            <div class="contain-fluid">
                                <div class="row">
                                    <div class="col">
                                        <div class="row">
                                            <div class="col text-center">
                                                <h1 class="h1">회원가입</h1>
                                            </div>
                                        </div>

                                        <div class="row mt-4">
                                            <div class="col text-end">
                                                <h5>필수항목은 * 표시가 되어있습니다</h5>
                                            </div>
                                        </div>

                                        <form action="./join" method="post">
                                            <div class="row mt-1">
                                                <div class="col">
                                                    <div class="input-group has-validation">
                                                        <div class="form-floating id-feedback">
                                                            <input type="checkbox" id="check1" class="check"> <input
                                                                type="text" class="form-control" name="memberId"
                                                                id="inputId" placeholder="아이디" required> <label
                                                                for="inputId">아이디*</label>
                                                            <div class="feedback gray d-id-feedback">영어 숫자로 이루어진
                                                                글자 5~20자를 작성해주세요</div>
                                                        </div>
                                                        <div class="invalid-feedback">이미 사용중인 아이디입니다</div>
                                                        <div class="valid-feedback">사용 가능한 아이디입니다.</div>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="row mt-3">
                                                <div class="col">
                                                    <div class="input-group has-validation">
                                                        <div class="form-floating">
                                                            <input type="checkbox" name="check2" class="check">
                                                            <input type="text" class="form-control" name="memberPw"
                                                                id="inputPw" placeholder="비밀번호" required> <label
                                                                for="inputPw">비밀번호*</label>
                                                            <div class="feedback gray d-pw-feedback">영어와 숫자로 이루어진 글자 8글자
                                                                이상 적어주세요</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row mt-3">
                                                <div class="col">
                                                    <div class="input-group has-validation">
                                                        <div class="form-floating checkPw-feed">
                                                            <input type="checkbox" name="" class="check">
                                                            <input type="text" class="form-control" name="checkPw"
                                                                id="checkPw" placeholder="비밀번호" required> <label
                                                                for="checkPw">비밀번호 확인</label>
                                                        </div>
                                                        <div class="invalid-feedback">비밀번호가 동일하지 않습니다</div>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="row mt-3">
                                                <div class="col">
                                                    <div class="input-group has-validation">
                                                        <div class="form-floating">
                                                            <input type="checkbox" name="check3" class="check">
                                                            <input type="text" class="form-control" name="memberName"
                                                                id="memberName" placeholder="실명" required> <label
                                                                for="memberName">실명*</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>





                                            <div class="row mt-3">
                                                <div class="col">
                                                    <div class="input-group has-validation">
                                                        <span class="input-group-text">@</span>
                                                        <div class="form-floating email-feedback d-felx flex-row">
                                                            <input type="checkbox" name="check4" class="check">
                                                            <input type="email" class="form-control" name="memberEmail"
                                                                id="memberEmail" placeholder="이메일" required> <label
                                                                for="memberEmail">이메일*</label>
                                                        </div>
                                                        <button
                                                            class="btn btn-primary justify-content-end email-check">인증번호
                                                            발송</button>
                                                        <div class="invalid-feedback">이메일 형식의 맞게 적어주세요.</div>
                                                        <div class="valid-feedback">이메일을 발송하였습니다</div>
                                                    </div>
                                                </div>
                                            </div>
											<div class="row mt-3">
												<div class="col">
		                                            <div class="input-group has-validation">
		                                                <div class="form-floating checkNumber-feed">
		                                                    <input type="text" class="form-control" id="checkNumber"
		                                                        placeholder="인증번호" required>
		                                                        <input type="text" class="check check-number">
		                                                    <label for="checkNumber">인증번호</label>
		                                                </div>
		                                                <div class="invalid-feedback">
		                                                    인증번호가 틀렸습니다. 다시 한번 확인해주십세요.
		                                                </div>
		                                            </div>
												</div>
											</div>


                                            <div class="row mt-3">
                                                <div class="col">
                                                    <div class="input-group has-validation">
                                                        <div class="form-floating">
                                                            <input type="text" class="form-control" name="memberContact"
                                                                id="memberContect" placeholder="연락처" required> <label
                                                                for="memberContect">연락처</label>
                                                        </div>
                                                    </div>
                                                    <div class="d-content-feedback">'-'을 제외하고 숫자로만 적어주세요</div>
                                                </div>
                                            </div>

                                            <div class="row mt-3">
                                                <div class="col">
                                                    <div class="input-group has-validation">
                                                        <div class="form-floating">
                                                            <input type="text" class="form-control" name="memberBirth"
                                                                id="memberBirth" placeholder="생년월일" required> <label
                                                                for="memberBirth">생년월일</label>
                                                            <div class="d-brith-feedback">'-'을 제외하고 숫자로만
                                                                적어주세요.ex->19901201</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>



                                            <div class="row mt-4">
                                                <div class="col">
                                                    <label>주소</label> <input type="search"
                                                        class="form-control search-input" placeholder="검색할 주소 입력">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col">
                                                    <ul class="list-group addr-list">

                                                    </ul>
                                                </div>
                                            </div>

                                            <div class="row mt-4">
                                                <div class="col">
                                                    <h1>다음내용</h1>
                                                </div>
                                            </div>
                                            <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
                                            <script>
                                                $(function () {

                                                    //[1] 다 숨겨
                                                    $(".addr-list").hide();

                                                    //[2] 검색하면 찾아서 보여줘
                                                    $(".search-input").blur("input", function () {
                                                        var keyword = $(this).val();
                                                        console.log(keyword);
                                                        //db에 있는 주소 비동기로 조회후 가져오는 구문
                                                        $.ajax({
                                                            url: "http://localhost:8080/zip/search",
                                                            method: "post",
                                                            data: {
                                                                searchVal: keyword
                                                            },
                                                            success: function (
                                                                response) {
                                                                console
                                                                    .log(response);
                                                            }
                                                        });
                                                        if (keyword.length == 0) {
                                                            $(".addr-list").hide();
                                                            return;
                                                        }

                                                        var count = 0;
                                                        $(".addr-list").each(function (idx, el) {
                                                            var text = $(el).text().trim();
                                                            //var index = text.indexOf(keyword);
                                                            //if(index >= 0) {
                                                            if (count < 5 && Hangul.search(text, keyword) >= 0) {
                                                                $(el).show();
                                                                count++;
                                                            } else {
                                                                $(el).hide();
                                                            }
                                                        });
                                                    });

                                                    //[3] 목록 누르면 입력창에 넣어
                                                    $(".addr-list").find(".list-group-item").click(
                                                        function () {
                                                            $(".search-input").val(
                                                                $(this).text());
                                                            $(".addr-list").hide();
                                                        });
                                                });
                                            </script>

                                            <div class="row mt-4">
                                                <div class="col">
                                                    <label class="form-input">등급(지울예정)</label> <select
                                                        name="memberLevel" class="form-select">
                                                        <option value="일반유저">일반유저</option>
                                                        <option value="프리미엄">프리미엄</option>
                                                        <option value="파워유저">파워유저</option>
                                                        <option value="마스터">마스터</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col">
                                                    <button class="btn btn-primary w-100 btn-join">가입</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </body>
                    </article>
                </section>
            </main>
									