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
    </style>
	
	<script>
	$(function () {
		
		
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
		
		// 주소 검색
        $(".search-input").on('input', function () {
            console.log("검색중");

            if (!/^[가-힣]/.test($(this).val())) {
                return;
            }

            var keyword = $(this).val();
            console.log(keyword);

            if (keyword.length === 0) {
                $(".zip").hide();
                return;
            }

            $.ajax({
                url: "http://localhost:8080/rest/zip",
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
                            (response[i].hdongName != null ? response[i].hdongName + ' ' : '');

                        console.log(text);

                        zipList.append($("<li>")
                            .addClass("list-group-item zip")
                            .val(response[i].zipCodeNo)
                            .text(text));
                    }
       
                }
            });
            
            // [3] 목록을 클릭하면 입력창에 채우고 .zip 엘리먼트 숨기기
            $(".addr-list").on("click", ".zip", function () {
               
               var form = $('.add');
               
                form.append($("<input>")
                     .addClass("newInput")
                      .prop("type", "hidden")
                      .attr("name", "zipCodeNo")
                      .val($(this).val())
                  ); 

                var selectedAddress = $(this).text();
                $(".search-input").val(selectedAddress);
                $(".zip").hide();
                
                //console.log($('.newInput').val())
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
		        }
		    }
		    else{
		    	$(".ds1").prop("selected", true);
		    	 $(".choice1").css("display", "none");
		    	$("#monor1").prop("disabled", true);
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
		        }
		    }
		    else{
		    	$(".ds2").prop("selected", true);
		    	 $(".choice2").css("display", "none");
		    	$("#monor2").prop("disabled", true);
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
		        }
		    }
		    else{
		    	$(".ds3").prop("selected", true);
		    	 $(".choice3").css("display", "none");
		    	$("#monor3").prop("disabled", true);
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
				<input type="hidden" name="memberId" value="${memberDto.memberId}">
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
                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text ps-3" id="inputGroup-sizing-default">이름</span>
							  </div>
							  <input type="text" class="form-control" name="memberName" aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberName}">
							</div>
                    	</div>
                    </div>
                    
                    
                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text w-20" id="inputGroup-sizing-default">자기소개(시간남으면 하기)</span>
							  </div>
							  <input type="text" class="form-control" name="" aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberName}">
							</div>
                    	</div>
                    </div>
			
					<div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text w-20" id="inputGroup-sizing-default">지역</span>
							  </div>
			                    <div class="col">
			                       <input type="search" name="memberAddrString" class="form-control search-input"
			                            placeholder="동,읍,면을 입력해주세요" value="${addr}">
			                    </div>                    
			                <div class="row">
			                    <div class="col">
			                        <ul class="list-group addr-list">
			                        </ul>
			                    </div>
		                    </div>
							</div>
                    	</div>
                    </div>
                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text w-20" id="inputGroup-sizing-default">이메일</span>
							  </div>
							  <input type="text" class="form-control" name="memberEmail"  aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberEmail}">
							</div>
                    	</div>
                    </div>
                    
                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text w-20" id="inputGroup-sizing-default">전화번호</span>
							  </div>
							  <input type="text" class="form-control" name="memberContact" aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberContact}">
							</div>
                    	</div>
                    </div>
                    
                    <div class="row">
                    	<div class="col">
                    		<div class="input-group mt-3 mb-3">
							  <div class="input-group-prepend">
							    <span class="input-group-text w-20" id="inputGroup-sizing-default">생년월일</span>
							  </div>
							  <input type="text" class="form-control" name="memberBirth" aria-label="Default" aria-describedby="inputGroup-sizing-default" value="${memberDto.memberBirth}">
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
	      		     <!-- 1. 관심 테이블 대분류 -->
                                            <div class="form-group"> 
										      <label for="mojor1" class="form-label mt-4">관심사가 바뀌셨나요?</label>
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
								                <option class="ds1" value=" "></option>
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
								                <option class="ds2" value=" "></option>
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
										    
										    <div class="form-group"> 
										      <select class="form-select mojor-check" name="likeCategory" id="monor3" disabled>
								                <option class="ds3" value=" "></option>
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
										      </select>
										    </div>
	      		    	</div>
	      		    </div>
	            
	            
	            <div class="row mt-5">
	      		    	<div class="col text-start">
			      		    <a href="./mypage?memberId=${memberDto.memberId}>"><button type="button" class="btn btn-danger rounded-button w-75" style="font-size: 40px;"> 취소</button></a>
	      		    	</div>
	      		    	<div class="col text-end">
			      		    <button type="submit" class="btn btn-primary rounded-button w-75" style="font-size: 40px;">완료</button>
	      		    	</div>
	      		    </div>
	            
	            </form>
	            
	            </div>
	        </div>
	    </div>
	
	<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>