	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
	
	<style>
        /* 추가적인 스타일링을 위한 CSS 코드 */
        .rounded-button {
            border-radius: 40px !important;/* 원하는 모양에 따라 조절 */
            padding: 10px 20px !important; /* 원하는 크기에 따라 조절 */
            
        }
    .check, .choice {
	  display: none;    
    }
    
   

   .btn-edit{
        pointer-events: none;
        opacity: 0.5;
        /* 또는 다른 값을 사용하여 투명도 조절 가능 */
    }
    </style>
	
	<script>
	$(function () {
		
		
		var major0Value = "${major0}";
		var major1Value = "${major1}";
		var major2Value = "${major2}";
		console.log(major0Value);
	    // .d-major1 클래스에 해당하는 select 요소를 대상으로 처리
	    var selectElement = $("#mojor1");
	    console.log(selectElement);
	    // 각 옵션에 대해 처리
	    selectElement.find(".check-major").each(function() {
	        var optionValue = $(this).val();
	        
	        // 선택된 옵션의 값이 major0Value와 일치하면 selected 속성을 추가
	        if (optionValue === major0Value) {
	            $(this).prop("selected", true);
	        }
	    });	    
	    
	 // .d-major1 클래스에 해당하는 select 요소를 대상으로 처리
	    var selectElement = $("#mojor2");

	    // 각 옵션에 대해 처리
	    selectElement.find(".d-major2").each(function() {
	        var optionValue = $(this).val();
	        
	        // 선택된 옵션의 값이 major0Value와 일치하면 selected 속성을 추가
	        if (optionValue === major1Value) {
	            $(this).prop("selected", true);
	        }
	    });	    
	    
	 // .d-major1 클래스에 해당하는 select 요소를 대상으로 처리
	    var selectElement = $("#mojor3");

	    // 각 옵션에 대해 처리
	    selectElement.find(".d-major3").each(function() {
	        var optionValue = $(this).val();
	        
	        // 선택된 옵션의 값이 major0Value와 일치하면 selected 속성을 추가
	        if (optionValue === major2Value) {
	            $(this).prop("selected", true);
	        }
	    });	    
	    ////////////////////////////////////////////////////
	    
	    //소분류 값 띄우기
	    
	    var minor0Value = "${minor0}";
		var minor1Value = "${minor1}";
		var minor2Value = "${minor2}";
		
	    
		// .d-minor1 클래스에 해당하는 select 요소를 대상으로 처리
	    var selectElement = $("#monor1");

	    // 각 옵션에 대해 처리
	    selectElement.find(".choice1").each(function() {
	        var optionValue = $(this).val();
	        
	        // 선택된 옵션의 값이 major0Value와 일치하면 selected 속성을 추가
	        if (optionValue === minor0Value) {
	            $(this).prop("selected", true);
	            $(monor1).prop("disabled", false);
	        }
	    });	    
	    
	 // .d-minor1 클래스에 해당하는 select 요소를 대상으로 처리
	    var selectElement = $("#monor2");

	    // 각 옵션에 대해 처리
	    selectElement.find(".choice2").each(function() {
	        var optionValue = $(this).val();
	        
	        // 선택된 옵션의 값이 major0Value와 일치하면 selected 속성을 추가
	        if (optionValue === minor1Value) {
	            $(this).prop("selected", true);
	            $(monor1).prop("disabled", false);
	        }
	    });	    
	    
	 // .d-minor1 클래스에 해당하는 select 요소를 대상으로 처리
	    var selectElement = $("#monor3");

	    // 각 옵션에 대해 처리
	    selectElement.find(".choice3").each(function() {
	        var optionValue = $(this).val();
	        
	        // 선택된 옵션의 값이 major0Value와 일치하면 selected 속성을 추가
	        if (optionValue === minor2Value) {
	            $(this).prop("selected", true);
	            $(monor1).prop("disabled", false);
	        }
	    });	    
	    
	    ///////////////////////////////////////////////////////
	    
	    if ($(".check").length == $(".check:checked").length) {
                        $(".btn-edit").css({
                            "pointer-events": "auto",
                            "opacity": "1" // 투명도를 1로 설정하여 다시 원래 상태로 만듭니다.
                        });
                    } 
                    else {
                        $(".btn-edit").css({
                            "pointer-events": "none",
                            "opacity": "0.5" // 투명도를 1로 설정하여 다시 원래 상태로 만듭니다.
                        });
                    }
	    
	    
	    
		
	    //카메라 클릭시 모달 띄우기
		$(".edit-camare").click(function() {
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
		        	$(".profile").removeAttr("src");
		        	$(".profile").attr("src", "http://localhost:8080/rest/member/profileShow?memberId=" + response.memberId+ "&timestamp=" + new Date().getTime());
		        }
		    });
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
                if (!isValid) {
                    $(this).addClass("is-invalid");
                    $(".email-feedback").addClass(
                        "is-invalid");
                    $(".d-e-feedback").addClass(
                        "text-danger");
                    $("[name=check4]").prop("checked",
                        false);
                } 
                else {
                    $(this).addClass("is-valid");
                    $("[name=check4]").prop("checked",
                            true);
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
            		$(this).addClass("is-invalid");
            		$(".d-content-feedback").addClass(
                    "text-danger");
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
                        $(".btn-edit").css({
                            "pointer-events": "auto",
                            "opacity": "1" // 투명도를 1로 설정하여 다시 원래 상태로 만듭니다.
                        });
                    } 
                    else {
                        $(".btn-edit").css({
                            "pointer-events": "none",
                            "opacity": "0.5" // 투명도를 1로 설정하여 다시 원래 상태로 만듭니다.
                        });
                    }
                })
        
        
			//관심 카테고리 동작 코드 1
								$("[name=mojor-s1]").change(function () {
									$(".ds1").prop("selected", true);
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
									$(".ds2").prop("selected", true);
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
									$(".ds3").prop("selected", true);
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
    		            url: "http://localhost:8080/rest/zipPage",
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
    	         url: "http://localhost:8080/rest/zipPage",
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
	                        <button class="btn edit-camare" data-bs-toggle="modal" data-bs-target="#edit-modal"><i class="fa-solid fa-camera fa-2xl"></i></button>
                        </div>
                    </div>
                </div>
                
                <!--   프로필 업로드를 위한 모달 -->
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
				        <button type="button" class="btn btn-primary profile-set-btn" data-bs-dismiss="modal">설정</button>
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				      </div>
				    </div>
				  </div>
				</div>
				</form>
					
				<form action=".	/edit" method="post">
					<div class="row mt-3">
                       <div class="col">
                           <div class="input-group has-validation">
                               <div class="form-floating name-feed">
                                   <input type="checkbox" name="check3" class="check" checked>
                                   <input type="text" class="form-control" name="memberName"
                                       id="memberName" placeholder="실명" value="${memberDto.memberName}" required> <label
                                       for="memberName">실명*</label>
                               </div>
                               <div class="invalid-feedback">필수항목입니다</div>
                           </div>
                       </div>
                   </div>                    
                    
                    
					<input type="checkbox" class="check addrCheck" checked>
											<div class="row mt-4">
							                    <div class="col">
							                       <div class="input-group has-validation">
                                                       <div class="form-floating addr-feed">
                                                            <input type="search" class="form-control search-input" name="memberAddrString"
                                                                id="memberAddr" placeholder="" value="${addr}" required>  <label
                                                                for="memberBirth">지역</label>
                                                                 <div class="d-addr-feedback">동, 읍, 면을 입력해 주세요</div>
                                                       	</div>
                                                    	</div>
                                                    </div>
							                    </div>                    
							                <div class="row">
							                    <div class="col">
							                        <ul class="list-group addr-list">
							                        </ul>
							                    </div>
							                </div>
											
                    	
                   <div class="row mt-3">
                                                <div class="col">
                                                    <div class="input-group has-validation">
                                                        <span class="input-group-text">@</span>
                                                        <div class="form-floating email-feedback d-felx flex-row">
                                                            <input type="checkbox" name="check4" class="check" checked>
                                                            <input type="email" class="form-control" name="memberEmail"
                                                                id="memberEmail" placeholder="이메일" value="${memberDto.memberEmail}" required> <label
                                                                for="memberEmail">이메일*</label>
                                                        </div>
                                                        <div class="invalid-feedback">이메일 형식의 맞게 적어주세요.</div>
                                                    </div>
                                                </div>
                                            </div>
                    
                                            <div class="row mt-3">
                                                <div class="col">
                                                    <div class="input-group has-validation">
                                                        <div class="form-floating">
                                                            <input type="text" class="form-control" name="memberContact"
                                                                id="memberContact" placeholder="연락처" value="${memberDto.memberContact}" required> <label
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
                                                                id="memberBirth" placeholder="생년월일" value="${memberDto.memberBirth}" required> <label
                                                                for="memberBirth">생년월일</label>
                                                            <div class="d-brith-feedback">'-'을 포함하여 
                                                                적어주세요.ex->1990-01-01</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                    
	                    <hr>
	      		          
	      		    <div class="row">
	      		    	<div class="col-6 text-start">
	      		    		<h4>관심사</h4>
	      		    	</div>
	      		    </div>
	      		    
	      		    <div class="row">
	      		    	<div class="col like-show">
	      		                                                 <input type="checkbox" class="category-check check">
                                            <div class="form-group"> 
										      <label for="mojor1" class="form-label mt-4">무엇에 관심이 있으신가요?</label>
										      <br>
										      <span class="mt-1">관심 1</span>
										      <select class="form-select" name="mojor-s1" id="mojor1" >
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
<option class="choice1 40" value="7">등산</option>
<option class="choice1 40" value="8">산책/트래킹</option>
<option class="choice1 40" value="9">캠핑/백패킹</option>
<option class="choice1 40" value="10">국내여행</option>
<option class="choice1 42" value="11">책/독서</option>
<option class="choice1 42" value="12">인문학</option>
<option class="choice1 42" value="13">심리학</option>
<option class="choice1 42" value="14">철학</option>
<option class="choice1 41" value="15">금융업</option>
<option class="choice1 41" value="16">교육업</option>
<option class="choice1 41" value="17">디자인업계</option>
<option class="choice1 41" value="18">컨설팅</option>
<option class="choice1 43" value="19">자전거</option>
<option class="choice1 43" value="20">배드민턴</option>
<option class="choice1 43" value="21">볼링</option>
<option class="choice1 43" value="22">골프</option>
<option class="choice1 71" value="24">보드게임</option>
<option class="choice1 71" value="25">두뇌심리게임</option>
<option class="choice1 71" value="26">온라인게임</option>
<option class="choice1 71" value="27">콘솔게임</option>
<option class="choice1 61" value="41">영어</option>
<option class="choice1 61" value="42">일본어</option>
<option class="choice1 61" value="43">중국어</option>
<option class="choice1 61" value="47">독일어</option>
<option class="choice1 63" value="48">노래/보컬</option>
<option class="choice1 63" value="49">기타/베이스</option>
<option class="choice1 63" value="50">우쿨렐레</option>
<option class="choice1 63" value="51">드럼</option>
<option class="choice1 63" value="52">피아노</option>
<option class="choice1 64" value="57">미술/그림</option>
<option class="choice1 64" value="58">켈리그라피</option>
<option class="choice1 64" value="59">플라워아트</option>
<option class="choice1 64" value="60">캔들/디퓨저/석고</option>
<option class="choice1 65" value="61">라틴댄스</option>
<option class="choice1 65" value="62">사교댄스</option>
<option class="choice1 65" value="63">방송/힙합</option>
<option class="choice1 65" value="64">스트릿댄스</option>
<option class="choice1 66" value="69">양로원</option>
<option class="choice1 66" value="70">보육원</option>
<option class="choice1 66" value="71">환경봉사</option>
<option class="choice1 66" value="72">사회봉사</option>
<option class="choice1 67" value="73">지역</option>
<option class="choice1 67" value="74">나이</option>
<option class="choice1 67" value="75">파티</option>
<option class="choice1 67" value="76">결혼</option>
<option class="choice1 68" value="77">현대</option>
<option class="choice1 68" value="78">기아</option>
<option class="choice1 68" value="79">르노</option>
<option class="choice1 68" value="81">쌍용</option>
<option class="choice1 69" value="82">필름카메라</option>
<option class="choice1 69" value="83">영상제작</option>
<option class="choice1 69" value="84">디지털카메라</option>
<option class="choice1 70" value="85">디에스엠알</option>
<option class="choice1 70" value="87">삼성라이온즈</option>
<option class="choice1 70" value="88">기아타이거즈</option>
<option class="choice1 70" value="89">롯데자이언츠</option>
<option class="choice1 70" value="90">두산베어스</option>
<option class="choice1 72" value="121">한식</option>
<option class="choice1 72" value="92">일식</option>
<option class="choice1 72" value="93">중식</option>
<option class="choice1 72" value="94">양식</option>
<option class="choice1 73" value="96">강아지</option>
<option class="choice1 73" value="97">고양이</option>
<option class="choice1 73" value="98">물고기</option>
<option class="choice1 73" value="99">파충류</option>
<option class="choice1 74" value="100">금융보험</option>
<option class="choice1 74" value="101">취업스터디</option>
<option class="choice1 74" value="102">시험/자격증</option>
<option class="choice1 74" value="103">스피치/발성</option>
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
<option class="choice2 40" value="7">등산</option>
<option class="choice2 40" value="8">산책/트래킹</option>
<option class="choice2 40" value="9">캠핑/백패킹</option>
<option class="choice2 40" value="10">국내여행</option>
<option class="choice2 42" value="11">책/독서</option>
<option class="choice2 42" value="12">인문학</option>
<option class="choice2 42" value="13">심리학</option>
<option class="choice2 42" value="14">철학</option>
<option class="choice2 41" value="15">금융업</option>
<option class="choice2 41" value="16">교육업</option>
<option class="choice2 41" value="17">디자인업계</option>
<option class="choice2 41" value="18">컨설팅</option>
<option class="choice2 43" value="19">자전거</option>
<option class="choice2 43" value="20">배드민턴</option>
<option class="choice2 43" value="21">볼링</option>
<option class="choice2 43" value="22">골프</option>
<option class="choice2 71" value="24">보드게임</option>
<option class="choice2 71" value="25">두뇌심리게임</option>
<option class="choice2 71" value="26">온라인게임</option>
<option class="choice2 71" value="27">콘솔게임</option>
<option class="choice2 61" value="41">영어</option>
<option class="choice2 61" value="42">일본어</option>
<option class="choice2 61" value="43">중국어</option>
<option class="choice2 61" value="47">독일어</option>
<option class="choice2 63" value="48">노래/보컬</option>
<option class="choice2 63" value="49">기타/베이스</option>
<option class="choice2 63" value="50">우쿨렐레</option>
<option class="choice2 63" value="51">드럼</option>
<option class="choice2 63" value="52">피아노</option>
<option class="choice2 64" value="57">미술/그림</option>
<option class="choice2 64" value="58">켈리그라피</option>
<option class="choice2 64" value="59">플라워아트</option>
<option class="choice2 64" value="60">캔들/디퓨저/석고</option>
<option class="choice2 65" value="61">라틴댄스</option>
<option class="choice2 65" value="62">사교댄스</option>
<option class="choice2 65" value="63">방송/힙합</option>
<option class="choice2 65" value="64">스트릿댄스</option>
<option class="choice2 66" value="69">양로원</option>
<option class="choice2 66" value="70">보육원</option>
<option class="choice2 66" value="71">환경봉사</option>
<option class="choice2 66" value="72">사회봉사</option>
<option class="choice2 67" value="73">지역</option>
<option class="choice2 67" value="74">나이</option>
<option class="choice2 67" value="75">파티</option>
<option class="choice2 67" value="76">결혼</option>
<option class="choice2 68" value="77">현대</option>
<option class="choice2 68" value="78">기아</option>
<option class="choice2 68" value="79">르노</option>
<option class="choice2 68" value="81">쌍용</option>
<option class="choice2 69" value="82">필름카메라</option>
<option class="choice2 69" value="83">영상제작</option>
<option class="choice2 69" value="84">디지털카메라</option>
<option class="choice2 70" value="85">디에스엠알</option>
<option class="choice2 70" value="87">삼성라이온즈</option>
<option class="choice2 70" value="88">기아타이거즈</option>
<option class="choice2 70" value="89">롯데자이언츠</option>
<option class="choice2 70" value="90">두산베어스</option>
<option class="choice2 72" value="121">한식</option>
<option class="choice2 72" value="92">일식</option>
<option class="choice2 72" value="93">중식</option>
<option class="choice2 72" value="94">양식</option>
<option class="choice2 73" value="96">강아지</option>
<option class="choice2 73" value="97">고양이</option>
<option class="choice2 73" value="98">물고기</option>
<option class="choice2 73" value="99">파충류</option>
<option class="choice2 74" value="100">금융보험</option>
<option class="choice2 74" value="101">취업스터디</option>
<option class="choice2 74" value="102">시험/자격증</option>
<option class="choice2 74" value="103">스피치/발성</option>
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
<option class="choice3 40" value="7">등산</option>
<option class="choice3 40" value="8">산책/트래킹</option>
<option class="choice3 40" value="9">캠핑/백패킹</option>
<option class="choice3 40" value="10">국내여행</option>
<option class="choice3 42" value="11">책/독서</option>
<option class="choice3 42" value="12">인문학</option>
<option class="choice3 42" value="13">심리학</option>
<option class="choice3 42" value="14">철학</option>
<option class="choice3 41" value="15">금융업</option>
<option class="choice3 41" value="16">교육업</option>
<option class="choice3 41" value="17">디자인업계</option>
<option class="choice3 41" value="18">컨설팅</option>
<option class="choice3 43" value="19">자전거</option>
<option class="choice3 43" value="20">배드민턴</option>
<option class="choice3 43" value="21">볼링</option>
<option class="choice3 43" value="22">골프</option>
<option class="choice3 71" value="24">보드게임</option>
<option class="choice3 71" value="25">두뇌심리게임</option>
<option class="choice3 71" value="26">온라인게임</option>
<option class="choice3 71" value="27">콘솔게임</option>
<option class="choice3 61" value="41">영어</option>
<option class="choice3 61" value="42">일본어</option>
<option class="choice3 61" value="43">중국어</option>
<option class="choice3 61" value="47">독일어</option>
<option class="choice3 63" value="48">노래/보컬</option>
<option class="choice3 63" value="49">기타/베이스</option>
<option class="choice3 63" value="50">우쿨렐레</option>
<option class="choice3 63" value="51">드럼</option>
<option class="choice3 63" value="52">피아노</option>
<option class="choice3 64" value="57">미술/그림</option>
<option class="choice3 64" value="58">켈리그라피</option>
<option class="choice3 64" value="59">플라워아트</option>
<option class="choice3 64" value="60">캔들/디퓨저/석고</option>
<option class="choice3 65" value="61">라틴댄스</option>
<option class="choice3 65" value="62">사교댄스</option>
<option class="choice3 65" value="63">방송/힙합</option>
<option class="choice3 65" value="64">스트릿댄스</option>
<option class="choice3 66" value="69">양로원</option>
<option class="choice3 66" value="70">보육원</option>
<option class="choice3 66" value="71">환경봉사</option>
<option class="choice3 66" value="72">사회봉사</option>
<option class="choice3 67" value="73">지역</option>
<option class="choice3 67" value="74">나이</option>
<option class="choice3 67" value="75">파티</option>
<option class="choice3 67" value="76">결혼</option>
<option class="choice3 68" value="77">현대</option>
<option class="choice3 68" value="78">기아</option>
<option class="choice3 68" value="79">르노</option>
<option class="choice3 68" value="81">쌍용</option>
<option class="choice3 69" value="82">필름카메라</option>
<option class="choice3 69" value="83">영상제작</option>
<option class="choice3 69" value="84">디지털카메라</option>
<option class="choice3 70" value="85">디에스엠알</option>
<option class="choice3 70" value="87">삼성라이온즈</option>
<option class="choice3 70" value="88">기아타이거즈</option>
<option class="choice3 70" value="89">롯데자이언츠</option>
<option class="choice3 70" value="90">두산베어스</option>
<option class="choice3 72" value="121">한식</option>
<option class="choice3 72" value="92">일식</option>
<option class="choice3 72" value="93">중식</option>
<option class="choice3 72" value="94">양식</option>
<option class="choice3 73" value="96">강아지</option>
<option class="choice3 73" value="97">고양이</option>
<option class="choice3 73" value="98">물고기</option>
<option class="choice3 73" value="99">파충류</option>
<option class="choice3 74" value="100">금융보험</option>
<option class="choice3 74" value="101">취업스터디</option>
<option class="choice3 74" value="102">시험/자격증</option>
<option class="choice3 74" value="103">스피치/발성</option>
										      </select>
										    </div>
	            
	            
	            <div class="row mt-5">
	      		    	<div class="col text-start">
			      		    <a href="./mypage?memberId=${memberDto.memberId}>"><button type="button" class="btn btn-danger rounded-button w-75" style="font-size: 40px;"> 취소</button></a>
	      		    	</div>
	      		    	<div class="col text-end">
			      		    <button type="submit" class="btn btn-primary rounded-button w-75 btn-edit" style="font-size: 40px;">완료</button>
	      		    	</div>
	      		    </div>
	            
	            </form>
	            
	            </div>
	        </div>
	        </div>
	
	<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>