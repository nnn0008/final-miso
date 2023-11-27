<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/hangul-js" type="text/javascript"></script>

<link href="${pageContext.request.contextPath}/css/club.css"
	rel="stylesheet">

<style>
.img-thumbnail:hover {
   cursor: pointer;
}

.attached-image {
   width: 100% !important;
   height: 100%; ! important;
   object-fit: cover !important;
}

.img-thumbnail {
   border: none !important;
}

.img-box img {
   width: 100%;
   height: 100%;
   object-fit: cover;
}

.row .col .d-flex {
   display: flex;
   align-items: center;
}

.row .col .d-flex i {
   margin-right: 5px;
}

.club-box-detail {
   width: 550px;
   height: 250px;
}

.club-detail-image {
   width: 100%;
   height: 100%;
   object-fit: cover;
   border-radius: 1%;
}

.fa-gray {
   border-radius: 50%;
   background-color: #EBE8E8;
}

.club-member-badge {
   border-radius: 50%;
   background-color: #66DFD2;
   color: #ffffff;
   position: absolute;
   top: 70px; /* 상단 여백 조절 */
   left: 80px; /* 좌측 여백 조절 */
   font-size: 16px; /* 아이콘의 크기 조절 */
}

/* .position-relative { */
/*     position: relative; */
/* } */


/* .meeting-member-badge{ */
/*    border-radius: 50%; */
/*    background-color: #66DFD2; */
/*    color: #ffffff; */
/*    top: 50px;  */
/*    left:0px;  */
/*     z-index: 2;  */
/* } */

.parent-container {
    position: relative;
}

.meeting-member-badge {
     border-radius: 50%;
    position: absolute;
    top: -25px; 
    left: 30px; 
    background-color: #66DFD2;
    color: #ffffff;
}


.fa-star {
   border-radius: 50%;
   background-color: #FFBCF0;
   color: #ffffff;
}


.preview-wrapper2 {
   width: 466px; /* 부모 요소의 너비 지정 */
   height: 200px; /* 부모 요소의 높이 지정 */
   overflow: hidden; /* 부모 요소를 넘치는 내용 숨김 */
}

.preview, .preview2 {
   width: 100%;
   height: 100%;
   object-fit: cover;
}

.meeting-box {
   box-shadow: 0 0 10px #EBE8E8;
}
</style>



<script>
	
	
	$(function(){
		
		
		disablePastDates();
		
	    function getCurrentDate() {
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; // January is 0!
            var yyyy = today.getFullYear();

            if (dd < 10) {
                dd = '0' + dd;
            }

            if (mm < 10) {
                mm = '0' + mm;
            }

            return yyyy + '-' + mm + '-' + dd;
        }

        // 페이지 로딩 후 실행될 함수
        function disablePastDates() {
            var currentDate = getCurrentDate();
            
            $('[name=meetingDate]').prop('min', currentDate);
        }
		
		
		
	})
	


</script>

<script>
        $(function(){
        	
        	
        	
        	
            $("#selector").change(function(){
            	
                if(this.files.length == 0) {
                    //초기화
                    return;
                }

                //파일 미리보기는 서버 업로드와 관련이 없다
                //- 서버에 올릴거면 따로 처리를 또 해야 한다
                
                //[2] 직접 읽어서 내용을 설정하는 방법
                let reader = new FileReader();
                reader.onload = ()=>{
                    
                    $(".preview-wrapper2").find(".preview").attr("src",reader.result);
                    
                };
                for(let i=0; i < this.files.length; i++) {
                    reader.readAsDataURL(this.files[i]);
                }
            });
            
			$("#selector2").change(function(){
            	
                if(this.files.length == 0) {
                    //초기화
                    return;
                }

                //파일 미리보기는 서버 업로드와 관련이 없다
                //- 서버에 올릴거면 따로 처리를 또 해야 한다
                
                //[2] 직접 읽어서 내용을 설정하는 방법
                let reader = new FileReader();
                reader.onload = ()=>{
                    
                    $(".preview-wrapper2").find(".preview2").attr("src",reader.result);
                    
                };
                for(let i=0; i < this.files.length; i++) {
                    reader.readAsDataURL(this.files[i]);
                }
            });
        });
    </script>




<script>




$(function(){
	
	
	var bodyClubMemberNo = $(".bodyClubMemberNo").data("no");
	var memberRankIsMaster = ${editPossible}; 

	if (memberRankIsMaster === false) {
	    $("[name=makeMeeting]").remove();
	}
	
	


	
	
	 loadMemberList();
	 
		
	  $(".upgradeRank").remove();
	  
	  function loadMemberList(){
		  var params = new URLSearchParams(location.search);
	        var clubNo = params.get("clubNo");
              
		  
		  $.ajax({
	            url: "http://localhost:8080/rest/clubMemberList",
	            method: "get",
	            data: { clubNo: clubNo},
	            success: function (response) {
	            	
	            	$(".clubMemberList").empty();
              	
              for(var a=0;a<response.length;a++){
	            	var clubMember = response[a];
	            	var template = $("#clubMember-template").html();
              	var htmlTemplate = $.parseHTML(template);
              	
              	$(htmlTemplate).find(".href").attr('href',"/member/mypage?memberId="+clubMember.memberId);
              	
              	if(clubMember.attachNo!=0){
              	$(htmlTemplate).find(".profileImage").attr('src',"/rest/member/profileShow?memberId="+clubMember.memberId);
              	}
              		if(clubMember.clubMemberRank == '운영진'){
              			var i =$('<i>');
              			
              			i.addClass("fa-solid fa-crown fa-lg pt-3 pb-3 ps-2 pe-2 club-member-badge");
              			
              		   $(htmlTemplate).find(".profileImage").after(i);
              			
              		}
              		
              	if(clubMember.attachNo==0){
              		$(htmlTemplate).find(".profileImage").attr('src',"/images/basic-profile2.png");
              		
              	}
              	
              	$(htmlTemplate).find(".upgradeRank").data('clubMemberNo',clubMember.clubMemberNo);
              	 if(clubMember.masterRank==false||clubMember.clubMemberRank=='운영진'){
              		
              		 $(htmlTemplate).find(".upgradeRank").hide(); 

              		
              	} 
              	
              	
              	$(htmlTemplate).find(".memberName").html("<strong>" + clubMember.memberName + "</strong> | " + clubMember.joinDateString + " 가입");

              	$(htmlTemplate).find(".joinMessage").text(clubMember.joinMessage);
	            	
              	$(".clubMemberList").append(htmlTemplate);
              	
              	}
              	
	            }
	        })
		  
		  
		  
		  
	  }
	  
	  
	  $(document).on('click','.upgradeRank',function(){
		  
		  
		  var clubMemberNo = $(this).data("clubMemberNo");
		  
		  $.ajax({
			  url: "http://localhost:8080/rest/upgradeRank",
	          method: "get",
	          data: { clubMemberNo: clubMemberNo},
	          success: function (response) {
	        	  loadMemberList();
			  
		  }
		  }) 
	  })
	
	
	$('#exampleModal').on('hidden.bs.modal', function () {
	    // 모달이 닫힐 때 실행되는 코드 작성
	    // 여기에 원하는 동작을 추가하세요.
	    
	    $(".makeMeetingForm")[0].reset();
	    $("#exampleModal .preview").attr("src","/images/noimage.jpg");
	    
	    
	});
	
	
	
	var page = 1;
	 var totalCount = $(".totalCount").val();
	
	
	
	loadCutList();
	
	    if($(".meetingFix").prop("checked")){
	        $("[name=meetingFix]").val('Y');
	    } else {
	        $("[name=meetingFix]").val('N');
	    }

	$(".meetingFixByEdit").change(function(){
		
		 if($("[name=meetingFixByEdit]").prop("checked")){
		        $("[name=meetingFixByEdit]").val('Y');
		    } else {
		        $("[name=meetingFixByEdit]").val('N');
		    }
		
	});
	

    if($(".meetingFixByEdit").prop("checked")){
        $("[name=meetingFixByEdit]").val('Y');
    } else {
        $("[name=meetingFixByEdit]").val('N');
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
    	
    	
    	var message = $(".modalJoinMessage").val();
        var clubNo = $(".clubNo").data("no");
        var memberId = $(".memberId").data("id");
        var joinMessage = $(".modalJoinMessage").val();
        
        if(message.length==0){
        	
        	$(".modalJoinMessage").addClass("is-invalid");
        }
        else{
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
        }
    });
    
    //미팅 만들기 
    $(".btn-make-meeting").click(function(e) {
        e.preventDefault();
        
        
        var nameOk= $(".meetingName").val().length!=0;
        console.log("nameOk"+nameOk);
        
        var dateOk = $(".meetingDate").val() !== "" && $(".meetingDate").val() !== null;
        console.log("dateOk"+dateOk);
        
        var timeOk = $(".meetingTime").val() !== "" && $(".meetingTime").val() !== null;
        console.log("timeOk"+timeOk);
        
        var locationOk= $(".meetingLocation").val().length!=0;
        console.log("locationOk"+locationOk);
        
        var price = $(".meetingPrice").val();
        var priceOk= price.length!=0&&price>0;
        
        var people=$(".meetingMaxPeople").val();
        var peopleOk= people.length!=0&&people>0;
        
        
        var pass = nameOk&&dateOk&&timeOk&&locationOk&&priceOk&&peopleOk;
        
        
        
        

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
        
        

        if(!pass){
        	if(!nameOk){
        		$(".meetingName").addClass("is-invalid");
           		}
           		if(!dateOk){
           			$(".meetingDate").addClass("is-invalid");
           		}
        		if(!timeOk){
           			$(".meetingTime").addClass("is-invalid");
           		}
        	if(!priceOk){
           			$(".meetingPrice").addClass("is-invalid");
           		}
        	if(!locationOk){
        		$(".meetingLocation").addClass("is-invalid");
        	}
        	if(!peopleOk){
           			$(".meetingMaxPeople").addClass("is-invalid");
           		}
        }
        
        else{
        // Ajax 통신
        $.ajax({
            url: window.contextPath + "/rest/meeting/insert",
            method: "post",
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
            	
          
                 
            	$(".notMeeting").remove();
            	
                totalCount++;
			/* if($(".cut").is(":hidden")){
            		
            		loadCutList();
            	}
            	else{
            	
            	loadList();
            	} */
            		
            	$("#exampleModal").modal('hide');
            	
            		loadCutList();
            		
            	
            }
        });
        
    }
        
        
        
        
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

 		console.log(meetingDate);
 		console.log(meetingTime);
 		console.log(formatDateTime);
 			
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
    	
         var meetingNo = $(this).data("no");
         
         var nameOk= $(".meetingNameByEdit").val().length!=0;
         console.log("nameOk"+nameOk);
         
         var dateOk = $(".meetingDateByEdit").val() !== "" && $(".meetingDate").val() !== null;
         console.log("dateOk"+dateOk);
         
         var timeOk = $(".meetingTimeByEdit").val() !== "" && $(".meetingTime").val() !== null;
         console.log("timeOk"+timeOk);
         
         var locationOk= $(".meetingLocationByEdit").val().length!=0;
         console.log("locationOk"+locationOk);
         
         var price = $(".meetingPriceByEdit").val();
         var priceOk= price.length!=0&&price>0;
         
         var people=$(".meetingMaxPeopleByEdit").val();
         var peopleOk= people.length!=0&&people>0;
         
         
         var pass = nameOk&&dateOk&&timeOk&&locationOk&&priceOk&&peopleOk;
    	
         if(!pass){
        	 
        	 if(!nameOk){
         		$(".meetingNameByEdit").addClass("is-invalid");
            	}
        	 
            if(!dateOk){
            			$(".meetingDateByEdit").addClass("is-invalid");
            		}
            
         	if(!timeOk){
            			$(".meetingTimeByEdit").addClass("is-invalid");
            		}
         	
         	if(!priceOk){
            			$(".meetingPriceByEdit").addClass("is-invalid");
            		}
         	
         	if(!locationOk){
         		$(".meetingLocationByEdit").addClass("is-invalid");
         	}
         	
         	if(!peopleOk){
            			$(".meetingMaxPeopleByEdit").addClass("is-invalid");
            		}
        	 
         }
         
         else{
        	 
        	 
    	$.ajax({
            url: window.contextPath + "/rest/meeting/edit",
            method: "post",
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
            	
            
            	
				if	($(".cut").is(":hidden")){
            		
            		loadCutList();

            	}
            	else{
            	
            	loadList();
            	}
				
				$("#meetingEditModal").modal('hide')
            }
        });
    }
    	
    	
    })
    
   
    
    
    $(".more").click(function(){
    	
    	loadList();
    	
    })
    
    $(".cut").click(function(){
    	
    	loadCutList();
    	
    	
    })
    
    
    	
    function loadCutList(){
    	
    	
    	 var params = new URLSearchParams(location.search);
         var clubNo = params.get("clubNo");
         
         $.ajax({
             url: window.contextPath + "/rest/meeting/list",
             method: "get",
             data: {
                 whereNo: clubNo, page:page,clubNo:clubNo
             },
             success: function (response) {
            	 
            	 
            	 
             /* 	if(response.length<count){
             		
             		$(".more").remove();
             	var pageCancel=	$('<button>').addClass("btn btn-danger w-100 origin")
             		.text("접기");
             		
             		$(".more-btn").append(pageCancel);
             		
             	} */
             	
             	$(".attach-meeting-list").empty(); 
            	
             	
                 for(var i=0; i<response.length; i++){
                 	var meeting = response[i];
                 	var attendMemberList = meeting.attendMemberList;
                 	
                 	
                 	var template = $("#meeting-template").html();
                 	var htmlTemplate = $.parseHTML(template);
                 	
                 	
                 	
                 	
                 	if(meeting.attachNo!=0){
                 	
                 	var img = $('<img>')
                     .attr('src', "/rest/meeting/attchImage?attachNo=" + meeting.attachNo)
                     .attr('width', '230')
                     .attr('height', '130')
                 	.css('border-radius', '10px'); 
                 	}
                 	else{
                 		var img = $('<img>')
                         .attr('src', "/images/noimage.jpg")
                         .attr('width', '230')
                         .attr('height', '130')
                         .css('border-radius', '10px'); 
                 	}
                 	           	
                 	$(htmlTemplate).find(".img").append(img);
                 	$(htmlTemplate).find(".ddayInput").text("D-"+meeting.dday);
                 	$(htmlTemplate).find(".meetingNoInput").text(meeting.meetingNo);
                 	$(htmlTemplate).find(".meetingNameInput").text(meeting.meetingName);
                 	$(htmlTemplate).find(".dateStringInput").text(meeting.dateString);
                 	$(htmlTemplate).find(".locationInput").text(meeting.meetingLocation);
                 	$(htmlTemplate).find(".meetingPriceInput").text(meeting.meetingPrice);
                 	$(htmlTemplate).find(".meetingNumberInput").text(meeting.meetingNumber).data("no",meeting.meetingNumber);
                 	$(htmlTemplate).find(".attendCount").text(meeting.attendCount).data("no",meeting.attendCount);
                 	
                 	var modifiedDateString = (meeting.date).replace(/-/g, '/');
                 modifiedDateString = modifiedDateString.slice(0, -1) + '(' + modifiedDateString.slice(-1) + ')';
                 	
                 	$(htmlTemplate).find(".monthAndDay").text(modifiedDateString);
                 	
        	
                 	  var profileList = $(htmlTemplate).find(".profileList");
                      profileList.addClass("d-flex align-items-center flex-wrap"); // flex-wrap 추가

                      for (var a = 0; a < attendMemberList.length; a++) {
                          var aLink = $('<a>').attr('href', "/member/mypage?memberId=" + attendMemberList[a].clubMemberId);

                          if (attendMemberList[a].attachNo != 0) {
                              var image = $('<img>')
                                  .addClass("rounded-circle me-3")
                                  .attr('src', "/rest/member/profileShow?memberId=" + attendMemberList[a].clubMemberId)
                                  .attr('width', '50')
                                  .attr('height', '50');
                          } else {
                              var image = $('<img>')
                                  .addClass("rounded-circle me-3")
                                  .attr('src', "/images/basic-profile.png")
                                  .attr('width', '50')
                                  .attr('height', '50');
                          }

                          aLink.append(image);

                          if (attendMemberList[a].clubMemberRank === '운영진') {
                              // '운영진'일 경우 배지를 aLink에 추가
                              $('<i>')
                                  .addClass("fa-solid fa-crown p-1 meeting-member-badge")
                                  .appendTo($('<div>').addClass("col parent-container").appendTo(aLink)); // parent-container 추가
                          }

                          profileList.append(aLink);

                      }



                var memberId = "${sessionScope.name}";
            	if (meeting.meetingFix === 'N') {
            	    // 새로운 div 엘리먼트 생성
            	    var divElement = $('<div>').addClass('secret-club');
            	    var badgeElement = $('<span>').addClass('badge bg-danger ms-1 mb-1').text('비공개 정모');
            	    var secretIcon = $('<i>').addClass("fa-solid fa-unlock-keyhole ms-2");
            	    var secretIconBig = $('<i>').addClass("fa-solid fa-lock ms-2").css({
            	        'font-size': '150px',
            	        'height': '250px',
            	        'display': 'flex',
            	        'justify-content': 'center', // 좌우 가운데 정렬
            	        'align-items': 'center' // 상하 가운데 정렬
            	    });
					
            	    

            	    if (bodyClubMemberNo == 0) {
            	        // 클럽 멤버가 아닌 경우 효과 적용
            	        secretIcon.removeClass('fa-unlock-keyhole').addClass('fa-lock');
            	        divElement.css('opacity', '0.7');

            	        // alert 엘리먼트에 새로운 텍스트 추가
            	        var alertElement = $(htmlTemplate).find(".alert");
            	        alertElement.empty(); // 글자를 없애는 부분
            	          
            	        // 큰 좌물쇠 아이콘 추가
            	        alertElement.append(secretIconBig);
            	    }
            	    

            	    // 새로 생성한 엘리먼트들을 기존 템플릿에 추가
            	    $(htmlTemplate).prepend(divElement.append(badgeElement.append(secretIcon)));
            	}

            	// 최종 결과를 화면에 추가
            	$(".attach-meeting-list").append(htmlTemplate);
            
            


						
                 	//버튼
                 	$(htmlTemplate).find(".meetingEdit").attr("data-no",meeting.meetingNo).attr("data-number",i);
                 	$(htmlTemplate).find(".meetingDelete").attr("data-no",meeting.meetingNo).attr("data-number",i);
                 	$(htmlTemplate).find(".attend").attr("data-no",meeting.meetingNo).attr("data-number",i);
                	$(htmlTemplate).find(".attendDelete").attr("data-no",meeting.meetingNo).attr("data-number",i);
                 	
                 	
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
                 
             
                 
              
                 
                 if(totalCount>response.length){
                	 $(".more").show();
                	 $(".cut").hide();
                 }
                 if(totalCount<=response.length){
                	 $(".cut").hide();
                	 $(".more").hide();
                 }
                
                	 
                 }
                 
                 
             
         });
    	
}
    	
    	
    	
    
    
    
    
    
    
    
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
        
        if(meetingData.attachNo!=0){
        	$("#meetingEditModal .preview2").attr("src","/rest/meeting/attchImage?attachNo=" + meetingData.attachNo);
        }
        
        else{
        	
        	$("#meetingEditModal .preview2").attr("src","/images/noimage.jpg");
        	
        }
        // 나머지 필드에 대해서도 필요한 데이터 채우기

        // 예시에서는 meetingFix가 체크박스이므로, 체크 상태를 설정합니다.
        if (meetingData.meetingFix === 'Y') {
            $("#meetingEditModal .meetingFixByEdit").prop("checked", true);
        } else {
            $("#meetingEditModal .meetingFixByEdit").prop("checked", false);
        }
    }
    
    
    
    
    
    function loadList() {
        var params = new URLSearchParams(location.search);
        var clubNo = params.get("clubNo");
        
        
        $.ajax({
            url: window.contextPath + "/rest/meeting/allList",
            method: "get",
            data: {
                clubNo:clubNo
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
                    .attr('width', '230')
                    .attr('height', '130');}
                	else{
                		var img = $('<img>')
                        .attr('src', "/images/noimage.jpg")
                        .attr('width', '230')
                        .attr('height', '130');
                		
                	}
                	
                	
                	        	
                	$(htmlTemplate).find(".img").append(img);
                	$(htmlTemplate).find(".ddayInput").text("D-"+meeting.dday);
                	$(htmlTemplate).find(".meetingNoInput").text(meeting.meetingNo);
                	$(htmlTemplate).find(".meetingNameInput").text(meeting.meetingName);
                	$(htmlTemplate).find(".dateStringInput").text(meeting.dateString);
                	$(htmlTemplate).find(".locationInput").text(meeting.meetingLocation);
                	$(htmlTemplate).find(".meetingPriceInput").text(meeting.meetingPrice);
                	$(htmlTemplate).find(".meetingNumberInput").text(meeting.meetingNumber).data("no",meeting.meetingNumber);
                	$(htmlTemplate).find(".attendCount").text(meeting.attendCount).data("no",meeting.attendCount);
                	$(htmlTemplate).find(".monthAndDay").text(meeting.date);
                	
                	var modifiedDateString = (meeting.date).replace(/-/g, '/');
                    modifiedDateString = modifiedDateString.slice(0, -1) + '(' + modifiedDateString.slice(-1) + ')';
                    	
                    	$(htmlTemplate).find(".monthAndDay").text(modifiedDateString);

                   	  var profileList = $(htmlTemplate).find(".profileList");
                        profileList.addClass("d-flex align-items-center flex-wrap"); // flex-wrap 추가

                        for (var a = 0; a < attendMemberList.length; a++) {
                            var aLink = $('<a>').attr('href', "/member/mypage?memberId=" + attendMemberList[a].clubMemberId);

                            if (attendMemberList[a].attachNo != 0) {
                                var image = $('<img>')
                                    .addClass("rounded-circle me-3")
                                    .attr('src', "/rest/member/profileShow?memberId=" + attendMemberList[a].clubMemberId)
                                    .attr('width', '50')
                                    .attr('height', '50');
                            } else {
                                var image = $('<img>')
                                    .addClass("rounded-circle me-3")
                                    .attr('src', "/images/basic-profile.png")
                                    .attr('width', '50')
                                    .attr('height', '50');
                            }

                            aLink.append(image);

                            if (attendMemberList[a].clubMemberRank === '운영진') {
                                // '운영진'일 경우 배지를 aLink에 추가
                                $('<i>')
                                    .addClass("fa-solid fa-crown p-1 meeting-member-badge")
                                    .appendTo($('<div>').addClass("col parent-container").appendTo(aLink)); // parent-container 추가
                            }

                            profileList.append(aLink);

                        }

                	
                	//버튼
                	$(htmlTemplate).find(".meetingEdit").attr("data-no",meeting.meetingNo).attr("data-number",i);
                	$(htmlTemplate).find(".meetingDelete").attr("data-no",meeting.meetingNo).attr("data-number",i);
                	$(htmlTemplate).find(".attend").attr("data-no",meeting.meetingNo).attr("data-number",i);
                	$(htmlTemplate).find(".attendDelete").attr("data-no",meeting.meetingNo).attr("data-number",i);
                	
                	
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
                	
                	if (meeting.meetingFix === 'N') {
                	    // 새로운 div 엘리먼트 생성
                	    var divElement = $('<div>').addClass('secret-club');
                	    var badgeElement = $('<span>').addClass('badge bg-danger ms-1 mb-1').text('비공개 정모');
                	    var secretIcon = $('<i>').addClass("fa-solid fa-unlock-keyhole ms-2");
                	    var secretIconBig = $('<i>').addClass("fa-solid fa-lock ms-2").css({
                	        'font-size': '150px',
                	        'height': '250px',
                	        'display': 'flex',
                	        'justify-content': 'center', // 좌우 가운데 정렬
                	        'align-items': 'center' // 상하 가운데 정렬
                	    });


                	    if (bodyClubMemberNo == 0) {
                	        // 클럽 멤버가 아닌 경우 효과 적용
                	        secretIcon.removeClass('fa-unlock-keyhole').addClass('fa-lock');
                	        divElement.css('opacity', '0.7');

                	        // alert 엘리먼트에 새로운 텍스트 추가
                	        var alertElement = $(htmlTemplate).find(".alert");
                	        alertElement.empty(); // 글자를 없애는 부분
                	          
                	        // 큰 좌물쇠 아이콘 추가
                	        alertElement.append(secretIconBig);
                	    }

                	    // 새로 생성한 엘리먼트들을 기존 템플릿에 추가
                	    $(htmlTemplate).prepend(divElement.append(badgeElement.append(secretIcon)));
                	}

                	// 최종 결과를 화면에 추가
                	$(".attach-meeting-list").append(htmlTemplate);
                }
                
                
                 if(totalCount<=3) {
                	 loadCutList();
                	 
                 }
                 
                /*  if (meeting.meetingFix === 'N') {
                	    var divElement = $('<div>').addClass('secret-club');
                	    var badgeElement = $('<span>').addClass('badge bg-danger ms-2 mb-1').text('비공개 정모');
                	    
                	    $(htmlTemplate).prepend(divElement.append(badgeElement));
                	} 중간중간 이상하게 나와서 주석처리 */


                 
               
                $(".more").hide();
                $(".cut").show();
                
               
                
                
                
                
            }
        });
        
    }
   	
   	
    	$(".boardWrite").click(function(e){
   		

   		if (bodyClubMemberNo==0) {
   			
   			e.preventDefault();
   			
   		 $(".join-modal-title").text("가입이 필요한 활동입니다!").css("color", "red");
   			
   			$(".joinModal").modal("show");
   			
   		} 
   		
   	})
   	
   	$(".joinModal").click(function(){
   	
   		$(".modalJoinMessage").val("");
   		$(".join-modal-title").text("가입인사를 작성해주세요.").css("color","black");
   		
   		
   	})
   	
   	
   	$("[name=makeMeeting]").click(function(e){
   		
		 	if (bodyClubMemberNo==0) {
		 		$(".join-modal-title").text("가입이 필요한 활동입니다!").css("color", "red");
	   			
	   			$(".joinModal").modal("show");
   			
   		}  
		 	else{
		 		
		 		$("#exampleModal").modal("show");
		 	}
   		
   		
   		
   	})
   	
   	$(".board-detail").click(function(e){
   		
   	
   		
   		if (bodyClubMemberNo==0) {
   		e.preventDefault();
	 		
   			alert("동호회 멤버에게만 공개됩니다.");
			
		} 
   		
   	});
    	
	$(".joinOpen").click(function(){
		
		console.log("조인오픈");
	   	
		var clubNo = ${clubDto.clubNo};
		
   	    $.ajax({
            url: window.contextPath + "/rest/joinPossible",
            method: "get",
            data:{
            	clubNo:clubNo
            },
            success: function (response) {
            	
            	console.log(response)
   		
            	if(response==4){
            		
   				$(".joinModal").modal('show');
   				
            	}
            	
            	else if(response==3){
            		
            		alert("가입할 수 있는 동호회 수를 넘으셨습니다. 파워유저 최대 12개")
				            		
            	}
            	else if(response==2){
            		
            		alert("가입할 수 있는 동호회 수를 넘으셨습니다. 일반유저 최대 5개")
            		
            	}
            	
            	else{
            		
            		alert("동호회 정원이 꽉 찼습니다.")
            		
            	}
   		
   		
   		
   	}
   	    })
   	    
   	});
  
   	
   	
   	
   
   	
   	
   	$(document).on('click',".attend",function(e){
   		
   	  var attendCount = $(this).closest('.meeting-box').find('.attendCount').data("no");
      var meetingNumber = $(this).closest('.meeting-box').find('.meetingNumberInput').data("no");

      
   		
		if (bodyClubMemberNo==0) {
   			
   			
   		 $(".join-modal-title").text("가입이 필요한 활동입니다!").css("color", "red");
   			
   			$(".joinModal").modal("show");
   			
   		} 
		
		else if(attendCount==meetingNumber){
			
			alert("정원이 꽉 찼습니다.");
		}
		

		
		else{
   	
   	  var params = new URLSearchParams(location.search);
      var clubNo = params.get("clubNo");
      var meetingNo = $(this).data("no");
      var number = $(this).data("number");
      
   		
   	    $.ajax({
            url: window.contextPath +"/rest/meeting/attend",
            method: "post",
            data: { clubNo: clubNo, meetingNo : meetingNo },
            success: function () {
            	
            	
            	if($(".cut").is(":hidden")){
            		
            		loadCutList();
            	}
            	else{
            	
            	loadList();
            	}
            	
                
                
            }
        });
   		
   		
   		
		}
   	})
   	
   	$(document).on('click',".attendDelete",function(){
   		
   	
   	  var params = new URLSearchParams(location.search);
      var clubNo = params.get("clubNo");
      var meetingNo = $(this).data("no");
      var number = $(this).data("number");

   		
   	    $.ajax({
            url: window.contextPath +"/rest/meeting/attendDelete",
            method: "post",
            data: { clubNo: clubNo, meetingNo : meetingNo },
            success: function (response) {
				if	($(".cut").is(":hidden")){
            		
            		loadCutList();
            	}
            	else{
            	
            	loadList();
            	}
                
                
            }
        });
   		
   		
   		
   		
   	})
   	
   	$("[name=clubMemberDelete]").click(function(e){
   		
   	  var isConfirmed = confirm("정말 탈퇴하시겠습니까?");

      if (isConfirmed) {
    	  
    	  
        
      } 
      
      else {
   
          e.preventDefault();
      }
   		
   		
   		
   		
   	})
   	
   	
   	
   	
   	
   	
   	
   	$(document).on('click', '.meetingDelete', function () {
   	    var meetingNo = $(this).data('no');
   	    var number = $(this).data('number');
		
   	  var isConfirmed = confirm("모임을 삭제 하시겠습니까?");

      if (!isConfirmed) {
    	  
    	  
        
      } 
      
      else {
   

   	    $.ajax({
   	        url: window.contextPath + "/rest/meeting/delete",
   	        method: "post",
   	        data: { meetingNo: meetingNo },
   	        success: function () {
   	        	totalCount--;
   	        	
				/* 	if($(".cut").is(":hidden")){
            		
            		loadCutList();
            	}
            	else{
            	
            	loadList();
            	} */
            	
            	if(($(".cut").is(":visible"))&&(number<3)){
            		loadList();
            		
            	}
            	
            	else if(number>3){
            	loadList();
            		}
            	else{
            		loadCutList();
            		
            	}
            		
   	        }
   	    });
      }
   	});
    	
    	//입력값 유효성 검사
    	$(".meetingName").on('input',function(){
    		$(this).removeClass("is-invalid");
    	})
    	$(".meetingDate").on('change',function(){
    		$(this).removeClass("is-invalid");
    	})
    	$(".meetingTime").on('change',function(){
    		$(this).removeClass("is-invalid");
    	})
    	$(".meetingLocation").on('input',function(){
    		$(this).removeClass("is-invalid");
    	})
    	$(".meetingPrice").on('input',function(){
    		$(this).removeClass("is-invalid");
    	})
    	$(".meetingMaxPeople").on('input',function(){
    		$(this).removeClass("is-invalid");
    	})
    	
    	$(".meetingNameByEdit").on('input',function(){
    		$(this).removeClass("is-invalid");
    	})
    	$(".meetingDateByEdit").on('change',function(){
    		$(this).removeClass("is-invalid");
    	})
    	$(".meetingTimeByEdit").on('change',function(){
    		$(this).removeClass("is-invalid");
    	})
    	$(".meetingLocationByEdit").on('input',function(){
    		$(this).removeClass("is-invalid");
    	})
    	$(".meetingPriceByEdit").on('input',function(){
    		$(this).removeClass("is-invalid");
    	})
    	$(".meetingMaxPeopleByEdit").on('input',function(){
    		$(this).removeClass("is-invalid");
    	})

   	
    	
});





$(document).ready(function () {
    // 각 링크에 대한 클릭 이벤트 처리
    $("#homeLink").click(function () {
        activateLink("homeLink");
    });

    $("#boardLink").click(function () {
        activateLink("boardLink");
    });

    $("#photoLink").click(function () {
        activateLink("photoLink");
    });

    $("#chatLink").click(function () {
        activateLink("chatLink");
    });

    // 링크를 활성화하고 다른 링크를 비활성화하는 함수
    function activateLink(linkId) {
        $(".btn").removeClass("active").addClass("inactive-link"); // 모든 링크 비활성화
        $("#" + linkId).removeClass("inactive-link").addClass("active"); // 선택한 링크 활성화
    }
});





	











    </script>


<script id="clubMember-template" type="text/template">
<div class="row mt-3 mb-4">

<div class="col memberList">
    <div class="row d-flex align-items-center">
        <div class="col-2 position-relative">
            <a href="/member/mypage?memberId=${clubMember.memberId}" class="href">
                <img src="${pageContext.request.contextPath}/rest/member/profileShow?memberId=${clubMember.memberId}" width="100" height="100" class="rounded-circle profileImage">
            </a>
            <c:if test="${clubMember.clubMemberRank == '운영진'}">
                <i class="fa-solid fa-crown fa-lg pt-3 pb-3 ps-2 pe-2 club-member-badge"></i>
            </c:if>
        </div>
        <div class="col-6 ms-2">
            <div class="row">
                <div class="col memberName">
                    <strong>${clubMember.memberName}</strong> | ${clubMember.joinDateString} 가입
                </div>
            </div>
            <div class="row mt-2">
                <div class="col joinMessage">${clubMember.joinMessage}</div>
            </div>
        </div>
        <div class="col-3">
            <button class="btn btn-miso w-100 upgradeRank">운영진 지정</button>
        </div>
    </div>
</div>


    </div>

</script>

<script id="meeting-template" type="text/template">

  <div class="row mt-3">
                                <div class="col">
                                    <div class="alert alert-dismissible alert-light meeting-box">
                                        <div class="row">
                                            <div class="col-10">
                                                <div class="col">
                                                    <strong><label class="monthAndDay"></label><label class="font-weight-bold text-danger ddayInput ms-2"></label>
                                               </strong></div>
                                                <div class="col mt-2">
                                                    <label class="meetingNameInput">
                                                    </label>
                                                </div>                                          
                                        </div>
                                            <div class="col">
                                                <button class="btn btn-secondary w-100 attend">참석</button>
                                                <button class="btn btn-danger attendDelete">취소</button>
                                            </div>
                                    </div>

<div class="row d-flex align-items-center mt-2">
<div class="col-5 img">
<div class="meetingNo" data-no="${meetingDto.meetingNo}"></div>
</div>
<div class="col-7">
<div class="col mt-1"> <span class="club-explain">일시</span> <label class="dateStringInput"></label></div>
<div class="col mt-1">
                                                    <span class="club-explain">위치</span>  <label class="locationInput">
                                                    </label>
                                                </div>
                                                <div class="col mt-1">
                                                    <span class="club-explain">비용</span>  <label class="meetingPriceInput">
                                                    </label>
                                                </div>
                                                <div class="col mt-1">
                                                    <span class="club-explain">참석</span> <label class="attendCount"></label>
                                                    /
                                                <label class="meetingNumberInput">
                                                </label>
                                                </div>          
</div>
</div>

<div class="col mt-3 profileList">
                                        </div>

 <div class="col text-end">
                                
                                            <i class="fa-solid fa-eraser ms-auto p-2 fa-gray meetingEdit"></i>
                                            <i class="fa-solid fa-trash-can p-2 fa-gray meetingDelete"></i>
                                        </div>

                                </div>
                            </div>


		
</script>


<body>

	<div class="bodyClubMemberNo" data-no="${clubMemberNo}"></div>
	<!-- jsp에 있는 data를 스크립트로 보내주기 위한 태그-->

	<div class="row">
		<div class="col-3 pe-0">
			<a id="homeLink" href="#"
				class="btn btn-miso bg-miso w-100 active">홈</a>
		</div>
		<div class="col-3 pe-0">
			<a id="boardLink"
				href="${pageContext.request.contextPath}/clubBoard/list?clubNo=${clubDto.clubNo}"
				class="btn btn-miso bg-miso w-100">게시판</a>
		</div>
		<div class="col-3 pe-0">
			<a id="photoLink"
				href="${pageContext.request.contextPath}/photo/list?clubNo=${clubDto.clubNo}"
				class="btn btn-miso bg-miso w-100">사진첩</a>
		</div>
		<div class="col-3">
			<a id="chatLink" href="/chat/enterRoom/${clubDto.chatRoomNo}"
				class="btn btn-miso bg-miso w-100">채팅</a>
		</div>
	</div>

	<div class="row mt-3">
		<div class="col club-box-detail">
			<input type="hidden" class="totalCount" value="${meetingCount}">
			<c:choose>
				<c:when test="${clubDto.attachNo!=0}">
					<img
						src="${pageContext.request.contextPath}/club/image?clubNo=${clubDto.clubNo}"
						class="club-detail-image" width="550" height="250">
				</c:when>
				<c:otherwise>
					<img src="${pageContext.request.contextPath}/images/noimage.jpg"
						class="club-detail-image" width="550" height="250">
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<div class="row mt-3">
		<div class="col d-flex justify-content-between align-items-center">
			<div class="d-flex">
				<input type="hidden" class="clubNo" data-no="${clubDto.clubNo}">
				<input type="hidden" class="memberId" data-id="${sessionScope.name}">
				<label class="badge rounded-pill bg-light">${zipDto.sigungu}</label>
				<label class="badge rounded-pill bg-light">${major.majorCategoryName}</label>
				<label class="badge rounded-pill bg-light">멤버 ${memberCount}</label>
			</div>
			<div>
				<c:if test="${editPossible==true}">
					<a href="/club/edit?clubNo=${clubDto.clubNo}"> <i
						class="fa-solid fa-eraser ms-auto"></i>
					</a>
				</c:if>
			</div>
		</div>
	</div>

	<div class="row mt-3">

		<div class="col">
			<div class="col">
				<strong class="main-text">${clubDto.clubName}</strong>
			</div>
			<div class="col mt-2">
				<span>${clubDto.clubExplain}</span>
			</div>
		</div>


	</div>
	<div class="row">
		<div class="col">
			<c:if test="${joinButton==true}">
				<button type="button"
					class="btn btn-miso bg-miso mt-4 join w-100 joinOpen"
					data-bs-toggle="modal">가입하기</button>
			</c:if>

		</div>
	</div>

	<hr>
	<div class="row">
		<div class="col text-start d-flex align-items-center">
			<img src="${pageContext.request.contextPath}/images/logo-door.png"
				width="5%"> <strong class="ms-2 main-text">게시판</strong>
		</div>
	</div>

	<c:choose>
		<c:when test="${clubDetailBoardList[0]==null}">
			<div class="row d-flex align-items-center mt-3">
				<div class="col-3 text-start">
					<img src="${pageContext.request.contextPath}/images/open-door.png"
						width="100%">
				</div>
				<div class="col">
					<div class="col">
						<h5>아직 게시글이 없어요!</h5>
					</div>
					<div class="col">
						<h3>모임 활동을 공유해보세요</h3>
					</div>
				</div>
			</div>
			<div class="row p-1 mt-4 text-center">
				<div class="col">
					<a
						href="${pageContext.request.contextPath}/clubBoard/write?clubNo=${clubDto.clubNo}">
						<button class="btn btn-miso bg-miso w-100 boardWrite">작성하기</button>
					</a>
				</div>
			</div>
		</c:when>

		<c:otherwise>

			<a
				href="${pageContext.request.contextPath}/clubBoard/detail?clubBoardNo=${clubDetailBoardList[0].clubBoardNo}"
				class="link-dark link-underline link-underline-opacity-0 board-detail">
				<div class="row mt-3">
					<div class="col-1">
						<c:choose>
							<c:when test="${clubDetailBoardList[0].attachNo!=0}">
								<img
									src="/rest/member/profileShow?memberId=${clubDetailBoardList[0].memberId}"
									width="50" height="50" class="rounded-circle">
							</c:when>
							<c:otherwise>
								<img src="/images/basic-profile.png" width="50" height="50"
									class="rounded-circle">

							</c:otherwise>

						</c:choose>
					</div>
					<div class="col-10 ms-3">
						<div class="col">
							<span class="badge bg-primary">${clubDetailBoardList[0].clubBoardCategory}</span>
						</div>
						<div class="col mt-1">
							<strong>${clubDetailBoardList[0].memberName}</strong>
						</div>
						<div class="col mt-1"">
							<span class="club-explain">${clubDetailBoardList[0].clubBoardDate}</span>
						</div>
						<div class="col mt-1"">
							<strong>${clubDetailBoardList[0].clubBoardTitle}</strong>
						</div>
						<div class="col mt-1"">${clubDetailBoardList[0].clubBoardContent}</div>
					</div>
				</div>
			</a>


			<div class="row mt-3">
				<div class="col">
					<a
						href="${pageContext.request.contextPath}/clubBoard/list?clubNo=${clubDetailBoardList[0].clubNo}">
						<button class="btn btn-miso bg-miso w-100">게시글 목록가기</button>
					</a>
				</div>
			</div>
		</c:otherwise>
	</c:choose>

	<hr>

	<div class="row">
		<div class="col text-start d-flex align-items-center">
			<img src="${pageContext.request.contextPath}/images/logo-door.png"
				width="5%"> <strong class="ms-2 main-text">정기모임</strong>
		</div>
	</div>

	<div class="row mt-3">
		<div class="col">
			<button type="button" name="makeMeeting"
				class="btn btn-miso bg-miso w-100">정모 만들기</button>
		</div>
	</div>


	<div class="attach-meeting-list mt-3"></div>

	<c:if test="${meetingCount==0}">
		<div class="row d-flex align-items-center mt-3 notMeeting">
			<div class="col-3 text-start">
				<img src="${pageContext.request.contextPath}/images/open-door.png"
					width="100%">
			</div>
			<div class="col">
				<div class="col">
					<h5>아직 정모가 없어요!</h5>
					<!-- 정모는 아무나 만들 수 없음 -->
				</div>
				<div class="col"></div>
			</div>
		</div>
	</c:if>



	<div class="more-btn mt-3">
		<button class="btn btn-miso bg-miso w-100 more">전체보기</button>
		<button class="btn btn-secondary w-100 cut">접기</button>
	</div>
	<hr>

	



	<div class="row">
		<div class="col text-start d-flex align-items-center">
			<img src="${pageContext.request.contextPath}/images/logo-door.png"
				width="5%"> <strong class="ms-2 main-text">사진첩</strong>
		</div>
	</div>

	<c:choose>

		<c:when test="${empty photoList}">
			<div class="row d-flex align-items-center mt-3">
				<div class="col-3 text-start">
					<img src="${pageContext.request.contextPath}/images/open-door.png"
						width="100%">
				</div>
				<div class="col">
					<div class="col">
						<h5>사진첩이 비어있어요</h5>
					</div>
					<div class="col">
						<h4>모임의 특색을 사진으로 표현해보세요!</h4>
					</div>
				</div>
			</div>

			<div class="row p-1 mt-4 text-center">
				<div class="col">
					<a
						href="${pageContext.request.contextPath}/photo/list?clubNo=${clubDto.clubNo}">
						<button class="btn btn-miso bg-miso w-100">사진첩</button>
					</a>
				</div>
			</div>
		</c:when>
		<c:otherwise>

			<a href="/photo/list?clubNo=${clubDto.clubNo}">
				<div class="container">
					<div class="row mt-2">
						<c:forEach var="photoDto" items="${photoList}" varStatus="loop">
							<div class="col-4 p-0 img-box">
								<img src="/rest/photo/download/${photoDto.photoNo}"
									class="attached-image img-thumbnail">
							</div>
							<c:if test="${loop.index % 3 == 2}">
					</div>
					<div class="row">
						</c:if>
						</c:forEach>
					</div>
				</div>
			</a>


		</c:otherwise>

	</c:choose>
	<hr>
	<div class="row">
		<div class="col">
			<div class="row">
				<div class="col text-start d-flex align-items-center">
					<img src="${pageContext.request.contextPath}/images/logo-door.png"
						width="5%"> <strong class="ms-2 main-text">모임멤버</strong>
				</div>
			</div>
		</div>
	</div>
	<div class="clubMemberList"></div>
	<c:if test="${clubMemberNo!=0}">
	<hr>
	<form action="/club/deleteClubMember" method="get">
	<input type="hidden" name="clubMemberNo" value="${clubMemberNo}">
	<input type="hidden" name="clubNo" value="${clubDto.clubNo}">
	<button class="btn btn-danger" name="clubMemberDelete">탈퇴하기</button>
	</form>
	</c:if>
	<%-- <c:forEach var="clubMember" items="${clubMemberDto}" varStatus="loop">
    <div class="row mt-3 mb-4">
        <div class="col memberList">
            <div class="row d-flex align-items-center">
                <div class="col-2 position-relative">
                <a href="/member/mypage?memberId=${clubMember.memberId}">
                    <img src="${pageContext.request.contextPath}/rest/member/profileShow?memberId=${clubMember.memberId}" width="100" height="100" class="rounded-circle">
                    </a>
                    <c:if test="${clubMember.clubMemberRank == '운영진'}">
                        <i class="fa-solid fa-crown fa-lg pt-3 pb-3 ps-2 pe-2 club-member-badge"></i>
                    </c:if>
                </div>
                <div class="col-9 ms-2">
                    <div class="col"><strong>${clubMember.memberName}</strong> | ${clubMember.joinDateString} 가입</div>
                    <div class="col mt-2">${clubMember.joinMessage})</div>
                </div>
            </div>
        </div>
    </div>
</c:forEach> --%>








	<div class="modal fade joinModal" tabIndex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="join-modal-title" id="exampleModalLabel">가입인사를
						작성해주세요</h5>
					<button type="button" class="close" data-bs-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col">
							<input type="text" class="form-control modalJoinMessage">
							<div class="invalid-feedback">가입인사를 작성해주세요</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary cancel" data-bs-dismiss="modal">취소</button>
					<button class="btn btn-miso commit">확인</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 동호회 모임 만드는 Modal -->
	<!-- Button trigger modal -->


	  <!-- Modal -->
   <form action="" enctype="multipart/form-data" class="makeMeetingForm">
      <div class="modal fade" id="exampleModal" tabindex="-1"
         aria-labelledby="exampleModalLabel" aria-hidden="true">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <div class="row">
                     <div
                        class="col text-start d-flex align-items-center modal-title fs-5">
                        <img
                           src="${pageContext.request.contextPath}/images/logo-door.png"
                           width="5%"> <strong class="ms-2" id="exampleModalLabel">정모
                           만들기</strong>
                     </div>
                  </div>

                  <button type="button" class="btn-close addModalCancel"
                     data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body">
                  <div class="preview-wrapper2">
                     <img src="/images/noimage.jpg" width="200" height="200"
                        class="preview">
                  </div>
                  <input type="hidden" class="meetingClubNo"
                     data-no="${clubDto.clubNo}" name="clubNo"
                     value="${clubDto.clubNo}"> <input type="file"
                     class="form-control  meetingImage mt-2" name="attach"
                     id="selector">
                  <div>
                     <input type="text" class="form-control meetingName mt-2"
                        name="meetingName" placeholder="정모 이름">
                     <div class="invalid-feedback">모임 이름을 추가해주세요</div>
                  </div>
                  <div>
                     <input type="date" class="form-control meetingDate mt-2"
                        name="meetingDate">
                     <div class="invalid-feedback">모임 날짜를 지정해주세요</div>
                  </div>
                  <div>
                     <input type="time" class="form-control meetingTime mt-2"
                        name="meetingTime">
                     <div class="invalid-feedback">시간을 지정해주세요</div>
                  </div>
                  <div>
                     <input type="text" class="form-control meetingLocation mt-2"
                        name="meetingLocation" placeholder="위치를 입력하세요">
                     <div class="invalid-feedback">모임 위치를 지정해주세요</div>
                  </div>
                  
  <div class="row mt-2 mb-2">
    <div class="col-12">
        <div class="input-group">
            <input type="number" class="form-control meetingPrice" name="meetingPrice" placeholder="모임비" min="1">
            <div class="input-group-append">
                <span class="input-group-text">원</span>
            </div>
            <div class="invalid-feedback">모임비를 지정해주세요(0이상)</div>
        </div>
    </div>
    <div class="col-12 mt-2">
        <div class="input-group">
            <input type="number" class="form-control meetingMaxPeople" name="meetingNumber" placeholder="모임 정원" min="1">
            <div class="input-group-append">
                <span class="input-group-text">명</span>
            </div>
            <div class="invalid-feedback">모임 정원을 설정해주세요(0이상)</div>
        </div>
    </div>
                  </div>


                  모임공개여부<input class="form-check-input meetingFix ms-1 "
                     type="checkBox" name="meetingFix">

               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-secondary addModalCancel"
                     data-bs-dismiss="modal">취소</button>
                  <button type="submit"
                     class="btn btn-miso bg-miso btn-make-meeting">만들기</button>
               </div>
            </div>
         </div>
      </div>


      <!-- 정모 수정 모달 -->
   </form>




	<div class="modal fade" id="meetingEditModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<div class="row">
						<div
							class="col text-start d-flex align-items-center modal-title fs-5">
							<img
								src="${pageContext.request.contextPath}/images/logo-door.png"
								width="5%"> <strong class="ms-2" id="exampleModalLabel">정모
								수정하기</strong>
						</div>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="preview-wrapper2">
						<img class="preview2" width="200" height="200">
					</div>
					<input type="hidden" class="form-control mt-2 meetingNoByEdit"
						name="meetingNo" value="${meetinDto.meetingNo}"> <input
						type="file" class="form-control mt-2 meetingImageByEdit"
						name="attach" id="selector2">
					<div>
						<input type="text" class="form-control mt-2 meetingNameByEdit"
							name="meetingName" placeholder="정모 이름"
							value="${meetingDto.meetingName}">
						<div class="invalid-feedback">모임 이름을 추가해주세요</div>
					</div>
					<div>
						<input type="date" class="form-control mt-2 meetingDateByEdit"
							name="meetingDate">
						<div class="invalid-feedback">모임 날짜를 지정해주세요</div>
					</div>
					<div>
						<input type="time" class="form-control mt-2 meetingTimeByEdit"
							name="meetingTime">
						<div class="invalid-feedback">시간을 지정해주세요</div>
					</div>
					<div>
						<input type="text" class="form-control mt-2 meetingLocationByEdit"
							name="meetingLocation" placeholder="위치를 입력하세요">
						<div class="invalid-feedback">모임 위치를 지정해주세요</div>
					</div>
					<div class="row mt-2 mb-2">
						<div class="col-7">
							<div class="input-group">
								<input type="number" class="form-control meetingPriceByEdit"
									name="meetingPrice" placeholder="모임비">
								<div class="invalid-feedback">모임비를 지정해주세요(0이상)</div>
								<div class="input-group-append">
									<span class="input-group-text">원</span>
								</div>
							</div>
						</div>
						<div class="col-5">
							<div class="input-group">
								<input type="number" class="form-control meetingMaxPeopleByEdit"
									name="meetingNumber" placeholder="모임 정원">
								<div class="invalid-feedback">모임 정원을 설정해주세요(0이상)</div>
								<div class="input-group-append">
									<span class="input-group-text">명</span>
								</div>
							</div>
						</div>
					</div>
					모임공개여부<input class="form-check-input ms-1 meetingFixByEdit"
						type="checkBox" name="meetingFixByEdit">

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit"
						class="btn btn-miso bg-miso btn-edit-commit">수정하기</button>
				</div>
			</div>
		</div>
	</div>





</body>
<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
