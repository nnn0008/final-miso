<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
   <!-- Bootstrap Icons 스타일 시트 추가 -->

   
   <link href="${pageContext.request.contextPath}/css/club.css" rel="stylesheet"> 
 
 <style>
.categori-text{
font-size: 13px;
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
	        
	        
	        $.ajax({
	            url: "/rest/memberPreferList",
	            method: "get",
	            data: {
	                page:page
	            },
	            success: function (response) {
	            	
	      				$(".club-list").empty(); 
	            	
	                for(var i=0; i<response.length; i++){
	                	var clubDto = response[i];
	                	
	                	
	                	var template = $("#club-template").html();
	                	var htmlTemplate = $.parseHTML(template);
	                	
	                	
	                	
	                	
	                	if(clubDto.attachNo!=0){
	                	
	                	
	                	$(htmlTemplate).find(".club-image-list").attr('src',"/club/image?clubNo=" + clubDto.clubNo);
	                	}
	                	else{
	                
	                		
	                		$(htmlTemplate).find(".club-image-list").attr('src',"/images/basic-profile2.png");

	                	}
	                	
	                	$(htmlTemplate).find(".club-name").text(clubDto.clubName).data("no", clubDto.clubNo);
	                	$(htmlTemplate).find(".club-explain").text(clubDto.clubExplain);
	                	$(htmlTemplate).find(".club-sidos").text((clubDto.sido)+" "+(clubDto.sigungu));
	                	$(htmlTemplate).find(".club-member").text("멤버 "+clubDto.memberCount);
	                	$(htmlTemplate).find(".bg-info").text(clubDto.majorCategoryName);
	                	$(htmlTemplate).find(".bg-gray").text(clubDto.minorCategoryName);
	                	
	                	console.log(clubDto.likeClub);
	                	
	                	if(clubDto.likeClub==true){
	                	$(htmlTemplate).find("[name=heart]").attr
	                	('src', "/images/suit-heart-fill.png")
			            .attr('class',"heart-fill");
	                	}
	                	if(clubDto.likeClub==false){
	                		
	                		$(htmlTemplate).find("[name=heart]")
	                		.attr('src', "/images/suit-heart.png")
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
	        
	        
	        $.ajax({
	            url: "/rest/memberPreferList",
	            method: "get",
	            data: {
	                page: page
	            }, 
	            success: function (response) {
	            	
	            	
	                for(var i=0; i<response.length; i++){
	                	var clubDto = response[i];
	                	
	                	
	                	var template = $("#club-template").html();
	                	var htmlTemplate = $.parseHTML(template);
	                	
	                	
	                	
	                	
	                	if(clubDto.attachNo!=0){
	                	
	                	
	                	$(htmlTemplate).find(".club-image-list").attr('src',"/club/image?clubNo=" + clubDto.clubNo);
	                	}
	                	else{
	                
	                		
	                		$(htmlTemplate).find(".club-image-list").attr('src',"/images/basic-profile2.png");

	                	}
	                	
	                	$(htmlTemplate).find(".club-name").text(clubDto.clubName).data("no", clubDto.clubNo);
	                	$(htmlTemplate).find(".club-explain").text(clubDto.clubExplain);
	                	$(htmlTemplate).find(".club-sidos").text((clubDto.sido)+" "+(clubDto.sigungu));
	                	$(htmlTemplate).find(".club-member").text("멤버 "+clubDto.memberCount);
	                	$(htmlTemplate).find(".bg-info").text(clubDto.majorCategoryName);
	                	$(htmlTemplate).find(".bg-gray").text(clubDto.minorCategoryName);
	                	
	                	
	                	if(clubDto.likeClub==true){
		                	$(htmlTemplate).find("[name=heart]").attr
		                	('src', "/images/suit-heart-fill.png")
				            .attr('class',"heart-fill");
		                	}
		                	if(clubDto.likeClub==false){
		                		
		                		$(htmlTemplate).find("[name=heart]")
		                		.attr('src', "/images/suit-heart.png")
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
			     location.href = '/club/detail?clubNo=' + clubNo; 

			
			
			
		})
		
		
		$(document).on('click', ".club-box", function () {
		    var clubNo = $(this).find(".club-name").data("no");
		    location.href = '/club/detail?clubNo=' + clubNo;
		});

		$(document).on('click', '.club-box .heart', function (event) {
		    console.log('heart 이미지 클릭');
		    event.stopPropagation(); // 클릭 이벤트 전파(stopPropagation) 방지

		    var clubNo = $(this).closest(".club-box").find(".club-name").data("no");

		    
		    $.ajax({
		        url: "/rest/wishInsert",
		        method: "post",
		        data: {
		            clubNo: clubNo
		        },
		        success: function (response) {
		            $(event.currentTarget).attr('src', "/images/suit-heart-fill.png")
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
		        url: "/rest/wishDelete",
		        method: "post",
		        data: {
		            clubNo: clubNo
		        },
		        success: function (response) {
		        	console.log("지움성공");
		            $(event.currentTarget).attr('src', "/images/suit-heart.png")
		            .attr('class',"heart");
		            event.stopPropagation(); 
		        }
		    });
		});
		
		
		

		
		
		
		
		
	})

</script>


<div class="container text-center">
    <div class="row align-items-start">
        <c:forEach var="majorCategory" items="${categoryList}" varStatus="loopStatus">
            <div class="col-2 clickable-category">
                <a href="list2?majorCategoryNo=${majorCategory.majorCategoryNo}" 
                class="d-flex flex-column align-items-center link-underline link-underline-opacity-0 link-dark">
                    <div class="icon-container">
                        <img src="../images/${majorCategory.imageName}" alt="${majorCategory.majorCategoryName} icon">
                    </div>
                    <span class="mt-2 categori-text">${majorCategory.majorCategoryName}</span>
                </a>
            </div>
        </c:forEach>
    </div>
</div>

<hr>
		
	 <div class="row">
                            <div class="col text-start d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2 main-text">추천 동호회</strong>
                            </div>
                        </div>
<div class="text-center">
    <span class="badge bg-miso mt-3">${memberPreferList[0].memberName}</span>님의 주소 
    <span class="badge bg-success">${memberPreferList[0].sido}</span>
    지역을 중심으로 한 카테고리 동호회<br>
    <c:forEach var="memberPrefer" items="${memberPreferList}">
        <span class="badge bg-info mt-2">${memberPrefer.majorCategoryName}</span>
    </c:forEach>
</div>

	
<%-- 	<c:forEach var="clubListVO" items="${clubList}">
	
<div class="row mt-4 mb-3 d-flex align-items-center club-box" onclick="location.href='/club/detail?clubNo=${clubListVO.clubNo}'">
    <div class="col-2">
        <div class="d-flex align-items-center">
            <c:choose>
                <c:when test="${clubListVO.attachNo!=0}">
                    <img src="${pageContext.request.contextPath}/club/image?clubNo=${clubListVO.clubNo}"
                        width="80" height="80" class="club-image-list">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/basic-profile2.png"
                        width="80" height="80">
                </c:otherwise>
            </c:choose>

            <span class="badge rounded-pill bg-danger badge-new ms-2">NEW</span>
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
        </div>
    </div>
</div> --%>


	<script id="club-template" type="text/template">
<div class="row mt-4 mb-3 d-flex align-items-center club-box">
    <div class="col-2">
        <div class="d-flex align-items-center">
                    <img width="80" height="80" class="club-image-list">
            <span class="badge rounded-pill bg-danger badge-new ms-2">NEW</span>
		<img src="/images/suit-heart.png" class="heart" name="heart"></img>
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
</div>
    </div>
</div>
</script>

          <div class="club-list">
          
          </div>
	
<!-- 	<div class="row"> -->
<!-- 		<div class="col"> -->
<!--        <div class="alert alert-dismissible alert-light"> -->
<%-- 		<a href="/club/detail?clubNo=${clubListVO.clubNo}"> --%>
<%-- 		<c:choose> --%>
<%-- 		<c:when test="${clubListVO.attachNo!=0}"> --%>
<%-- 		<img src="${pageContext.request.contextPath}/club/image?clubNo=${clubListVO.clubNo}" class="rounded-circle" width="100" height="100"> --%>
<%-- 		</c:when> --%>
<%-- 		<c:otherwise> --%>
<%-- 		<img src="${pageContext.request.contextPath}/images/basic-profile.png" class="rounded-circle" width="80" height="80"> --%>
<%-- 		</c:otherwise> --%>
<%-- 		</c:choose> --%>
<!-- 		</a> -->
<%-- 		<div>클럽 이름 : ${clubListVO.clubName}</div> --%>
<!-- 		<div>클럽 설명 :  -->
<!-- 			<span class="d-inline-block text-truncate" style="max-width: 550px;"> -->
<%--   				${clubListVO.clubExplain} --%>
<!-- 						</span> -->
<!-- 			</div> -->
<%-- 		<div>${clubListVO.sido} ${clubListVO.sigungu}</div> --%>
<%-- 		<div>${clubListVO.majorCategoryName}-${clubListVO.minorCategoryName}</div> --%>
<%-- 		<div>멤버 수 : ${clubListVO.memberCount}</div> --%>
<!--          </div> -->
<!--           </div> -->
		
		




 
    
    
    
    
    
    
      <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>