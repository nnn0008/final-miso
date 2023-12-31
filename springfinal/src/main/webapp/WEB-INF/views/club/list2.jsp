<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
 <link href="${pageContext.request.contextPath}/css/club.css" rel="stylesheet"> 
 
 <style>
 
 #scrollToTopBtn {
        display: none;
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 99;
    }

     .badge.bg-miso{
     font-size: 16px;
     }
     
     .badge.rounded-pill.bg-gray{
     font-size: 14px;
     }
     
     .heart, .heart-fill {
width:20px;
   position: absolute;
    top: 58px;
    left: 70px; 
    display: inline-block;
    opacity: 1;
    z-index: 3;
}
    
</style>



<script>
    $(document).ready(function () {
    	
    	$('#scrollToTopBtn').hide();
        // 스크롤 위치에 따라 맨 위로 이동 버튼을 표시하거나 숨깁니다.
        $(window).scroll(function () {
            if ($(this).scrollTop() > 100) {
                $('#scrollToTopBtn').fadeIn();
            } else {
                $('#scrollToTopBtn').fadeOut();
            }
        });

        // 버튼을 클릭하면 부드럽게 맨 위로 스크롤합니다.
        $('#scrollToTopBtn').click(function () {
            $('html, body').animate({ scrollTop: 0 }, 'fast');
            return false;
        });
    });
</script>

<script>
    	
    $(function(){
    	
    	$(".club-make-link").click(function(e){
    		  e.preventDefault();
    		console.log("링크클릭");
    		
    		$.ajax({
                url: window.contextPath+"/rest/clubMakePossible",
                method: "get",
                success: function (response) {
      				if(response==1){
      				alert("더이상 동호회를 생성하실 수 없습니다. 일반유저 최대 가입 수 5개")
      				window.location.href = $(e.target).attr("href");
      				}
      				else if(response==2){
          				alert("더이상 동호회를 생성하실 수 없습니다. 파워유저 최대 가입 수 12개")
          				}
      				else{
      					 window.location.href = $(e.target).attr("href");
      				}
                }
    		
    		
    	})
    	
    	
    	
    	
    })
    
    })
    
    
    
    </script>

<script>
$(function(){
	 // 300ms 후에 Ajax 요청을 보냄
	loadList();
	
  function truncateClubDescription() {
      var clubDescriptions = document.querySelectorAll('.club-explain');
      

      clubDescriptions.forEach(function (description) {
          const maxLength = 30; // 최대 길이 설정
          var text = description.textContent;

          if (text.length > maxLength) {
              description.textContent = text.substring(0, maxLength) + '...';
          }
      });
  }
  
  
  var page = 1; // 초기 페이지
   var scrollTimeout; // 스크롤 이벤트를 지연시키기 위한 타이머

   // 스크롤 이벤트 핸들러
   $(window).scroll(function () {
       var clubList = $(this);

       if (scrollTimeout) {
           clearTimeout(scrollTimeout); // 이전 타이머가 있다면 제거
       }

       // 200ms 후에 스크롤 이벤트를 처리
       scrollTimeout = setTimeout(function () {
               // 스크롤이 화면의 하단에 도달하면 새로운 데이터 로드
               console.log("하단 도달");
               loadMore();
       }, 200);
   });
	   
	
	function loadList() {
		
		
       var params = new URLSearchParams(location.search);
        var majorCategoryNo = params.get("majorCategoryNo");
       
       
       $.ajax({
           url: window.contextPath +"/rest/majorCategoryClubList",
           method: "get",
           data: {
               whereNo:majorCategoryNo,page:page
           },
           success: function (response) {
           	
     				$(".club-list").empty(); 
           	
               for(var i=0; i<response.length; i++){
               	var clubDto = response[i];
               	
               	
               	var template = $("#club-template").html();
               	var htmlTemplate = $.parseHTML(template);
               	
               	
               	
               	
               	if(clubDto.attachNo!=0){
               	
               	
               	$(htmlTemplate).find(".club-image-list").attr('src',window.contextPath+"/club/image?clubNo=" + clubDto.clubNo);
               	}
               	else{
               
               		
               		$(htmlTemplate).find(".club-image-list").attr('src',window.contextPath+"/images/basic-profile2.png");

               	}
               	
               	console.log(clubDto.plusDay);
               	if(clubDto.plusDay<=7){
            		
            		
            		
                	$(htmlTemplate).find("[name=new]").attr('class',"badge rounded-pill bg-danger badge-new ms-2").text("NEW");
                		
                	}
               	
               	$(htmlTemplate).find(".club-name").text(clubDto.clubName).data("no", clubDto.clubNo);
               	$(htmlTemplate).find(".club-explain").text(clubDto.clubExplain);
               	$(htmlTemplate).find(".club-sidos").text((clubDto.sido)+" "+(clubDto.sigungu));
               	$(htmlTemplate).find(".club-member").text("멤버 "+clubDto.memberCount);
               	$(htmlTemplate).find(".bg-info").text(clubDto.majorCategoryName);
               	$(htmlTemplate).find(".bg-gray").text(clubDto.minorCategoryName);
               	
               	
               	if(clubDto.likeClub==true){
                	$(htmlTemplate).find("[name=heart]").attr
                	('src', window.contextPath+"/images/suit-heart-fill.png")
		            .attr('class',"heart-fill");
                	}
                	if(clubDto.likeClub==false){
                		
                		$(htmlTemplate).find("[name=heart]")
                		.attr('src', window.contextPath+"/images/suit-heart.png")
    		            .attr('class',"heart")
                		
                		
                	}

               	$(".club-list").append(htmlTemplate);
           }
               truncateClubDescription();
       }
       
   })
}
	
	function loadMore() {
		page++; 
       var params = new URLSearchParams(location.search);
       var majorCategoryNo = params.get("majorCategoryNo");
       
       $.ajax({
           url: window.contextPath +"/rest/majorCategoryClubList",
           method: "get",
           data: {
        	   whereNo:majorCategoryNo,page:page
           }, 
           success: function (response) {
           	
           	
               for(var i=0; i<response.length; i++){
               	var clubDto = response[i];
               	
               	
               	var template = $("#club-template").html();
               	var htmlTemplate = $.parseHTML(template);
               	
               	
               	
               	
               	if(clubDto.attachNo!=0){
               	
               	
               	$(htmlTemplate).find(".club-image-list").attr('src',window.contextPath+"/club/image?clubNo=" + clubDto.clubNo);
               	}
               	else{
               
               		
               		$(htmlTemplate).find(".club-image-list").attr('src',window.contextPath+"/images/basic-profile2.png");

               	}
               	
               	if(clubDto.plusDay<=7){
            		
            		
            		
                	$(htmlTemplate).find("[name=new]").attr('class',"badge rounded-pill bg-danger badge-new ms-2").text("NEW");
                		
                	}
               	
               	$(htmlTemplate).find(".club-name").text(clubDto.clubName).data("no", clubDto.clubNo);
               	$(htmlTemplate).find(".club-explain").text(clubDto.clubExplain);
               	$(htmlTemplate).find(".club-sidos").text((clubDto.sido)+" "+(clubDto.sigungu));
               	$(htmlTemplate).find(".club-member").text("멤버 "+clubDto.memberCount);
               	$(htmlTemplate).find(".bg-info").text(clubDto.majorCategoryName);
               	$(htmlTemplate).find(".bg-gray").text(clubDto.minorCategoryName);
               	
               	
               	if(clubDto.likeClub==true){
                	$(htmlTemplate).find("[name=heart]").attr
                	('src', window.contextPath+"/images/suit-heart-fill.png")
		            .attr('class',"heart-fill");
                	}
                	if(clubDto.likeClub==false){
                		
                		$(htmlTemplate).find("[name=heart]")
                		.attr('src', window.contextPath+"/images/suit-heart.png")
    		            .attr('class',"heart")
                		
                		
                	}

               	$(".club-list").append(htmlTemplate);
           }
               truncateClubDescription();
       }
       
   })
}
	
	$(document).on('click',".club-box",function(){
		
		
		    var clubNo = $(this).find(".club-name").data("no");
		     location.href = window.contextPath+'/club/detail?clubNo=' + clubNo; 

		
		
		
	})
	
	$(document).on('click', '.club-box .heart', function (event) {
	    console.log('heart 이미지 클릭');
	    event.stopPropagation(); // 클릭 이벤트 전파(stopPropagation) 방지

	    var clubNo = $(this).closest(".club-box").find(".club-name").data("no");

	    
	    $.ajax({
	        url: window.contextPath +"/rest/wishInsert",
	        method: "post",
	        data: {
	            clubNo: clubNo
	        },
	        success: function (response) {
	            $(event.currentTarget).attr('src', window.contextPath+"/images/suit-heart-fill.png")
	            .attr('class',"heart-fill");
	            event.stopPropagation(); 
	        }
	    });
	});
	
	$(document).on('click', '.club-box .heart-fill', function (event) {
	    console.log('heart 이미지 클릭');
	    event.stopPropagation(); // 클릭 이벤트 전파(stopPropagation) 방지

	    var clubNo = $(this).closest(".club-box").find(".club-name").data("no");

	    console.log("지움시도");
	    $.ajax({
	        url: window.contextPath +"/rest/wishDelete",
	        method: "post",
	        data: {
	            clubNo: clubNo
	        },
	        success: function (response) {
	        	console.log("지움성공");
	            $(event.currentTarget).attr('src', window.contextPath+"/images/suit-heart.png")
	            .attr('class',"heart");
	            event.stopPropagation(); 
	        }
	    });
	});
	
	
	
})

</script>
    
   <div class="container text-center">
    <c:forEach var="category" items="${categoryList}">
        <a href="${pageContext.request.contextPath}/club/list3?minorCategoryNo=${category.minorCategoryNo}&majorCategoryNo=${category.majorCategoryNo}"><span class="badge rounded-pill bg-gray mb-3">${category.minorCategoryName}</span></a>
    </c:forEach>
</div>

<div class="col text-start d-flex align-items-center mb-3">
            <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
            
            <span class="badge bg-miso ms-2">${majorName}</span>
            <strong class="ms-2 main-text">동호회 리스트</strong>
        </div>

<c:if test="${empty clubList}">
<div class="row d-flex align-items-center mt-3">
                                <div class="col-3 text-start">
                                    <img src="${pageContext.request.contextPath}/images/open-door.png" width="100%">
                                </div>
                                <div class="col">
                                	<div class="col">
                                    <h5>해당 카테고리 동호회가 존재하지 않습니다. </h5>
                                	</div>
                                	<div class="col">
                                    <h1>직접 만들어보세요!</h1>
                                	</div>
                                </div>
                            </div>
				<div class="row p-1 mt-4 text-center">
                        <div class="col">
                            <a href="${pageContext.request.contextPath}/club/insert" class="badge rounded-pill bg-miso btn-miso p-3 link w-100 club-make-link">
                                모임 만들기
                            </a>
                        </div>
                    </div>
</c:if>

<script id="club-template" type="text/template">
<div class="row mt-4 mb-3 d-flex align-items-center club-box">
    <div class="col-2">
        <div class="d-flex align-items-center">
                    <img width="80" height="80" class="club-image-list">
            <span name="new"></span>
        </div>
    </div>
    <div class="col-10">
        <div class="col">
            <strong class="club-name">${clubListVO.clubName}</strong>
        </div>
        <div class="col mt-1">
            <span class="club-explain ">${clubListVO.clubExplain}</span>
        </div>
        <div class="col mt-1">
            <strong class="club-sidos">${clubListVO.sido} ${clubListVO.sigungu}</strong> |
            <span class="club-member">멤버 ${clubListVO.memberCount}</span> |
            <span class="badge bg-info">${clubListVO.majorCategoryName}</span>
            <span class="badge rounded-pill bg-gray">${clubListVO.minorCategoryName}</span>
			<img src="${pageContext.request.contextPath}/images/suit-heart.png" class="heart" name="heart"></img>        
</div>
    </div>
</div>
</script>

<div class="club-list">
          
          </div>
	



<button id="scrollToTopBtn" class="btn btn-primary" title="맨 위로 이동">위로</button>

    
    
       <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>