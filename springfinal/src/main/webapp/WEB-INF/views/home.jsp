<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 매번 페이지 코드를 복사할 수 없으니 미리 만든 것을 불러오도록 설정 
		- 템블릿 페이지(template page)라고 부름
		- 절대경로를 사용할 것
--%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<style>
.club-image{
width: 100%; 
height: 100%;
object-fit: cover;
border-radius: 20%;
}
.alert.alert-dismissible.club-box{
border-radius: 20%;
width:120px;
height: 120px;
}
.alert.alert-dismissible.circle-time{
width: 120px;
}

.club-name{
font-size: 14px;
}

.col.d-flex.flex-column.align-items-start{
margin-right: 0px;
}
.btn.btn-in, .btn.btn-out{
width: 90px;
}
.btn.btn-home{
width: 110px;
}

</style>

<!-- 해당 JSP 파일에 스크립트 포함 -->
<script>
	$(document).ready(function() {
		$(".showCategoryButton").click(function() {
			var categoryAlert = $(".categoryAlert");
			if (categoryAlert.css("display") === "none") {
				categoryAlert.css("display", "block");
			} else {
				categoryAlert.css("display", "none");
			}
		});

		// 창 크기가 변경될 때 이벤트 처리
		$(window).on("resize", function() {
			if ($(window).width() > 780) {
				// 창 폭이 780px보다 크면
				$(".categoryAlert").css("display", "none");
			}
		});
	});
</script>
<script>
	//스크롤 관련 처리
	var loading = false;
	var currentPage = 1;
	$(function() {
		$(".go-upside").hide();
		loadList();
		loadMore(currentPage);	
	});
	//최초의 5장을 불러온다
	function loadList(){
		$.ajax({
			url: window.contextPath + "/rest/home/page",
			method: "get",
			data: {
				page: currentPage,
			},
			success: function(response){
				console.log(response);
				if(response.length == 0){
// 					var clubTemplate = $.parseHTML(("#club-template").html());
// 					$(clubTemplate).find().
					$(".my-meeting-list").hide();
				}
				

				else{
					for(var i = 0; i < response.length; i++){
						console.log(response[i]);
						
						var template = $("#meeting-template").html();
						var htmlTemplate = $.parseHTML(template);
						
						$(htmlTemplate).find(".meeting-card").attr("data-club-no", response[i].clubNo);
						$(htmlTemplate).find(".meeting-clubName").text(response[i].clubName);
						$(htmlTemplate).find(".meeting-attend").attr("data-club-no", response[i].clubNo);
						$(htmlTemplate).find(".meeting-cancel").attr("data-club-no", response[i].clubNo);
						$(htmlTemplate).find(".meeting-go-club").attr("href", window.contextPath + "/club/detail?clubNo=" + response[i].clubNo);
						$(htmlTemplate).find(".meeting-location").text(response[i].meetingLocation);
						$(htmlTemplate).find(".meeting-date").text(response[i].formattedMeetingDate);
						$(htmlTemplate).find(".meeting-dday").text(response[i].calculateDday);
						$(htmlTemplate).find(".meeting-name").text(response[i].meetingName);
						$(htmlTemplate).find(".meeting-image").attr("href", window.contextPath + "/club/detail?clubNo=" + response[i].clubNo);
						$(htmlTemplate).find(".meeting-attend").attr("data-club-no", response[i].clubNo).attr("data-meeting-no", response[i].meetingNo);
						$(htmlTemplate).find(".meeting-cancel").attr("data-club-no", response[i].clubNo).attr("data-meeting-no", response[i].meetingNo);
						if(response[i].attended){ //참가한 미팅이라면
							$(htmlTemplate).find(".meeting-attend").hide();
						}
						else{//참가하지 않은 미팅이라면
							$(htmlTemplate).find(".meeting-attend").hide();
						}
						if(response[i].attachNo != null){
							var img = $("<img>").attr("src", window.contextPath + "/rest/meeting/attchImage?attachNo=" + response[i].attachNo).addClass("w-100").addClass("img-thumbnail")
							.css({
								"max-height":"159.25px",
								"height":"159.25px"
							});
							$(htmlTemplate).find(".meeting-image").html(img);
						}
						else{
							var img = $("<img>").attr("src", window.contextPath + "/images/logo-door.png").addClass("w-100");
							$(htmlTemplate).find(".meeting-image").html(img);
						}
						
						$(".meeting-list").append(htmlTemplate);
						attendMeeting(htmlTemplate);
						cancelMeeting(htmlTemplate);

					}
				}
			},
		});
	}
	
	//스크롤바가 65%를 넘을 시에 다음 페이지를 로드하도록
	function loadMore(currentPage){
		$(window).scroll(function() {
			// 현재 스크롤 위치
			var scrollTop = $(window).scrollTop();
			// 문서의 전체 높이
			var docHeight = $(document).height();
			// 창의 높이
			var windowHeight = $(window).height();
			// 스크롤의 위치를 퍼센트로 계산
			var scrollPercent = (scrollTop / (docHeight - windowHeight)) * 100;
			// 퍼센트를 콘솔에 출력
			//console.log("스크롤 퍼센트: " + scrollPercent.toFixed(2) + "%");
			
			if(!loading && scrollPercent >= 65){
				loading = true;
				currentPage++;
				if(currentPage == 3){
					$(".go-upside").show();
				}
				console.log(currentPage);
				$.ajax({
					url: window.contextPath + "/rest/home/page",
					method: "get",
					data: {
						page: currentPage,
					},
					success: function(response){
						if(response.length == 0){
							console.log("스크롤 종료");
						}
						else{
							for(var i = 0; i < response.length; i++){
								console.log(response[i]);
								
								var template = $("#meeting-template").html();
								var htmlTemplate = $.parseHTML(template);
								
								$(htmlTemplate).find(".meeting-card").attr("data-club-no", response[i].clubNo);
								$(htmlTemplate).find(".meeting-clubName").text(response[i].clubName);
								$(htmlTemplate).find(".meeting-attend").attr("data-club-no", response[i].clubNo);
								$(htmlTemplate).find(".meeting-cancel").attr("data-club-no", response[i].clubNo);
								$(htmlTemplate).find(".meeting-go-club").attr("href", window.contextPath + "/club/detail?clubNo=" + response[i].clubNo);
								$(htmlTemplate).find(".meeting-location").text(response[i].meetingLocation);
								$(htmlTemplate).find(".meeting-date").text(response[i].formattedMeetingDate);
								$(htmlTemplate).find(".meeting-dday").text(response[i].calculateDday);
								$(htmlTemplate).find(".meeting-name").text(response[i].meetingName);
								$(htmlTemplate).find(".meeting-image").attr("href", window.contextPath + "/club/detail?clubNo=" + response[i].clubNo);
								$(htmlTemplate).find(".meeting-attend").attr("data-club-no", response[i].clubNo).attr("data-meeting-no", response[i].meetingNo);
								$(htmlTemplate).find(".meeting-cancel").attr("data-club-no", response[i].clubNo).attr("data-meeting-no", response[i].meetingNo);
								if(response[i].attended){ //참가한 미팅이라면
									$(htmlTemplate).find(".meeting-attend").hide();
								}
								else{//참가하지 않은 미팅이라면
									$(htmlTemplate).find(".meeting-attend").hide();
								}
								if(response[i].attachNo != null){
									var img = $("<img>").attr("src", window.contextPath + "/rest/meeting/attchImage?attachNo=" + response[i].attachNo).addClass("w-100")
									.css({
										"max-height":"159.25px",
										"height":"159.25px"
									});
									//테스트로 넣어본 이미지는 돌아감
									//var img = $("<img>").attr("src", window.contextPath + "/images/paint-palette.png");
									$(htmlTemplate).find(".meeting-image").html(img);
								}
								else{
									var img = $("<img>").attr("src", window.contextPath + "/images/logo-door.png").addClass("w-100");
									$(htmlTemplate).find(".meeting-image").html(img);
								}
	//		 					$(htmlTemplate).find(".meeting-profile").text(response[i].)
								
								$(".meeting-list").append(htmlTemplate);
								attendMeeting(htmlTemplate);
								cancelMeeting(htmlTemplate);
							}
							loading = false;		
						}
					},
				});
			}
		});
	}
	
	//정모 관련 처리
	function attendMeeting(htmlTemplate){
		$(htmlTemplate).find(".meeting-attend").on("click", function() {
			$(this).hide();
			$(this).parent().find(".meeting-cancel").show();
			
			var clubNo = $(this).data("club-no");
			var meetingNo = $(this).data("meeting-no");
			console.log("참석버튼");
			console.log(clubNo);
			console.log(meetingNo);
			
			$.ajax({
				url: window.contextPath + "/rest/home/insert",
				method: "post",
				data:  {
					clubNo: clubNo,
					meetingNo: meetingNo
				},
				success: function(response){
					console.log("성공");
					window.alert("정모에 참가하셨습니다");
				},
			});
			
		});	
	}
	
	function cancelMeeting(htmlTemplate){
		$(htmlTemplate).find(".meeting-cancel").on("click", function() {
			$(this).hide();
			$(this).parent().find(".meeting-attend").show();
			
			var clubNo = $(this).data("club-no");
			var meetingNo = $(this).data("meeting-no");
			console.log("취소버튼");
			console.log(clubNo);
			console.log(meetingNo);
			
			$.ajax({
				url: window.contextPath + "/rest/home/remove",
				method: "post",
				data:  {
					clubNo: clubNo,
					meetingNo: meetingNo
				},
				success: function(response){
					console.log("성공");
					window.alert("정모 참가를 취소하셨습니다");
				},
			});
			
		});
	}
	
	function moveEvent(htmlTemplate){
		$(htmlTemplate).find(".meeting-card").on("click", function(){
			window.location.href = window.contextPath + "/club/detail?clubNo=" +$(this).data("club-no");
		});
	}
</script>
<script id="meeting-template" type="text/template">
<div class="row mt-3">
	<div class="col">

<div class="card mb-3 meeting-card" style="width: 550px;">
  <div class="row g-0">
    <div class="col-4">
		<a href="#" class="meeting-image"></a>
    </div>
    <div class="col-8">
      <div class="card-body">
        <h5 class="card-title meeting-name text-truncate">Card title</h5>
        <p class="card-text meeting-clubName">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
        <p class="card-text meeting-location text-truncate">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
        <p class="card-text"><small class="text-body-secondary meeting-date text-end">Last updated 3 mins ago</small></p>
        <p class="card-text"><small class="text-body-secondary meeting-dday text-end">Last updated 3 mins ago</small></p>
		<button type="button" class="btn btn-in btn-light rounded-pill ml-auto meeting-attend float-end">참석</button>
		<button type="button" class="btn btn-out btn-danger rounded-pill ml-auto meeting-cancel float-end">취소</button>
		<a href="#" class="btn btn-home btn-miso rounded-pill ml-auto meeting-go-club float-end me-1">동호회가기</a>
      </div>
    </div>
  </div>

	</div>
</div>
</script>
<script id="club-template" type="text/template">
<div class="col-3 text-start">
	<img src="${pageContext.request.contextPath}/images/open-door.png" width="100%">
</div>
<div class="col">
                                	<div class="col">
                                    <h5>아직 </h5>
                                	</div>
                                	<div class="col">
                                    <h1>모임을 찜해보세요!</h1>
                                	</div>
                                </div>
                                <div class="row p-1 mt-4 text-center">
</script>
<div class="row m-2 ">

  <div class="row">
        <div class="col text-start d-flex align-items-center">
            <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
            <strong class="ms-2 main-text">찜한 모임</strong>
        </div>
    </div>

	<c:if test="${wishList.size() == 0}">
		  <div class="row d-flex align-items-center mt-3">
                <div class="col-3 text-start">
                    <img src="${pageContext.request.contextPath}/images/open-door.png" width="100%">
                </div>
                	 <div class="col">
                                	<div class="col">
                                    <h5>찜한 모임이 없습니다.</h5>
                                	</div>
                                	<div class="col">
                                    <h1>모임을 찜해보세요!</h1>
                                	</div>
                                </div>
                                <div class="row p-1 mt-4 text-center">
                    </div>
            </div>
	</c:if>


	<c:forEach var="wishListDto" items="${wishList}">

			    <div class="col-3 d-flex flex-column align-items-start mt-3 p-0 m-0">

				<div class="alert alert-dismissible club-box alert-light circle p-0">
					<c:if test="${wishListDto.clubNo == null}">
						<a
							href="${pageContext.request.contextPath}/club/detail?clubNo=${wishListDto.clubNo}"
							class="link"
							style="height: 100%; padding: 0; box-sizing: border-box;">
							<img
							src="${pageContext.request.contextPath}/images/basic-profile2.png" class="club-image">
						</a>
					</c:if>
					<c:if test="${wishListDto.clubNo != null}">
						<a
							href="${pageContext.request.contextPath}/club/detail?clubNo=${wishListDto.clubNo}"
							class="link"
							style="height: 100%; padding: 0; box-sizing: border-box;"> <img
							src="${pageContext.request.contextPath}/club/image?clubNo=${wishListDto.clubNo}"  class="club-image">
						</a>
					</c:if>
				</div>

			<div class="alert alert-dismissible alert-light circle circle-time p-0 text-center mt-2 d-flex justify-content-center align-items-center">
			<a href="${pageContext.request.contextPath}/club/detail?clubNo=${wishListDto.clubNo}" class="link">
			  <strong class="club-name">${wishListDto.clubName} </strong>
			    </a>
			</div>

			</div>
		</c:forEach>
	



  <div class="row mt-4">
        <div class="col text-start d-flex align-items-center">
            <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
            <strong class="ms-2 main-text">가입한 모임</strong>
        </div>
    </div>

		<c:if test="${joinList.size() == 0}">
		 <div class="row d-flex align-items-center mt-3">
                <div class="col-3 text-start">
                    <img src="${pageContext.request.contextPath}/images/open-door.png" width="100%">
                </div>
                	 <div class="col">
                                	<div class="col">
                                    <h5>아직 가입하신 모임이 없으시군요.</h5>
                                	</div>
                                	<div class="col">
                                    <h1>모임에 가입해보세요!</h1>
                                	</div>
                                </div>
                                <div class="row p-1 mt-4 text-center">
                    </div>
            </div>
		</c:if>

<c:forEach var="homeForClubVO" items="${joinList}">
		
    <div class="col-3 d-flex flex-column align-items-start mt-3 p-0 m-0">
        
        <div class="alert alert-dismissible club-box alert-light circle p-0">
            <c:if test="${homeForClubVO.attachNo == null}">
                <a href="${pageContext.request.contextPath}/club/detail?clubNo=${homeForClubVO.clubNo}" class="link" style="height: 100%; padding: 0; box-sizing: border-box;">
                    <img src="${pageContext.request.contextPath}/images/basic-profile2.png" class="club-image">
                </a>
            </c:if>
            <c:if test="${homeForClubVO.attachNo != null}">
                <a href="${pageContext.request.contextPath}/club/detail?clubNo=${homeForClubVO.clubNo}" class="link" style="height: 100%; padding: 0; box-sizing: border-box;">
                    <img src="${pageContext.request.contextPath}/club/image?clubNo=${homeForClubVO.clubNo}"  class="club-image">
                </a>
            </c:if>
        </div>

        <div class="alert alert-dismissible alert-light circle circle-time p-0 text-center mt-2 d-flex justify-content-center align-items-center">
            <a href="${pageContext.request.contextPath}/club/detail?clubNo=${homeForClubVO.clubNo}" class="link">
                <strong class="club-name">${homeForClubVO.clubName}</strong>
            </a>
        </div>
        
    </div>
</c:forEach>



<div class="row mt-4 my-meeting-list">
     <div class="col text-start d-flex align-items-center">
         <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
        <strong class="ms-2 main-text">내 모임 정모</strong>
    </div>
</div>
		
<div class="row mb-3 meeting-list"></div>

<!-- 위로 가기 버튼 -->
<div class="row go-upside mt-3">
    <div class="col">
        <a href="#" class="btn btn-miso w-100">위로</a>
    </div>
</div>
	</div>


<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>