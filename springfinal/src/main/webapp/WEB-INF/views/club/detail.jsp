<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/hangul-js" type="text/javascript"></script>



<script>
$(function(){
	
    loadList();
	
	    if($(".meetingFix").prop("checked")){
	        $("[name=meetingFix]").val('Y');
	    } else {
	        $("[name=meetingFix]").val('N');
	    }

	$(".meetingFix").change(function(){
		
		 if($(".meetingFix").prop("checked")){
		        $("[name=meetingFix]").val('Y');
		    } else {
		        $("[name=meetingFix]").val('N');
		    }
		
	});
	
	
    /* $(".join").click(function(e){
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
    }); */

    $(".commit").click(function(){
        var clubNo = $(".clubNo").data("no");
        var memberId = $(".memberId").data("id");
        var joinMessage = $(".joinMessage").val();

        $.ajax({
            url: "http://localhost:8080/rest/clubMember",
            method: "post",
            data: { clubNo: clubNo, clubMemberId: memberId, joinMessage: joinMessage },
            success: function (response) {
            
             $(".cancel").click();
             
             alert("가입되었습니다.");
             
             location.reload();
                
            }
        });
    });
    
    //미팅 만들기 
    $(".btn-make-meeting").click(function(e) {
        e.preventDefault();

        // 파일 선택
        var meetingImageInput = $(".meetingImage")[0];
        var attach = meetingImageInput.files[0];

        // 각 필드 값을 가져오기
        var meetingClubNo = $(".clubNo").data("no");
        var meetingName = $(".meetingName").val();
        var meetingDate = $(".meetingDate").val();
        var meetingTime = $(".meetingTime").val();
        var meetingLocation = $(".meetingLocation").val();
        var meetingPrice = $(".meetingPrice").val();
        var meetingNumber = $(".meetingMaxPeople").val();
		var formatDateTime = meetingDate + " " + meetingTime; 
		
		var meetingFix = $(".meetingFix").val();

			
        // FormData 객체 생성
        var formData = new FormData();
        formData.append("clubNo", meetingClubNo);
        formData.append("meetingName", meetingName);
        formData.append("meetingTime", formatDateTime);
        formData.append("meetingLocation", meetingLocation);
        formData.append("meetingPrice", meetingPrice);
        formData.append("meetingNumber", meetingNumber);
        formData.append("attach", attach);
        formData.append("meetingFix", meetingFix);

        // Ajax 통신
        $.ajax({
            url: window.contextPath + "/rest/meeting/insert",
            method: "post",
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                console.log("성공, 목록을 갱신합니다");
                loadList();
            },
            error: function(error) {
                console.error("파일 업로드 에러", error);
                // 오류 처리 로직 추가
            }
        });
    });

    
    $(document).on('click', '.meetingEdit', function(){
        
        var meetingNo = $(this).data("no");

        
        $.ajax({
            url: window.contextPath + "/rest/meeting/edit",
            method: "get",
            data: {meetingNo:meetingNo},
            success: function(response) {
            	
            	
            	fillModalWithData(response);
                
            }
        });
        $("#meetingEditModal").modal('show');
    });
    
    
    $(".btn-edit-commit").click(function(){
    	
    	
    	
    	 var meetingImageInput = $(".meetingImageByEdit")[0];
         var attach = meetingImageInput.files[0];

         // 각 필드 값을 가져오기
         var meetingNo = $(".meetingNoByEdit").val();
         var meetingName = $(".meetingNameByEdit").val();
         var meetingDate = $(".meetingDateByEdit").val();
         var meetingTime = $(".meetingTimeByEdit").val();
         var meetingLocation = $(".meetingLocationByEdit").val();
         var meetingPrice = $(".meetingPriceByEdit").val();
         var meetingNumber = $(".meetingMaxPeopleByEdit").val();
 		var formatDateTime = meetingDate + " " + meetingTime; 
 		
 		var meetingFix = $(".meetingFixByEdit").val();

 			
         // FormData 객체 생성
         var formData = new FormData();
         formData.append("meetingNo", meetingNo);
         formData.append("meetingName", meetingName);
         formData.append("meetingTime", formatDateTime);
         formData.append("meetingLocation", meetingLocation);
         formData.append("meetingPrice", meetingPrice);
         formData.append("meetingNumber", meetingNumber);
         formData.append("meetingFix", meetingFix);
         formData.append("attach", attach);
    	
    	
    	$.ajax({
            url: window.contextPath + "/rest/meeting/edit",
            method: "post",
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                console.log("성공, 목록을 갱신합니다");
                loadList();
            },
            error: function(error) {
                console.error(error);
            }
        });
    	
    	
    	
    })
    
    
    
    
    
    
 // 모달에 데이터를 채우는 함수
    function fillModalWithData(meetingData) {
        // 모달 내부의 필드에 데이터 채우기
        $("#meetingEditModal .meetingNoByEdit").val(meetingData.meetingNo);
        $("#meetingEditModal .meetingNameByEdit").val(meetingData.meetingName);
        $("#meetingEditModal .meetingLocationByEdit").val(meetingData.meetingLocation); 
        $("#meetingEditModal .meetingPriceByEdit").val(meetingData.meetingPrice); 
        $("#meetingEditModal .meetingDateByEdit").val(meetingData.date); 
        $("#meetingEditModal .meetingTimeByEdit").val(meetingData.time); 
        $("#meetingEditModal .meetingMaxPeopleByEdit").val(meetingData.meetingNumber);
        $("#meetingEditModal .img").attr("src","/rest/meeting/attchImage?attachNo=" + meetingData.attachNo);
        // 나머지 필드에 대해서도 필요한 데이터 채우기

        // 예시에서는 meetingFix가 체크박스이므로, 체크 상태를 설정합니다.
        if (meetingData.meetingFix === 'Y') {
            $("#meetingEditModal .meetingFixByEdit").prop("checked", true);
        } else {
            $("#meetingEditModal .meetingFixByEdit").prop("checked", false);
        }
    }
    
    
    
    
    
   	//동호회를 만들었을때 넣어줘야 할 목록
    function loadList() {
        var params = new URLSearchParams(location.search);
        var clubNo = params.get("clubNo");
        
        $.ajax({
            url: window.contextPath + "/rest/meeting/list",
            method: "get",
            data: {
                clubNo: clubNo,
            },
            success: function (response) {
            	
      $(".attach-meeting-list").empty();
            	
                for(var i=0; i<response.length; i++){
                	var meeting = response[i];
                	var attendMemberList = meeting.attendMemberList;
                	
                	
                	var template = $("#meeting-template").html();
                	var htmlTemplate = $.parseHTML(template);
                	
                	
                	
                	
                	if(meeting.attachNo!=0){
                	
                	var img = $('<img>')
                    .attr('src', "/rest/meeting/attchImage?attachNo=" + meeting.attachNo)
                    .attr('width', '100')
                    .attr('height', '100');}
                	else{
                		var img = $('<img>')
                        .attr('src', "/images/noimage.jpg")
                        .attr('width', '100')
                        .attr('height', '100');
                		
                	}
                	
                	
                	
                	
                	
                	$(htmlTemplate).find(".img").append(img);
                	$(htmlTemplate).find(".ddayInput").text("D-"+meeting.dday);
                	$(htmlTemplate).find(".meetingNoInput").text(meeting.meetingNo);
                	$(htmlTemplate).find(".meetingNameInput").text(meeting.meetingName);
                	$(htmlTemplate).find(".dateStringInput").text(meeting.dateString);
                	$(htmlTemplate).find(".locationInput").text(meeting.meetingLocation);
                	$(htmlTemplate).find(".meetingPriceInput").text(meeting.meetingPrice);
                	$(htmlTemplate).find(".meetingNumberInput").text(meeting.meetingNumber);
                	$(htmlTemplate).find(".attendCount").text(meeting.attendCount);
                	
                	
                	 for(var a=0;a<attendMemberList.length;a++){
                		
                		$(htmlTemplate).find(".profileList").append(
                				$('<img>')
                				.addClass("rounded-circle")
                				.attr('src',"/rest/member/profileShow?memberId="+attendMemberList[a].clubMemberId)
                				.attr('width', '50')
                    			.attr('height', '50')
                		)
                				
                		
                	} 
                	
                	//버튼
                	$(htmlTemplate).find(".meetingEdit").attr("data-no",meeting.meetingNo);
                	$(htmlTemplate).find(".meetingDelete").attr("data-no",meeting.meetingNo);
                	$(htmlTemplate).find(".attend").attr("data-no",meeting.meetingNo);
                	$(htmlTemplate).find(".attendDelete").attr("data-no",meeting.meetingNo);
                	
                	
                	if(meeting.didAttend){
                		
                    	$(htmlTemplate).find(".attend").remove();
                		
                		
                		
                		
                	}
                	
                	if(!meeting.didAttend){
                		
                		$(htmlTemplate).find(".attendDelete").remove();
                		
                	}
                	
                	if(!meeting.manager){
                		
                    	$(htmlTemplate).find(".meetingEdit").remove();
                    	$(htmlTemplate).find(".meetingDelete").remove();
                		
                		
                		
                	}
                	
                	
                	
                	$(".attach-meeting-list").append(htmlTemplate);
                }
                
                
                
                
            }
        });
    }
   	
   	
   	$(document).on('click',".attend",function(){
   	
   	  var params = new URLSearchParams(location.search);
      var clubNo = params.get("clubNo");
      var meetingNo = $(this).data("no");
      
   		
   	    $.ajax({
            url: window.contextPath +"/rest/meeting/attend",
            method: "post",
            data: { clubNo: clubNo, meetingNo : meetingNo },
            success: function () {
            	loadList();
                
            	
                
                
            },
            error: function(error) {
                console.error("모임참석에러", error);
            }
        });
   		
   		
   		
   		
   	})
   	
   	$(document).on('click',".attendDelete",function(){
   		
   		console.log("취소 누름");
   	
   	  var params = new URLSearchParams(location.search);
      var clubNo = params.get("clubNo");
      var meetingNo = $(this).data("no");
      
      console.log("clubNo="+clubNo);
      console.log("meetingNo="+meetingNo);
   		
   	    $.ajax({
            url: window.contextPath +"/rest/meeting/attendDelete",
            method: "post",
            data: { clubNo: clubNo, meetingNo : meetingNo },
            success: function (response) {
            	
            	console.log(response);
            	loadList();
                
                
            },
            error: function(error) {
                console.error("모임참석에러", error);
            }
        });
   		
   		
   		
   		
   	})
   	
   	$(document).on('click', '.meetingDelete', function () {
   	    var meetingNo = $(this).data('no');


   	    $.ajax({
   	        url: window.contextPath + "/rest/meeting/delete",
   	        method: "post",
   	        data: { meetingNo: meetingNo },
   	        success: function () {
   	            loadList();
   	        },
   	        error: function (error) {
   	            console.error("모임삭제에러", error);
   	        }
   	    });
   	});
   	
   	
   	
});
    </script>
    
    <script id="meeting-template" type="text/template">

   <div class="row">
   	<div class="col">
   	<div class="alert alert-dismissible alert-light">
   	<div>
     <label class="font-weight-bold text-danger ddayInput"></label>
	</div>
   	<div class="img"></div>
   	<div class="meetingNo" data-no="${meetingDto.meetingNo}">
	미팅이름: 
	<label class="meetingNameInput">
	</label>
	</div>
   	<div>미팅날짜: 
	<label class="dateStringInput">
	</label>
	</div>
   	<div>미팅위치: 
	<label class="locationInput">
	</label>
	</div>
   	<div>미팅비용: 
	<label class="meetingPriceInput">
	</label>
	</div>
   	<div>
	미팅참석:  <label class="attendCount"></label>
		/
	<label class="meetingNumberInput">
	</label>
	</div>
	<div class="profileList"></div>
   	<button class="btn btn-primary attend">모임참석</button>
   	<button class="btn btn-danger attendDelete">참석취소</button>
   	<button class="btn btn-primary meetingEdit">모임수정</button>
   	<button class="btn btn-primary meetingDelete">모임삭제</button>
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
   <button type="button" class="btn btn-secondary mt-4 join" data-bs-toggle="modal"
    data-bs-target=".joinModal">가입하기</button>
	</c:if>
	 <c:if test="${editPossible==true}">
   <a href="/club/edit?clubNo=${clubDto.clubNo}">
   <button type="button" class="btn btn-primary mt-4">수정하기</button>
   </a> 
   </c:if>
   
   
   <hr>
   
   <div class="row">
		<div class="col">
			<button type="button" class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#exampleModal">
			  	정모 만들기
			</button>
		</div>
	</div>
   
   <!-- 동호회 만들면 올자리 -->
	<div class="row attach-meeting-list">

   </div>
   
	
	<hr>
	<div class="row">
		<div class="col">
			<h5>모임 멤버(인원수)</h5>
		</div>
	</div>
	<c:forEach var="clubMember" items="${clubMemberDto}">
	
	<div class="row">
	<div class="col memberList">
	<img src="${pageContext.request.contextPath}/rest/member/profileShow?memberId=${clubMember.memberId}" width="100" height="100" class="rounded-circle">
	${clubMember.memberName}
	${clubMember.clubMemberRank}
	${clubMember.joinMessage}
	</div>
	</div>
	</c:forEach>
	
	
	
	
    
</div>
    
      <div class="modal fade joinModal"
                 tabIndex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                <button class="btn btn-secondary cancel" data-bs-dismiss="modal">취소</button>
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
      		<img src="/images/noimage.jpg" width="200">
        	<input type="hidden" class="meetingClubNo" data-no="${clubDto.clubNo}" name="clubNo" value="${clubDto.clubNo}">
			<input type="file" class="meetingImage" name="attach">
			<input type="text" class="meetingName" name="meetingName" placeholder="정모 이름">        
        	<input type="date" class="meetingDate" name="meetingDate" placeholder="12월 31일">
        	<input type="time" class="meetingTime" name="meetingTime" placeholder="오후 12:00">
        	<input type="text" class="meetingLocation" name="meetingLocation" placeholder="위치를 입력하세요">
        	<input type="number" class="meetingPrice" name="meetingPrice" placeholder="모임비 15000원">원
        	<input type="number" class="meetingMaxPeople" name="meetingNumber" placeholder="모임 정원">명
        	모임공개여부<input class="form-check-input meetingFix" type="checkBox" name="meetingFix">
        	
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary btn-make-meeting" data-bs-dismiss="modal">만들기</button>
      </div>
    </div>
  </div>
</div>
        </form>
        
        
<div class="modal fade" id="meetingEditModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">정모 만들기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      		<img src="/images/noimage.jpg" width="200" class="img">
        	<input type="hidden" class="meetingNoByEdit" name="meetingNo" value="${meetinDto.meetingNo}">
			<input type="file" class="meetingImageByEdit" name="attach">
			<input type="text" class="meetingNameByEdit" name="meetingName" placeholder="정모 이름" value="${meetingDto.meetingName}">        
        	<input type="date" class="meetingDateByEdit" name="meetingDate" placeholder="12월 31일">
        	<input type="time" class="meetingTimeByEdit" name="meetingTime" placeholder="오후 12:00">
        	<input type="text" class="meetingLocationByEdit" name="meetingLocation" placeholder="위치를 입력하세요">
        	<input type="number" class="meetingPriceByEdit" name="meetingPrice" placeholder="모임비 15000원">원
        	<input type="number" class="meetingMaxPeopleByEdit" name="meetingNumber" placeholder="모임 정원">명
        	모임공개여부<input class="form-check-input meetingFixByEdit" type="checkBox" name="meetingFix">
        	
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-primary btn-edit-commit" data-bs-dismiss="modal">수정하기</button>
      </div>
    </div>
  </div>
</div> 
        
        
          <div class="modal fade joinFinish">
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
                  가입되었습니다.
                  </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-success" data-bs-dismiss="modal">확인</button>
            </div>
            </div>
        </div>
      </div>
    
    

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
