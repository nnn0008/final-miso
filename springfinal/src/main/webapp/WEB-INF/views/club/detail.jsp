<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/hangul-js" type="text/javascript"></script>

<script>
$(function(){
    $(".join").click(function(e){
        var clubNo = $(".clubNo").data("no");
        var memberId = $(".memberId").data("id");

        $.ajax({
            url: "http://localhost:8080/rest/existMember",
            method: "get",
            data: { clubNo: clubNo, memberId: memberId },
            success: function (response) {
                if (response == true){
                    alert('이미 가입한 모임입니다');
                } else {
                    $(".exampleModal").modal('show');
                }
            }
        });
    });

    $(".commit").click(function(){
        var clubNo = $(".clubNo").data("no");
        var memberId = $(".memberId").data("id");
        var joinMessage = $(".joinMessage").val();

        $.ajax({
            url: "http://localhost:8080/rest/clubMember",
            method: "post",
            data: { clubNo: clubNo, clubMemberId: memberId, joinMessage: joinMessage },
            success: function (response) {
                $(".exampleModal").modal("hide");
                location.reload();
            }
        });
    });
    
    //미팅 만들기 
    $(".btn-make-meeting").click(function(e) {
        e.preventDefault();

        // 파일 선택
        var meetingImageInput = $("#meetingImage")[0];
        var meetingImage = meetingImageInput.files[0];

        // 각 필드 값을 가져오기
        var meetingClubNo = $(".clubNo").data("no");
        var meetingName = $(".meetingName").val();
        var meetingDate = $(".meetingDate").val();
        var meetingTime = $(".meetingTime").val();
        var meetingLocation = $(".meetingLocation").val();
        var meetingPrice = $(".meetingPrice").val();
        var meetingNumber = $(".meetingMaxPeople").val();
		var formatDateTime = meetingDate + " " + meetingTime; 
			
        // FormData 객체 생성
        var formData = new FormData();
        formData.append("clubNo", meetingClubNo);
        formData.append("meetingName", meetingName);
        //formData.append("meetingDate", meetingDate);
        //formData.append("meetingTime", meetingTime);
        formData.append("meetingTime", formatDateTime);
        formData.append("meetingLocation", meetingLocation);
        formData.append("meetingPrice", meetingPrice);
        formData.append("meetingNumber", meetingNumber);
        formData.append("meetingImage", meetingImage);

        // Ajax 통신
        $.ajax({
            url: window.contextPath + "/rest/meeting/insert",
            method: "post",
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                console.log("성공, 목록을 갱신합니다");
                //loadList();
            },
            error: function(error) {
                console.error("파일 업로드 에러", error);
                // 오류 처리 로직 추가
                console.log("Meeting Image:", meetingImage);
            }
        });
    });
    
   	//동호회를 만들었을때 넣어줘야 할 목록
   function loadList(){
   		var params = new URLSearchParams(location.search);
   		var clubNo = params.get("clubNo");
   		$.ajax({
   			url:window.contextPath + "/rest/meeting/list",
   			method:"post",
   			data:{
   				clubNo : clubNo,
   			},
   			success:function(response){
   				$(".attach-meeting-list").empty();
   				console.log(response[i]);
   				for(let i = 0; i < response.length; i++){
   								
   				}
   				
   			},
   		});
   }
    	

    
});

</script>

<script id="meeting-template" type="text/template">
<div class="col">
	
	<div class="row">
		<div class="col">
			<a class="d-day">디데이</a>
		</div>
		<div class="col">
			<button class="btn btn-danger">취소</button>
			<button class="btn btn-success">참석</button>
		</div>
	</div>
	
	<div class="row">
		<div class="col">
			<a class="madeMeetingName">제목</a>
		</div>
	</div>
	
	<div class="row">
		<div class="col">
			<img class="madeMeetingImage">
		</div>
		<div class="col">
			<div class="row">
				일시 <a class="madeMeetingDate">날짜</a>
			</div>
			<div class="row">
				위치 <a class="madeMeetingLocation">위치</a>
			</div>
			<div class="row">
				비용 <a class="madeMeetingPrice">비용</a>
			</div>
			<div class="row">
				참석 <a class="madeRealAttendant">5</a><a class="madeMeetingMaxNumber">250</a>
			</div>
		</div>
	</div>
	
</div>
</script>


<h1>클럽디테일</h1>




<img src="${pageContext.request.contextPath}/club/image?clubNo=${clubDto.clubNo}" width="550" height="250">



<div class="container-fluid mt-4">
    <div class="row">
        <div class="col">
        <input type="hidden" class="clubNo" data-no="${clubDto.clubNo}">
        <input type="hidden" class="memberId" data-id="${sessionScope.name}">
        
           <span class="badge text-bg-primary">${zipDto.sigungu}</span>
           <span class="badge text-bg-primary">${major.majorCategoryName}</span>
           <span class="badge text-bg-primary">멤버 ${memberCount}</span>
        </div>
    </div>
    <div class="row mt-4">
        <div class="col-md-6">
            <p>클럽 제목: ${clubDto.clubName}</p>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-6">
            <p>클럽 설명: ${clubDto.clubExplain} 설명</p>
        </div>
    </div>
    <c:if test="${joinButton==true}">
   <button type="button" class="btn btn-secondary mt-4 join" data-bs-toggle="modal">가입하기</button>
	</c:if>
	 <c:if test="${editPossible==true}">
   <a href="/club/edit?clubNo=${clubDto.clubNo}">
   <button type="button" class="btn btn-primary mt-4">수정하기</button>
   </a> 
   </c:if>
	
	<hr>
	<div class="row">
		<div class="col">
			<h5>모임 멤버(인원수)</h5>
		</div>
	</div>
	<c:forEach var="clubMember" items="${clubMemberDto}">
	
	<div class="row">
	<div class="col">
	<img src="${pageContext.request.contextPath}/rest/member/profileShow?memberId=${clubMember.memberId}" width="100" height="100" class="rounded-circle">
	${clubMember.memberName}
	${clubMember.clubMemberRank}
	${clubMember.joinMessage}
	</div>
	</div>
	</c:forEach>
	<!-- 동호회 만들면 올자리 -->
	<div class="row attach-meeting-list"></div>
	
	<div class="row">
		<div class="col">
			<button type="button" class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#exampleModal">
			  	동호회 만들기
			</button>
		</div>
	</div>
	
    
</div>
    
      <div class="modal fade exampleModal"
                data-bs-backdrop="static" tabIndex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">가입인사를 작성해주세요</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                  <div class="col">
                    <input type="text" class="form-control joinMessage">
                  </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button class="btn btn-success commit">확인</button>
            </div>
            </div>
        </div>
      </div>
      
      <!-- 동호회 모임 만드는 Modal -->
    <!-- Button trigger modal -->


<!-- Modal -->
        <form action="" enctype="multipart/form-data" class="makeMeetingForm">
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">정모 만들기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        	<input type="hidden" class="meetingClubNo" data-no="${clubDto.clubNo}" name="clubNo" value="${clubDto.clubNo}">
			<input type="file" class="meetingImage" name="meetingImage" id="meetingImage">
			<input type="text" class="meetingName" name="meetingName" placeholder="정모 이름">        
        	<input type="date" class="meetingDate" name="meetingDate" placeholder="12월 31일">
        	<input type="time" class="meetingTime" name="meetingTime" placeholder="오후 12:00">
        	<input type="text" class="meetingLocation" name="meetingLocation" placeholder="위치를 입력하세요">
        	<input type="number" class="meetingPrice" name="meetingPrice" placeholder="모임비 15000원">원
        	<input type="number" class="meetingMaxPeople" name="meetingNumber" placeholder="모임 정원">명
        	
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary btn-make-meeting" data-bs-dismiss="modal">만들기</button>
      </div>
    </div>
  </div>
</div>
        </form>
    
    

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
