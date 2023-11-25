<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 매번 페이지 코드를 복사할 수 없으니 미리 만든 것을 불러오도록 설정 
		- 템블릿 페이지(template page)라고 부름
		- 절대경로를 사용할 것
--%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

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
	//정모 관련 처리
	$(function() {

		//참석 버튼을 누르면 없던 프로필 버튼이 생기고 meetingDto에 들어가져야 한다
		$(".meeting-attend").on("click", function() {
			$(this).hide();
			$(this).parent().find(".meeting-cancel").show();

			$.ajax({

			});

		});

		$(".meeting-cancel").on("click", function() {
			$(this).hide();
			$(this).parent().find(".meeting-attend").show();

			$.ajax({

			});

		});

	});
</script>
<script>
	//스크롤 관련 처리
	var loading = false;
	var currentPage = 1;
	$(function() {
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
				
				for(var i = 0; i < response.length; i++){
					console.log(response[i]);
					
					var template = $("#meeting-template").html();
					var htmlTemplate = $.parseHTML(template);
					
					$(htmlTemplate).find(".meeting-clubName").text(response[i].clubName);
					$(htmlTemplate).find(".meeting-attend").attr("data-club-no", response[i].clubNo);
					$(htmlTemplate).find(".meeting-cancel").attr("data-club-no", response[i].clubNo);
					$(htmlTemplate).find(".meeting-go-club").attr("href", window.contextPath + "/club/detail?clubNo=" + response[i].clubNo);
					$(htmlTemplate).find(".meeting-location").text(response[i].meetingLocation);
					$(htmlTemplate).find(".meeting-date").text(response[i].formattedMeetingDate);
// 					$(htmlTemplate).find(".meeting-profile").text(response[i].)
					
					$(".meeting-list").append(htmlTemplate);
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
			console.log("스크롤 퍼센트: " + scrollPercent.toFixed(2) + "%");
			
			if(!loading && scrollPercent >= 65){
				loading = true;
				currentPage++;
				console.log(currentPage);
				$.ajax({
					url: window.contextPath + "/rest/home/page",
					method: "get",
					data: {
						page: currentPage,
					},
					success: function(response){
						
						for(var i = 0; i < response.length; i++){
							console.log(response[i]);
							
							var template = $("#meeting-template").html();
							var htmlTemplate = $.parseHTML(template);
							
							$(htmlTemplate).find(".meeting-clubName").text(response[i].clubName);
							$(htmlTemplate).find(".meeting-attend").attr("data-club-no", response[i].clubNo);
							$(htmlTemplate).find(".meeting-cancel").attr("data-club-no", response[i].clubNo);
							$(htmlTemplate).find(".meeting-go-club").attr("href", window.contextPath + "/club/detail?clubNo=" + response[i].clubNo);
							$(htmlTemplate).find(".meeting-location").text(response[i].meetingLocation);
							$(htmlTemplate).find(".meeting-date").text(response[i].formattedMeetingDate);
//		 					$(htmlTemplate).find(".meeting-profile").text(response[i].)
							
							$(".meeting-list").append(htmlTemplate);
						}
						loading = false;
					},
				});
			}
		});
		
	}
</script>
<script id="meeting-template" type="text/template">
<div class="row">
	<div class="col">
	
		<div class="card text-white bg-miso mb-3" style="width: 550px">
			<div class="card-header d-flex justify-content-between align-items-center meeting-clubName">
				${homeForMeetingVO.clubName}
			</div>
			<div class="card-body meeting-location">${homeForMeetingVO.meetingLocation}</div>
			
			<div class="card-header meeting-date">${homeForMeetingVO.meetingDate}</div>
			
			<div class="card-body">
				
	
			<div class="card-header text-right">
				<button type="button" class="btn btn-light rounded-pill ml-auto meeting-attend">참석</button>
				<button type="button" class="btn btn-danger rounded-pill ml-auto meeting-cancel">취소</button>
				<a href="${pageContext.request.contextPath}/club/detail?clubNo=${homeForMeetingVO.clubNo}" class="btn btn-info rounded-pill ml-auto meeting-go-club">동호회로</a>
			</div>

			</div>
		</div>
	</div>
</div>
</script>
<div class="row m-2 ">

	<div id="iconContainer" class="d-flex justify-content-end ">
		<i class="fa-solid fa-bars fa-xl iconContainer showCategoryButton"></i>
	</div>
	<div class="row mb-3">
		<div class="col d-flex justify-content-end">
			<div class="alert alert-dismissible alert-light categoryAlert">
				<div class="row d-flex justify-content-center">
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #FFA5A5;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/sports.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #FBEAB7;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/poetry.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2"
						style="background-color: #C3DCFF;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/flight.png"
							width="100%">
						</a>
					</div>
				</div>

				<div class="row d-flex justify-content-center mt-2">
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #FFA5E6;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/ferris-wheel.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #E2CBC4;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/handbag.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2"
						style="background-color: #8DACD9;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/earth.png"
							width="100%">
						</a>
					</div>
				</div>

				<div class="row d-flex justify-content-center mt-2">
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #F5CCFF;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/music-notes.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #A5EE99;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/paint-palette.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2"
						style="background-color: #F5F5F5;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/ballet.png"
							width="100%">
						</a>
					</div>
				</div>

				<div class="row d-flex justify-content-center mt-2">
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #FCCD7F;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/heart.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #C7D290;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/cappuccino.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2"
						style="background-color: #7B89C6;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/car.png"
							width="100%">
						</a>
					</div>
				</div>

				<div class="row d-flex justify-content-center mt-2">
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #FFF8B2;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/camera.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #82CCB3;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/baseball-ball.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2"
						style="background-color: #72A8DC;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/gamepad.png"
							width="100%">
						</a>
					</div>
				</div>

				<div class="row d-flex justify-content-center mt-2">
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #F497A9;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/recipes.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2 me-3"
						style="background-color: #B9FFE7;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/dog.png"
							width="100%">
						</a>
					</div>
					<div class="col-4 category text-center p-2 mb-5"
						style="background-color: #DBEEFF;">
						<a href="#" class="link"> <img
							src="${pageContext.request.contextPath}/images/butterfly.png"
							width="100%">
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="row mb-3">
		<div class="col">
			<span class="badge rounded-pill bg-miso">찜한 동호회</span>
		</div>
	</div>

	<c:if test="${wishList == null}">
		<div class="row mb-3">
			<div class="col">
				<div class="col">아직 찜을 하지 않으셨군요. 많은 동호회가 있습니다.</div>
			</div>
		</div>
	</c:if>

	<c:forEach var="wishListDto" items="${wishList}">

		<div class="col-4">

			<div class="alert alert-dismissible alert-light">
				<a
					href="${pageContext.request.contextPath}/club/detail?clubNo=${wishListDto.clubNo}"
					class="link"> ${wishListDto.clubName} </a>
			</div>

		</div>

	</c:forEach>




	<div class="row m-2 mt-3">

		<div class="row mb-3">
			<div class="col">
				<span class="badge rounded-pill bg-miso">가입한 모임</span>
			</div>
		</div>

		<c:if test="${joinList == null}">
			<div class="row mb-3">
				<div class="col">아직 가입하신 동호회가 없으시군요. 많은 동호회가 있습니다</div>
			</div>
		</c:if>

		<c:forEach var="homeForClubVO" items="${joinList}">
			<div class="col d-flex flex-column align-items-start">

				<div class="alert alert-dismissible alert-light circle">
					<c:if test="${homeForClubVO.attachNo == null}">
						<a
							href="${pageContext.request.contextPath}/club/detail?clubNo=${homeForClubVO.clubNo}"
							class="link d-flex justify-content-center align-items-center"
							style="height: 100%; padding: 0; box-sizing: border-box;">
							이미지 없음<i class="fa-solid fa-plus"></i>
						</a>
					</c:if>
					<c:if test="${homeForClubVO.attachNo != null}">
						<a
							href="${pageContext.request.contextPath}/club/detail?clubNo=${homeForClubVO.clubNo}"
							class="link d-flex justify-content-center align-items-center"
							style="height: 100%; padding: 0; box-sizing: border-box;"> <img
							src="${pageContext.request.contextPath}/download?attachNo=${homeForClubVO.attachNo}">
						</a>
					</c:if>
				</div>

				<div>
					<label class="circle-name text-center"></label>
				</div>

				<div class="alert alert-dismissible alert-light circle circle-time">
					<a
						href="${pageContext.request.contextPath}/club/detail?clubNo=${homeForClubVO.clubNo}"
						class="link"> ${homeForClubVO.clubName} </a>
				</div>

			</div>
		</c:forEach>

	</div>

	<div class="row m-2 mt-3">

		<div class="row mb-3">
			<div class="col">
				<span class="badge rounded-pill bg-miso">내 모임 정모</span>
			</div>
		</div>
		
		<div class="row mb-3 meeting-list"></div>

<%-- 		<c:if test="${meetingList == null}"> --%>
<!-- 			<div class="row mb-3"> -->
<!-- 				<div class="col">가입한 동호회에서 등록된 정모가 없군요</div> -->
<!-- 			</div> -->
<%-- 		</c:if> --%>

<%-- 		<c:forEach var="homeForMeetingVO" items="${meetingList}"> --%>
<!-- 			<div class="row"> -->
<!-- 				<div class="col"> -->

<!-- 					<div class="card text-white bg-miso mb-3" style="width: 550px"> -->
<!-- 						<div -->
<!-- 							class="card-header d-flex justify-content-between align-items-center"> -->
<%-- 							${homeForMeetingVO.clubName} --%>
<!-- 							<button type="button" -->
<!-- 								class="btn btn-light rounded-pill ml-auto meeting-attend" -->
<%-- 								data-club-no="${homeForMeetingVO.clubNo}">참석</button> --%>
<!-- 							<button type="button" -->
<!-- 								class="btn btn-danger rounded-pill ml-auto meeting-cancel" -->
<%-- 								data-club-no="${homeForMeetingVO.clubNo}">취소</button> --%>
<!-- 							<a -->
<%-- 								href="${pageContext.request.contextPath}/club/detail?clubNo=${homeForMeetingVO.clubNo}" --%>
<!-- 								class="btn btn-info rounded-pill ml-auto">동호회로</a> -->
<!-- 						</div> -->
<%-- 						<div class="card-body">${homeForMeetingVO.meetingLocation}</div> --%>
<%-- 						<div class="card-header">${homeForMeetingVO.meetingDate}</div> --%>
<!-- 						<div class="card-body"> -->
<%-- 							<c:forEach var="homeForMeetingMemberVO" items="${memberList}"> --%>
<%-- 								<c:if --%>
<%-- 									test="${homeForMeetingVO.meetingNo == homeForMeetingMemberVO.meetingNo}"> --%>
<%-- 									<c:if test="${homeForMeetingMemberVO.attachNo != null}"> --%>
<!-- 										<a -->
<%-- 											href="${pageContext.request.contextPath}/member/mypage?memberId=${homeForMeetingMemberVO.clubMemberId}"> --%>
<!-- 											<img -->
<%-- 											src="${pageContext.request.contextPath}/download?attachNo=${homeForMeetingMemberVO.attachNo}" --%>
<!-- 											width="10%" class="pe-1" -->
<%-- 											data-profile-no="${homeForMeetingMemberVO.clubMemberId}"> --%>
<!-- 										</a> -->
<%-- 									</c:if> --%>
<%-- 									<c:if test="${homeForMeetingMemberVO.attachNo == null }"> --%>
<!-- 										<a -->
<%-- 											href="${pageContext.request.contextPath}/member/mypage?memberId=${homeForMeetingMemberVO.clubMemberId}"> --%>
<!-- 											<img -->
<%-- 											src="${pageContext.request.contextPath}/images/basic-profile.png" --%>
<!-- 											width="10%" class="pe-1" -->
<%-- 											data-profile-no="${homeForMeetingMemberVO.clubMemberId}"> --%>
<!-- 										</a> -->
<%-- 									</c:if> --%>
<%-- 								</c:if> --%>
<%-- 							</c:forEach> --%>
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<%-- 		</c:forEach> --%>

	</div>
</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>