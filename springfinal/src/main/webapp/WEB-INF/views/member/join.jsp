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
                .check, .choice {
              display: none;   
                }
                
               

                .btn-join, .email-check {
                    pointer-events: none;
                    opacity: 0.5;
                    /* 또는 다른 값을 사용하여 투명도 조절 가능 */
                }
                
                .addr-list {
    position: absolute;
    z-index: 1000;
    max-height: 250px; /* 적절한 높이로 설정 */
    width: 545px;
    overflow: auto; /* 스크롤이 필요한 경우 스크롤 허용 */
    margin-top: 5px;
    }

/* 입력창의 상단에 위치하도록 설정 */
.position-relative {
    position: relative;
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
								$(".check-number-contain").hide();
                                // ID 문자열 검사 코드
                                $("[name=memberId]")
                                    .blur(
                                        function () {
                                            var regex = /^[a-z][a-z0-9]{4,19}$/;
                                            var inputId = $(this).val(); // Updated to refer to $(this) directly
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
                                                    url: window.contextPath + "/rest/member/checkId",
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
                                                            $("[name=check1]").prop("checked", false).trigger("change");
                                                        }
                                                        else {
                                                        	console.log("아이디 성공");
                                                            $('.d-id-feedback').hide();
                                                            $("[name=memberId]").addClass("is-valid");
                                                            $(".id-feedback").addClass("is-valid");
                                                            $("#check1").prop("checked", true).trigger("change");
                                                        }
                                                    }
                                                });
                                            } else {
                                                $(this).addClass("is-invalid");
                                                $('.d-id-feedback').addClass(
                                                    "text-danger");
	                                                $("[name=check1]").prop(
	                                                    "checked", false).trigger("change");
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
                                                $("[name=check2]").prop("checked", false).trigger("change");
                                                $(".checkPw-feed").addClass("is-invalid");
                                            }
                                        }
                                        else {
                                            $(this).addClass("is-valid");
                                            if ($("[name=checkPw]").val() != "" && $("[name=checkPw]").val() != $(this).val()) {
                                                $("[name=checkPw]").addClass("is-invalid");
                                                $("[name=check2]").prop("checked", false).trigger("change");
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
                                        $("[name=check2]").prop("checked", true).trigger("change");
                                        $(this).addClass("is-valid");
                                    }
                                    else {
                                        $(this).addClass("is-invalid");
                                        $("[name=check2]").prop("checked", false).trigger("change");
                                        $(".checkPw-feed").addClass("is-invalid");
                                    }
                                });
								
                                //닉네임 값 유무 검사
                                $("[name=memberName]").blur(function () {
                                	$(".name-feed").removeClass("is-invalid");
                                	$(this).removeClass("is-valid is-invalid")
                                    if ($("[name=memberName]").val() != "") {
                                        $(this).addClass("is-valid");
                                        $("[name=check3]").prop("checked", true).trigger("change");
                                    } else {
                                    	$(".name-feed").addClass("is-invalid");
                                    	$(this).addClass("is-invalid");
                                        $("[name=check3]").prop("checked", false).trigger("change");
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
                                        if(inputEmail===""){
                                        	return;
                                        }
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
                                    var regex = /^[1-2][0-9][0-9]{2}-[01][0-9]-[0-3][0-9]$/;
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
                                        $(this).removeClass("is-invalid is-valid");
                                    	if($(this).val()=="") {
                                    		retrun;
                                    	};
                                        var inputContent = $(this).val();
                                        var regex = /^\d{10,11}$/;
                                        var isValid = regex.test(inputContent)
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
                                
                                
                                //필수 항목 전부 체크시 가입 버튼 활성화
                                $(".check").change(function () {
                                            if ($(".check").length == $(".check:checked").length) {
                                                $(".btn-join").css({
                                                    "pointer-events": "auto",
                                                    "opacity": "1" // 투명도를 1로 설정하여 다시 원래 상태로 만듭니다.
                                                });
                                            } 
                                            else {
                                            	console.log("바뀜");
                                                $(".btn-join").css({
                                                    "pointer-events": "none",
                                                    "opacity": "0.5" // 투명도를 1로 설정하여 다시 원래 상태로 만듭니다.
                                                });
                                            }
                                        })
                                
                                 //이메일 인증번호 발송		
                                $(".email-check").click(function (e) {
                                    e.preventDefault();
                                    $(".check-number-contain").show();
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
                                        url: window.contextPath + "/cert/send",
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
										url: window.contextPath + "/cert/check",
										method:"post",
										data:{
											certEmail:certEmail,
											certNumber:certNumber
										},
										 success: function(response) {
											if(response=="Y"){
												$("#checkNumber").addClass("is-valid");
												$(".check-number").prop("checked", true).trigger("change");
												$("[name=check4]")
                                                .prop("checked", true).trigger("change");
											}
											else{
												$(".checkNumber-feed").addClass("is-invalid");
												$("#checkNumber").addClass("is-invalid");
												$("[name=check4]")
                                                .prop("checked", false).trigger("change");
											}
										}
									});
								});
                                
								//관심 카테고리 동작 코드 1
								$("[name=mojor-s1]").change(function () {
									$(".ds1").hide();
									$(".choice1").css("display", "none");
								    var mojor = $(this).val();
								    if (mojor != "") {
								        $("#monor1").prop("disabled", false);
								        if ($(".choice1").hasClass(mojor)) {
								            $(".choice1." + mojor).css("display", "inline-block");
								        } else {
								            // 해당 클래스가 없는 경우의 동작을 추가할 수 있습니다.
								           $(".ds1").prop("selected", true).trigger("change");
								    	 $(".choice1").css("display", "none");
								    	$("#monor1").prop("disabled", true).trigger("change"); // 예시로 display를 none으로 설정
								    	 $(".category-check")
                                         .prop("checked", false).trigger("change");
								        }
								    }
								    else{
								    	$(".ds1").prop("selected", true);
								    	 $(".choice1").css("display", "none");
								    	$("#monor1").prop("disabled", true);
								    	 $(".category-check")
                                         .prop("checked", false).trigger("change");
								    }
								});
								
								
								//관심 카테고리 동작 코드 2
								$("[name=mojor-s2]").change(function () {
									$(".ds2").hide();
									$(".choice2").css("display", "none");
								    var mojor = $(this).val();
								    if (mojor != "") {
								        $("#monor2").prop("disabled", false);
								        if ($(".choice2").hasClass(mojor)) {
								            $(".choice2." + mojor).css("display", "inline-block");
								        } else {
								            // 해당 클래스가 없는 경우의 동작을 추가할 수 있습니다.
								           $(".ds2").prop("selected", true);
								    	 $(".choice2").css("display", "none");
								    	$("#monor2").prop("disabled", true); // 예시로 display를 none으로 설정
								    	 $(".category-check")
                                         .prop("checked", false).trigger("change");
								        }
								    }
								    else{
								    	$(".ds2").prop("selected", true);
								    	 $(".choice2").css("display", "none");
								    	$("#monor2").prop("disabled", true);
								    	 $(".category-check")
                                         .prop("checked", false).trigger("change");
								    }
								});
								
								//관심 카테고리 동작 코드 3
								$("[name=mojor-s3]").change(function () {
									$(".ds3").hide();
									$(".choice3").css("display", "none");
								    var mojor = $(this).val();
								    if (mojor != "") {
								        $("#monor3").prop("disabled", false);
								        if ($(".choice3").hasClass(mojor)) {
								            $(".choice3." + mojor).css("display", "inline-block");
								        } else {
								            // 해당 클래스가 없는 경우의 동작을 추가할 수 있습니다.
								           $(".ds3").prop("selected", true);
								    	 $(".choice3").css("display", "none");
								    	$("#monor3").prop("disabled", true); // 예시로 display를 none으로 설정
								    	 $(".category-check")
                                         .prop("checked", false).trigger("change");
								        }
								    }
								    else{
								    	$(".ds3").prop("selected", true);
								    	 $(".choice3").css("display", "none");
								    	$("#monor3").prop("disabled", true);
								    	 $(".category-check")
                                         .prop("checked", false).trigger("change");
								    }
								});
								
								
						
								//카테고리 값 유무 검사
								$(".mojor-check").change(function () {
									if($(this).val()!=null){
										 $(".category-check")
                                         .prop("checked", true).trigger("change");
									}
									else{
										$(".category-check")
                                        .prop("checked", false).trigger("change");
									}
								})
						           });

						               
						               

									
								
								
                        </script>
                              <script>
    	$(function () {
    		var searchTimeout;

    		$(".search-input").on('input', function () {
    		    $(".addr-list").show();

    		    var keyword = $(this).val();

    		    if (searchTimeout) {
    		        clearTimeout(searchTimeout); // 이전 타이머가 있다면 제거
    		    }

    		    // 300ms 후에 Ajax 요청을 보냄
    		    searchTimeout = setTimeout(function () {
    		        if (keyword.length === 0) {
    		            $(".zip").hide();
    		            return;
    		        }

    		        $.ajax({
    		            url: window.contextPath + "/rest/zipPage",
    		            method: "get",
    		            data: { keyword: keyword },
    		            success: function (response) {
    		                // 검색 결과를 처리
    		                var zipList = $('.addr-list');
    		                // 이전 검색 결과 지우기
    		                zipList.empty();

    		                for (var i = 0; i < response.length; i++) {
    		                    var text = (response[i].sido != null ? response[i].sido + ' ' : '') +
    		                        (response[i].sigungu != null ? response[i].sigungu + ' ' : '') +
    		                        (response[i].eupmyun != null ? response[i].eupmyun + ' ' : '') +
    		                        (response[i].hdongName != null ? response[i].hdongName: '');

    		                    zipList.append($("<li>")
    		                        .addClass("list-group-item zip")
    		                        .val(response[i].zipCodeNo)
    		                        .text(text)
    		                        .data("result", text)
    		                    );
    		                }
    		            }
    		        });
    		    }, 300); // 300ms 딜레이
    		});

    	        
    	        // [3] 목록을 클릭하면 입력창에 채우고 .zip 엘리먼트 숨기기
        	    $(".addr-list").on("click", ".zip", function () {
        	    	
        	    			
        	    	
        	    	
        	        var selectedAddress = $(this).data("result");
        	        $(".search-input").val(selectedAddress).trigger("change"); 
        	        
        	        $(".addr-list").hide();
        	        
        	    });
    	        
    	        	    
    	    var page = 1; // 초기 페이지
    	    var scrollTimeout; // 스크롤 이벤트를 지연시키기 위한 타이머

    	    // 스크롤 이벤트 핸들러
    	    $('.addr-list').scroll(function () {
    	        var zipList = $(this);

    	        if (scrollTimeout) {
    	            clearTimeout(scrollTimeout); // 이전 타이머가 있다면 제거
    	        }

    	        // 200ms 후에 스크롤 이벤트를 처리
    	        scrollTimeout = setTimeout(function () {
    	            if (zipList.scrollTop() + zipList.innerHeight() >= zipList[0].scrollHeight - 100) {
    	                // 스크롤이 zipList의 하단에 도달하면 새로운 데이터 로드
    	                loadMoreData($(".search-input").val());
    	            }
    	        }, 200);
    	    });

    	 // 데이터 로드 함수
    	 function loadMoreData() {
    	     page++; // 다음 페이지로 이동
    	     var keyword = $(".search-input").val();

    	     $.ajax({
    	         url: window.contextPath "/rest/zipPage",
    	         method: "get",
    	         data: { keyword: keyword, page: page }, // 페이지 정보를 서버에 전달
    	         success: function (response) {
    	             var zipList = $('.addr-list');

    	             for (var i = 0; i < response.length; i++) {
    	                 var text = (response[i].sido != null ? response[i].sido + ' ' : '') +
    	                     (response[i].sigungu != null ? response[i].sigungu + ' ' : '') +
    	                     (response[i].eupmyun != null ? response[i].eupmyun + ' ' : '') +
    	                     (response[i].hdongName != null ? response[i].hdongName  : '');


    	                 zipList.append($("<li>")
    	                     .addClass("list-group-item zip")
    	                     .val(response[i].zipCodeNo)
    	                     .text(text)
    	                     .data("result", text)
    	                 );
    	             }
    	         }
    	     });
    	 }


			$("#memberAddr").change(
                    function () {
                    	console.log(this);
                        $(this).removeClass("is-invalid is-valid");
                        $(".d-addr-feedback").removeClass(
                        "text-danger");
                        $(".addr-feed").removeClass("is-invalid is-valid");
                    	if($(this).val()=="") {
                    		$(this).addClass("is-invalid");
                    		$(".addr-feed").addClass("is-invalid");
                    		$(".d-addr-feedback").addClass(
                            "text-danger");
                    		$(".addrCheck").prop("checked", false).trigger("change");
                    		return;
                    	};
                            var inputContent = $(this).val();
                            var regex = /^[가-힣]+\s[가-힣]+\s[가-힣]+$/;
                            var isValid = regex.test(inputContent);
                            if (isValid) {
                                $(this).addClass("is-valid");
                                $(".addr-feed").addClass("is-valid");
                                $(".addrCheck").prop("checked", true).trigger("change");
                            } 
                            else {
                                $(this).addClass("is-invalid");
                                $(".addr-feed").addClass("is-invalid");
                                $(".d-addr-feedback").addClass(
                                    "text-danger");
                                $(".addrCheck").prop("checked", false).trigger("change");
                            }
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
                                                            <input type="password" class="form-control" name="memberPw"
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
                                                            <input type="password" class="form-control" name="checkPw"
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
                                                        <div class="form-floating name-feed">
                                                            <input type="checkbox" name="check3" class="check">
                                                            <input type="text" class="form-control" name="memberName"
                                                                id="memberName" placeholder="실명" required> <label
                                                                for="memberName">실명*</label>
                                                        </div>
                                                        <div class="invalid-feedback">필수항목입니다</div>
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
											<div class="row mt-3 check-number-contain">
												<div class="col">
		                                            <div class="input-group has-validation">
		                                                <div class="form-floating checkNumber-feed">
		                                                    <input type="text" class="form-control" id="checkNumber"
		                                                        placeholder="인증번호" required>
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
                                                                id="memberContact" placeholder="연락처" required> <label
                                                                for="memberContact">연락처</label>
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
                                                            <div class="d-brith-feedback">'-'을 포함하여 
                                                                적어주세요.ex->1990-01-01</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
															
											<input type="checkbox" class="check addrCheck">
											<div class="row mt-4">
							                    <div class="col">
							                       <div class="input-group has-validation">
                                                       <div class="form-floating addr-feed">
                                                            <input type="search" class="form-control search-input" name="StringmemberAddr"
                                                                id="memberAddr" placeholder="" required>  <label
                                                                for="memberBirth">주소</label>
                                                       	</div>
                                                       	<div class="invalid-feedback">동,읍,면을 입력해주세요</div>
                                                    	</div>
                                                    </div>
							                    </div>                    
							                <div class="row">
							                    <div class="col">
							                        <ul class="list-group addr-list">
							                        </ul>
							                    </div>
							                </div>
											<script>
											$("#memberAddr").change(
				                                    function () {
				                                        $(this).removeClass("is-invalid is-valid");
				                                        $(".d-addr-feedback").removeClass(
		                                                "text-danger");
				                                        $(".addr-feed").removeClass("is-invalid is-valid");
				                                    	if($(this).val()=="") {
				                                    		$(this).addClass("is-invalid");
				                                    		$(".addr-feed").addClass("is-invalid");
				                                    		$(".d-addr-feedback").addClass(
			                                                "text-danger");
				                                    		$(".addrCheck").prop("checked", false).trigger("change");
				                                    	};
					                                        var inputContent = $(this).val();
					                                        var regex = /^[가-힣]+\s[가-힣]+\s[가-힣0-9]+$/;
					                                        var isValid = regex.test(inputContent);
					                                        if (isValid) {
					                                            $(this).addClass("is-valid");
					                                            $(".addr-feed").addClass("is-valid");
					                                            $(".addrCheck").prop("checked", true).trigger("change");
					                                        } 
					                                        else {
					                                            $(this).addClass("is-invalid");
					                                            $(".addr-feed").addClass("is-invalid");
					                                            $(".d-addr-feedback").addClass(
					                                                "text-danger");
					                                            $(".addrCheck").prop("checked", false).trigger("change");
					                                        }
				                                    });
											</script>

                                            
                                            <input type="checkbox" class="category-check check">
                                            <div class="form-group"> 
										      <label for="mojor1" class="form-label mt-4">무엇에 관심이 있으신가요?*</label>
										      <br>
										      <span class="mt-1">관심 1</span>
										      <select class="form-select" name="mojor-s1" id="mojor1">
										        <option class="dj1" value=null>선택하지 않음</option>
										        <option value="40">아웃도어/여행</option>
										        <option value="41">업종/직무</option>
										        <option value="42">인문학/책/글</option>
										        <option value="43">운동/스포츠</option>
										        <option value="61">외국/언어</option>
										        <option value="62">문화/공연/축제</option>
										        <option value="63">음악/악기</option>
										        <option value="64">공예/만들기</option>
										        <option value="65">댄스/무용</option>
										        <option value="66">봉사활동</option>
										        <option value="67">사교/인맥</option>
										        <option value="68">차/오토바이</option>
										        <option value="69">사진/영상</option>
										        <option value="70">야구관람</option>
										        <option value="71">게임/오락</option>
										        <option value="72">요리/제조</option>
										        <option value="73">반려동물</option>
										        <option value="74">자유주제</option>
										      </select>
										    </div>
										    
										    
										<!-- 
											40=아웃도어/여행
											41=업종/직무
											42=인문학/책/글
											43=운동/스포츠
											61=외국/언어
											62=문화/공연/축제
											63=음악/악기
											64=공예/만들기
											65=댄스/무용
											66=봉사활동
											67=사교/인맥
											68=차/오토바이
											69=사진/영상
											70=야구관람
											71=게임/오락
											72=요리/제조
											73=반려동물
											74=자유주제
										-->
<!-- 										관심 카테고리 소분류 -->
										    <div class="form-group"> 
										      <select class="form-select mojor-check" name="likeCategory" id="monor1" disabled>
								                <option class="ds1" value=""></option>
<option class="choice1 40" value="56">등산</option>
<option class="choice1 40" value="57">산책/트래킹</option>
<option class="choice1 40" value="54">캠핑/백패킹</option>
<option class="choice1 40" value="55">국내여행</option>
<option class="choice1 62" value="1">뮤지컬/오페라</option>
<option class="choice1 62" value="2">영화</option>
<option class="choice1 62" value="3">전시회</option>
<option class="choice1 62" value="4">연기/공연제작</option>
<option class="choice1 42" value="58">책/독서</option>
<option class="choice1 42" value="59">인문학</option>
<option class="choice1 42" value="60">심리학</option>
<option class="choice1 42" value="61">철학</option>
<option class="choice1 41" value="62">금융업</option>
<option class="choice1 41" value="63">교육업</option>
<option class="choice1 41" value="64">디자인업계</option>
<option class="choice1 41" value="65">컨설팅</option>
<option class="choice1 43" value="66">자전거</option>
<option class="choice1 43" value="67">배드민턴</option>
<option class="choice1 43" value="68">볼링</option>
<option class="choice1 43" value="69">골프</option>
<option class="choice1 71" value="70">보드게임</option>
<option class="choice1 71" value="71">두뇌심리게임</option>
<option class="choice1 71" value="72">온라인게임</option>
<option class="choice1 71" value="73">콘솔게임</option>
<option class="choice1 61" value="6">영어</option>
<option class="choice1 61" value="7">일본어</option>
<option class="choice1 61" value="8">중국어</option>
<option class="choice1 61" value="9">독일어</option>
<option class="choice1 63" value="10">노래/보컬</option>
<option class="choice1 63" value="11">기타/베이스</option>
<option class="choice1 63" value="12">우쿨렐레</option>
<option class="choice1 63" value="13">드럼</option>
<option class="choice1 63" value="14">피아노</option>
<option class="choice1 64" value="15">미술/그림</option>
<option class="choice1 64" value="16">켈리그라피</option>
<option class="choice1 64" value="17">플라워아트</option>
<option class="choice1 64" value="18">캔들/디퓨저/석고</option>
<option class="choice1 65" value="19">라틴댄스</option>
<option class="choice1 65" value="20">사교댄스</option>
<option class="choice1 65" value="21">방송/힙합</option>
<option class="choice1 65" value="22">스트릿댄스</option>
<option class="choice1 66" value="27">양로원</option>
<option class="choice1 66" value="28">보육원</option>
<option class="choice1 66" value="23">환경봉사</option>
<option class="choice1 66" value="24">사회봉사</option>
<option class="choice1 67" value="25">지역</option>
<option class="choice1 67" value="26">나이</option>
<option class="choice1 67" value="29">파티</option>
<option class="choice1 67" value="30">결혼</option>
<option class="choice1 68" value="31">현대</option>
<option class="choice1 68" value="32">기아</option>
<option class="choice1 68" value="33">르노</option>
<option class="choice1 68" value="34">쌍용</option>
<option class="choice1 69" value="35">필름카메라</option>
<option class="choice1 69" value="36">영상제작</option>
<option class="choice1 69" value="37">디지털카메라</option>
<option class="choice1 70" value="38">디에스엠알</option>
<option class="choice1 70" value="39">삼성라이온즈</option>
<option class="choice1 70" value="40">기아타이거즈</option>
<option class="choice1 70" value="41">롯데자이언츠</option>
<option class="choice1 70" value="42">두산베어스</option>
<option class="choice1 72" value="5">한식</option>
<option class="choice1 72" value="43">일식</option>
<option class="choice1 72" value="44">중식</option>
<option class="choice1 72" value="45">양식</option>
<option class="choice1 73" value="46">강아지</option>
<option class="choice1 73" value="47">고양이</option>
<option class="choice1 73" value="48">물고기</option>
<option class="choice1 73" value="49">파충류</option>
<option class="choice1 74" value="50">금융보험</option>
<option class="choice1 74" value="51">취업스터디</option>
<option class="choice1 74" value="52">시험/자격증</option>
<option class="choice1 74" value="53">스피치/발성</option>
										      </select>
										    </div>
										    
                                            <!-- 2. 관심 테이블 대분류 -->
                                            <div class="form-group"> 
										      <label for="mojor2" class="form-label mt-4">관심 2</label>
										      <select class="form-select" name="mojor-s2" id="mojor2">
										        <option class="dj2" value=null>선택하지 않음</option>
										        <option value="40">아웃도어/여행</option>
										        <option value="41">업종/직무</option>
										        <option value="42">인문학/책/글</option>
										        <option value="43">운동/스포츠</option>
										        <option value="61">외국/언어</option>
										        <option value="62">문화/공연/축제</option>
										        <option value="63">음악/악기</option>
										        <option value="64">공예/만들기</option>
										        <option value="65">댄스/무용</option>
										        <option value="66">봉사활동</option>
										        <option value="67">사교/인맥</option>
										        <option value="68">차/오토바이</option>
										        <option value="69">사진/영상</option>
										        <option value="70">야구관람</option>
										        <option value="71">게임/오락</option>
										        <option value="72">요리/제조</option>
										        <option value="73">반려동물</option>
										        <option value="74">자유주제</option>
										      </select>
										    </div>
										    
										    
<!-- 										관심 카테고리 소분류 -->
										    <div class="form-group"> 
										      <select class="form-select mojor-check" name="likeCategory" id="monor2" disabled>
								                <option class="ds2" value=""></option>
<option class="choice2 40" value="56">등산</option>
<option class="choice2 40" value="57">산책/트래킹</option>
<option class="choice2 40" value="54">캠핑/백패킹</option>
<option class="choice2 40" value="55">국내여행</option>
<option class="choice2 62" value="1">뮤지컬/오페라</option>
<option class="choice2 62" value="2">영화</option>
<option class="choice2 62" value="3">전시회</option>
<option class="choice2 62" value="4">연기/공연제작</option>
<option class="choice2 42" value="58">책/독서</option>
<option class="choice2 42" value="59">인문학</option>
<option class="choice2 42" value="60">심리학</option>
<option class="choice2 42" value="61">철학</option>
<option class="choice2 41" value="62">금융업</option>
<option class="choice2 41" value="63">교육업</option>
<option class="choice2 41" value="64">디자인업계</option>
<option class="choice2 41" value="65">컨설팅</option>
<option class="choice2 43" value="66">자전거</option>
<option class="choice2 43" value="67">배드민턴</option>
<option class="choice2 43" value="68">볼링</option>
<option class="choice2 43" value="69">골프</option>
<option class="choice2 71" value="70">보드게임</option>
<option class="choice2 71" value="71">두뇌심리게임</option>
<option class="choice2 71" value="72">온라인게임</option>
<option class="choice2 71" value="73">콘솔게임</option>
<option class="choice2 61" value="6">영어</option>
<option class="choice2 61" value="7">일본어</option>
<option class="choice2 61" value="8">중국어</option>
<option class="choice2 61" value="9">독일어</option>
<option class="choice2 63" value="10">노래/보컬</option>
<option class="choice2 63" value="11">기타/베이스</option>
<option class="choice2 63" value="12">우쿨렐레</option>
<option class="choice2 63" value="13">드럼</option>
<option class="choice2 63" value="14">피아노</option>
<option class="choice2 64" value="15">미술/그림</option>
<option class="choice2 64" value="16">켈리그라피</option>
<option class="choice2 64" value="17">플라워아트</option>
<option class="choice2 64" value="18">캔들/디퓨저/석고</option>
<option class="choice2 65" value="19">라틴댄스</option>
<option class="choice2 65" value="20">사교댄스</option>
<option class="choice2 65" value="21">방송/힙합</option>
<option class="choice2 65" value="22">스트릿댄스</option>
<option class="choice2 66" value="27">양로원</option>
<option class="choice2 66" value="28">보육원</option>
<option class="choice2 66" value="23">환경봉사</option>
<option class="choice2 66" value="24">사회봉사</option>
<option class="choice2 67" value="25">지역</option>
<option class="choice2 67" value="26">나이</option>
<option class="choice2 67" value="29">파티</option>
<option class="choice2 67" value="30">결혼</option>
<option class="choice2 68" value="31">현대</option>
<option class="choice2 68" value="32">기아</option>
<option class="choice2 68" value="33">르노</option>
<option class="choice2 68" value="34">쌍용</option>
<option class="choice2 69" value="35">필름카메라</option>
<option class="choice2 69" value="36">영상제작</option>
<option class="choice2 69" value="37">디지털카메라</option>
<option class="choice2 70" value="38">디에스엠알</option>
<option class="choice2 70" value="39">삼성라이온즈</option>
<option class="choice2 70" value="40">기아타이거즈</option>
<option class="choice2 70" value="41">롯데자이언츠</option>
<option class="choice2 70" value="42">두산베어스</option>
<option class="choice2 72" value="5">한식</option>
<option class="choice2 72" value="43">일식</option>
<option class="choice2 72" value="44">중식</option>
<option class="choice2 72" value="45">양식</option>
<option class="choice2 73" value="46">강아지</option>
<option class="choice2 73" value="47">고양이</option>
<option class="choice2 73" value="48">물고기</option>
<option class="choice2 73" value="49">파충류</option>
<option class="choice2 74" value="50">금융보험</option>
<option class="choice2 74" value="51">취업스터디</option>
<option class="choice2 74" value="52">시험/자격증</option>
<option class="choice2 74" value="53">스피치/발성</option>
										      </select>
										    </div>
										    
                                          <!-- 3. 관심 테이블 대분류 -->
                                            <div class="form-group"> 
										      <label for="mojor3" class="form-label mt-4">관심 3</label>
										      <select class="form-select" name="mojor-s3" id="mojor3">
										        <option class="dj3" value=null>선택하지 않음</option>
										        <option value="40">아웃도어/여행</option>
										        <option value="41">업종/직무</option>
										        <option value="42">인문학/책/글</option>
										        <option value="43">운동/스포츠</option>
										        <option value="61">외국/언어</option>
										        <option value="62">문화/공연/축제</option>
										        <option value="63">음악/악기</option>
										        <option value="64">공예/만들기</option>
										        <option value="65">댄스/무용</option>
										        <option value="66">봉사활동</option>
										        <option value="67">사교/인맥</option>
										        <option value="68">차/오토바이</option>
										        <option value="69">사진/영상</option>
										        <option value="70">야구관람</option>
										        <option value="71">게임/오락</option>
										        <option value="72">요리/제조</option>
										        <option value="73">반려동물</option>
										        <option value="74">자유주제</option>
										      </select>
										    </div>
										    
										    
<!-- 										관심 카테고리 소분류 -->
										    <div class="form-group"> 
										      <select class="form-select mojor-check" name="	" id="monor3" disabled>
								                <option class="ds3" value=""></option>
<option class="choice3 40" value="56">등산</option>
<option class="choice3 40" value="57">산책/트래킹</option>
<option class="choice3 40" value="54">캠핑/백패킹</option>
<option class="choice3 40" value="55">국내여행</option>
<option class="choice3 62" value="1">뮤지컬/오페라</option>
<option class="choice3 62" value="2">영화</option>
<option class="choice3 62" value="3">전시회</option>
<option class="choice3 62" value="4">연기/공연제작</option>
<option class="choice3 42" value="58">책/독서</option>
<option class="choice3 42" value="59">인문학</option>
<option class="choice3 42" value="60">심리학</option>
<option class="choice3 42" value="61">철학</option>
<option class="choice3 41" value="62">금융업</option>
<option class="choice3 41" value="63">교육업</option>
<option class="choice3 41" value="64">디자인업계</option>
<option class="choice3 41" value="65">컨설팅</option>
<option class="choice3 43" value="66">자전거</option>
<option class="choice3 43" value="67">배드민턴</option>
<option class="choice3 43" value="68">볼링</option>
<option class="choice3 43" value="69">골프</option>
<option class="choice3 71" value="70">보드게임</option>
<option class="choice3 71" value="71">두뇌심리게임</option>
<option class="choice3 71" value="72">온라인게임</option>
<option class="choice3 71" value="73">콘솔게임</option>
<option class="choice3 61" value="6">영어</option>
<option class="choice3 61" value="7">일본어</option>
<option class="choice3 61" value="8">중국어</option>
<option class="choice3 61" value="9">독일어</option>
<option class="choice3 63" value="10">노래/보컬</option>
<option class="choice3 63" value="11">기타/베이스</option>
<option class="choice3 63" value="12">우쿨렐레</option>
<option class="choice3 63" value="13">드럼</option>
<option class="choice3 63" value="14">피아노</option>
<option class="choice3 64" value="15">미술/그림</option>
<option class="choice3 64" value="16">켈리그라피</option>
<option class="choice3 64" value="17">플라워아트</option>
<option class="choice3 64" value="18">캔들/디퓨저/석고</option>
<option class="choice3 65" value="19">라틴댄스</option>
<option class="choice3 65" value="20">사교댄스</option>
<option class="choice3 65" value="21">방송/힙합</option>
<option class="choice3 65" value="22">스트릿댄스</option>
<option class="choice3 66" value="27">양로원</option>
<option class="choice3 66" value="28">보육원</option>
<option class="choice3 66" value="23">환경봉사</option>
<option class="choice3 66" value="24">사회봉사</option>
<option class="choice3 67" value="25">지역</option>
<option class="choice3 67" value="26">나이</option>
<option class="choice3 67" value="29">파티</option>
<option class="choice3 67" value="30">결혼</option>
<option class="choice3 68" value="31">현대</option>
<option class="choice3 68" value="32">기아</option>
<option class="choice3 68" value="33">르노</option>
<option class="choice3 68" value="34">쌍용</option>
<option class="choice3 69" value="35">필름카메라</option>
<option class="choice3 69" value="36">영상제작</option>
<option class="choice3 69" value="37">디지털카메라</option>
<option class="choice3 70" value="38">디에스엠알</option>
<option class="choice3 70" value="39">삼성라이온즈</option>
<option class="choice3 70" value="40">기아타이거즈</option>
<option class="choice3 70" value="41">롯데자이언츠</option>
<option class="choice3 70" value="42">두산베어스</option>
<option class="choice3 72" value="5">한식</option>
<option class="choice3 72" value="43">일식</option>
<option class="choice3 72" value="44">중식</option>
<option class="choice3 72" value="45">양식</option>
<option class="choice3 73" value="46">강아지</option>
<option class="choice3 73" value="47">고양이</option>
<option class="choice3 73" value="48">물고기</option>
<option class="choice3 73" value="49">파충류</option>
<option class="choice3 74" value="50">금융보험</option>
<option class="choice3 74" value="51">취업스터디</option>
<option class="choice3 74" value="52">시험/자격증</option>
<option class="choice3 74" value="53">스피치/발성</option>
										      </select>
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
									