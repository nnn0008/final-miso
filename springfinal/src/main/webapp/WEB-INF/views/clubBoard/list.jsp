<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<style>
    .clickable-item {
        border: 1px solid #ddd; /* 테두리 연하게 설정 */
        background-color: transparent;
        cursor: pointer;
        text-decoration: none;
        color: inherit;
        padding: 10px; /* 여백 추가 */
        transition: border-color 0.3s, box-shadow 0.3s; /* 트랜지션 효과 추가 */
    }

.text-image img {
    width: 50%;
    height: auto; 
    max-width: 100%; 
    max-height: 100%; 
    object-fit: cover; 
}

.board-list {
    max-width: 600px; 
    margin: 0 auto;
}

.text-title{
font-size: 18px;
}
    .clickable-item:hover {
        border-color: #ccc; /* 마우스 오버 시 테두리 색 변경 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 마우스 오버 시 그림자 추가 */
        /* text-decoration: underline; /* 선택적으로 밑줄 추가할 수 있음 */ */
    }
    .badge:hover{
    	cursor:pointer;
    }
       .bg-gray{
   background-color: #BAB9B9;
   }
   
   .text-like-count, .text-reply-count{
   color: #43adff;
   }
</style>

<script>
	//jQuery를 이용한 스크롤바의 위치를 보기
    //초기페이지는 1
    var currentPage = 1;
	var loading = false; // 전역으로 선언
    var keyword = "";
	 $(function() {
        $(".go-upside").hide();
	
        //최초의 페이지네이션
        loadList(keyword);
		
        //추가목록을 로드
        loadMore(keyword, currentPage);        	
        	
        $(".badge").click(function(e){
        	console.log("currentPage");
        	$(".go-upside").hide();
//         	e.preventDefault();
        	$(".board-list").empty();
        	keyword = $(this).text().trim();
        	if(keyword == "전체") keyword="";
        	// 페이지 초기화
            currentPage = 1;
        	console.log(currentPage);
        	loadList(keyword);
        	////////////////////
        	$(window).scroll(function() {
                var scrollTop = $(this).scrollTop();
                var windowHeight = $(window).height();
                var documentHeight = $(document).height();
            
               //스크롤 위치 계산
                var scrollPercentage = (scrollTop / (documentHeight - windowHeight)) * 100;
                
            	//콘솔에 스크롤 위치 출력
                console.log('스크롤 위치:', scrollPercentage.toFixed(2) + '%');

                // 표시할 퍼센트 값을 업데이트
                scrollPercent.text(scrollPercentage.toFixed(2) + '%');
    			
//             	var currentPage = parseInt($("#currentPage").val()) + 1;
    	        var params = new URLSearchParams(location.search);
    	        var clubNo = params.get("clubNo");
    	        if(scrollPercentage.toFixed(2) >= 65 && !loading){
    	        	var currentPage = 1;
//     	        	var keyword = "공지사항";
    	        	currentPage ++;
    	        	$(".go-upside").show();
    	        	//console.log('로딩 시작 - 현재 페이지 = ', currentPage);
    	        	loading = true;
    	            
    	            $.ajax({
    	                url: window.contextPath + "/rest/clubBoard/page",
    	                method: "get",
    	                data: {
    	                    clubNo: clubNo,
    	                    page: currentPage,
    	                    keyword: keyword ? keyword : undefined 
    	                },
    	                success: function (response) {
    	                    //currentPage = response.currentPage;
//     	                    console.log('로딩 성공', response);
    						if(response.length == 0){
    							$(window).off("scroll");
    							console.log('스크롤 종료', response);
    						}
    						else{
    	                    // 받아온 데이터를 현재 목록에 추가하는 로직
    	                    for (var i = 0; i < response.length; i++) {
    		                   	console.log(response);
    	                        var clubBoardAllDto = response[i];
    	                        
    	                    	var template = $("#list-template").html();
    	    					var htmlTemplate = $.parseHTML(template);
    	    					
    	    					//프로필 있는지 검토
    	    					if(clubBoardAllDto.attachNoMp != null){
    	    						var profile = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo="+clubBoardAllDto.attachNoMp)
    	     						.addClass("rounded-circle").attr("width", 50).attr("height", 50).attr("data-board-no", response[i].clubBoardNo);
    	     						$(htmlTemplate).find(".for-attach").html(profile);
    	    					}
    	    					else{
    	    						var profile = $("<img>").attr("src",  window.contextPath + "/images/basic-profile.png")
    	    						.addClass("rounded-circle").attr("width", 50).attr("height", 50).attr("data-board-no", response[i].clubBoardNo);
    	    						$(htmlTemplate).find(".for-attach").html(profile);
    	    					}
    	    					//이름
    	    					$(htmlTemplate).find(".text-name").text(clubBoardAllDto.clubBoardName);
    	    					//시간
    							const originalDate = response[i].clubBoardDate;
    		 					const formattedDate = formatDate(originalDate);
    							$(htmlTemplate).find(".text-date").text(formattedDate + "분");	
    	    					//제목
    	    					$(htmlTemplate).find(".text-title").text(clubBoardAllDto.clubBoardTitle);
    	    					//내용
    	    					$(htmlTemplate).find(".text-content").text(clubBoardAllDto.clubBoardContent);
    	    					//사진이 어디에 있냐
    	    					if(clubBoardAllDto.attachNoCbi != null){
    	    						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi);
    	    						$(htmlTemplate).find(".text-image").html(photo);
    	    					}
    	    					else if(clubBoardAllDto.attachNoCbi == null && clubBoardAllDto.attachNoCbi2 != null){
    	    						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi2);
    	    						$(htmlTemplate).find(".text-image").html(photo);
    	    					}
    	    					else if(clubBoardAllDto.attachNoCbi == null && clubBoardAllDto.attachNoCbi2 == null && clubBoardAllDto.attachNoCbi3 != null){
    	    						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi3);
    	    						$(htmlTemplate).find(".text-image").html(photo);
    	    					}
    	    					//좋아요 했는지를 표시하여 하트의 클래스를 변경
    	    					if(response[i].liked == true){
    	    						$(htmlTemplate).find(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
    	    					}
    	    					else{
    	    						$(htmlTemplate).find(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
    	    					}
    	    					//좋아요 카운트
    	    					$(htmlTemplate).find(".text-like-count").text(clubBoardAllDto.clubBoardLikecount);
    	    					//댓글 수
    	    					$(htmlTemplate).find(".text-reply-count").text(clubBoardAllDto.clubBoardReplyCount);
    	    					//카테고리
    	    					$(htmlTemplate).find(".text-category").text(clubBoardAllDto.clubBoardCategory);
    	                        
    	                        $('.board-list').append(htmlTemplate); // 새로운 행을 현재 목록에 추가
    	                        
    	                        $(htmlTemplate).click(function(e){
    	    						var clubBoardNo = $(this).find(".rounded-circle").data("board-no");
    	    						//console.log(clubBoardNo);
    	                        	window.location.href = window.contextPath + "/clubBoard/detail?clubBoardNo=" + clubBoardNo;
    	                        });
    	                    }

    	                    loading = false;
    							
    						}
    	                },
    	                error: function (error) {
    	                    console.error('스크롤 종료', error);
    	                    loading = false;
    	                }
    	            });       	
    	        }
            });
        	
        	
        	
        	
        	
        	
        	
//         	$(window).scroll(function() {
//                 var scrollTop = $(this).scrollTop();
//                 var windowHeight = $(window).height();
//                 var documentHeight = $(document).height();
            
//                //스크롤 위치 계산
//                 var scrollPercentage = (scrollTop / (documentHeight - windowHeight)) * 100;
                
//             	//콘솔에 스크롤 위치 출력
//                 console.log('스크롤 위치:', scrollPercentage.toFixed(2) + '%');

//                 // 표시할 퍼센트 값을 업데이트
//                 scrollPercent.text(scrollPercentage.toFixed(2) + '%');
    			
// //             	var currentPage = parseInt($("#currentPage").val()) + 1;
//     	        var params = new URLSearchParams(location.search);
//     	        var clubNo = params.get("clubNo");
//     	        if(scrollPercentage.toFixed(2) >= 65 && !loading){
//     	        	var currentPage = 1;
// //     	        	var keyword = "공지사항";
//     	        	currentPage ++;
//     	        	$(".go-upside").show();
//     	        	//console.log('로딩 시작 - 현재 페이지 = ', currentPage);
//     	        	loading = true;
    	            
//     	            $.ajax({
//     	                url: window.contextPath + "/rest/clubBoard/page",
//     	                method: "get",
//     	                data: {
//     	                    clubNo: clubNo,
//     	                    page: currentPage,
//     	                    keyword: keyword ? keyword : undefined 
//     	                },
//     	                success: function (response) {
//     	                    //currentPage = response.currentPage;
// //     	                    console.log('로딩 성공', response);
//     						if(response.length == 0){
//     							$(window).off("scroll");
//     							console.log('스크롤 종료', response);
//     						}
//     						else{
//     	                    // 받아온 데이터를 현재 목록에 추가하는 로직
//     	                    for (var i = 0; i < response.length; i++) {
//     		                   	console.log(response);
//     	                        var clubBoardAllDto = response[i];
    	                        
//     	                    	var template = $("#list-template").html();
//     	    					var htmlTemplate = $.parseHTML(template);
    	    					
//     	    					//프로필 있는지 검토
//     	    					if(clubBoardAllDto.attachNoMp != null){
//     	    						var profile = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo="+clubBoardAllDto.attachNoMp)
//     	     						.addClass("rounded-circle").attr("width", 50).attr("height", 50).attr("data-board-no", response[i].clubBoardNo);
//     	     						$(htmlTemplate).find(".for-attach").html(profile);
//     	    					}
//     	    					else{
//     	    						var profile = $("<img>").attr("src",  window.contextPath + "/images/basic-profile.png")
//     	    						.addClass("rounded-circle").attr("width", 50).attr("height", 50).attr("data-board-no", response[i].clubBoardNo);
//     	    						$(htmlTemplate).find(".for-attach").html(profile);
//     	    					}
//     	    					//이름
//     	    					$(htmlTemplate).find(".text-name").text(clubBoardAllDto.clubBoardName);
//     	    					//시간
//     							const originalDate = response[i].clubBoardDate;
//     		 					const formattedDate = formatDate(originalDate);
//     							$(htmlTemplate).find(".text-date").text(formattedDate + "분");	
//     	    					//제목
//     	    					$(htmlTemplate).find(".text-title").text(clubBoardAllDto.clubBoardTitle);
//     	    					//내용
//     	    					$(htmlTemplate).find(".text-content").text(clubBoardAllDto.clubBoardContent);
//     	    					//사진이 어디에 있냐
//     	    					if(clubBoardAllDto.attachNoCbi != null){
//     	    						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi);
//     	    						$(htmlTemplate).find(".text-image").html(photo);
//     	    					}
//     	    					else if(clubBoardAllDto.attachNoCbi == null && clubBoardAllDto.attachNoCbi2 != null){
//     	    						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi2);
//     	    						$(htmlTemplate).find(".text-image").html(photo);
//     	    					}
//     	    					else if(clubBoardAllDto.attachNoCbi == null && clubBoardAllDto.attachNoCbi2 == null && clubBoardAllDto.attachNoCbi3 != null){
//     	    						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi3);
//     	    						$(htmlTemplate).find(".text-image").html(photo);
//     	    					}
//     	    					//좋아요 했는지를 표시하여 하트의 클래스를 변경
//     	    					if(response[i].liked == true){
//     	    						$(htmlTemplate).find(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
//     	    					}
//     	    					else{
//     	    						$(htmlTemplate).find(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
//     	    					}
//     	    					//좋아요 카운트
//     	    					$(htmlTemplate).find(".text-like-count").text(clubBoardAllDto.clubBoardLikecount);
//     	    					//댓글 수
//     	    					$(htmlTemplate).find(".text-reply-count").text(clubBoardAllDto.clubBoardReplyCount);
//     	    					//카테고리
//     	    					$(htmlTemplate).find(".text-category").text(clubBoardAllDto.clubBoardCategory);
    	                        
//     	                        $('.board-list').append(htmlTemplate); // 새로운 행을 현재 목록에 추가
    	                        
//     	                        $(htmlTemplate).click(function(e){
//     	    						var clubBoardNo = $(this).find(".rounded-circle").data("board-no");
//     	    						//console.log(clubBoardNo);
//     	                        	window.location.href = window.contextPath + "/clubBoard/detail?clubBoardNo=" + clubBoardNo;
//     	                        });
//     	                    }

//     	                    loading = false;
    							
//     						}
//     	                },
//     	                error: function (error) {
//     	                    console.error('스크롤 종료', error);
//     	                    loading = false;
//     	                }
//     	            });       	
//     	        }
//             });
        	

        	
//         	console.log("최초 로딩 성공");
//         	loadMore(keyword, currentPage);
//         	console.log("추가 로딩 성공");
        	
        });


    });
	

	
	//최초에 첫 5장을 비동기로
 	function loadList(keyword){
 		currentPage = 1;
 		var params = new URLSearchParams(location.search);
        var clubNo = params.get("clubNo");		 
        $.ajax({
        	url: window.contextPath + "/rest/clubBoard/page",
            method: "get",
            data: {
                clubNo: clubNo,
                page: currentPage,
                keyword: keyword ? keyword : undefined 
            },
            success: function (response) {
                //currentPage = response.currentPage;
                //console.log('로딩 성공', response);
            	if(response.length == 0){
					$(window).off("scroll");
					console.log('스크롤 종료', response);
				}
                // 받아온 데이터를 현재 목록에 추가하는 로직
                for (var i = 0; i < response.length; i++) {
					console.log(response[i]);
                    var clubBoardAllDto = response[i];
                    
                    var template = $("#list-template").html();
					var htmlTemplate = $.parseHTML(template);
					
					//프로필 있는지 검토
					if(clubBoardAllDto.attachNoMp != null){
						var profile = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo="+clubBoardAllDto.attachNoMp)
 						.addClass("rounded-circle").attr("width", 50).attr("height", 50).attr("data-board-no", response[i].clubBoardNo);
 						$(htmlTemplate).find(".for-attach").html(profile);
					}
					else{
						var profile = $("<img>").attr("src",  window.contextPath + "/images/basic-profile.png")
						.addClass("rounded-circle").attr("width", 50).attr("height", 50).attr("data-board-no", response[i].clubBoardNo);
						$(htmlTemplate).find(".for-attach").html(profile);
					}
					//이름
					$(htmlTemplate).find(".text-name").text(clubBoardAllDto.clubBoardName);
					//시간
					const originalDate = response[i].clubBoardDate;
 					const formattedDate = formatDate(originalDate);
					$(htmlTemplate).find(".text-date").text(formattedDate +"분");
					//제목
					$(htmlTemplate).find(".text-title").text(clubBoardAllDto.clubBoardTitle);
					//내용
					$(htmlTemplate).find(".text-content").text(clubBoardAllDto.clubBoardContent);
					//사진이 어디에 있냐
					if(clubBoardAllDto.attachNoCbi != null){
						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi);
						$(htmlTemplate).find(".text-image").html(photo);
					}
					else if(clubBoardAllDto.attachNoCbi == null && clubBoardAllDto.attachNoCbi2 != null){
						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi2);
						$(htmlTemplate).find(".text-image").html(photo);
					}
					else if(clubBoardAllDto.attachNoCbi == null && clubBoardAllDto.attachNoCbi2 == null && clubBoardAllDto.attachNoCbi3 != null){
						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi3);
						$(htmlTemplate).find(".text-image").html(photo);
					}
					//좋아요 했는지를 표시하여 하트의 클래스를 변경
					if(response[i].liked == true){
						$(htmlTemplate).find(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
					}
					else{
						$(htmlTemplate).find(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
					}
					//좋아요
					$(htmlTemplate).find(".text-like-count").text(clubBoardAllDto.clubBoardLikecount);
					//댓글 수
					$(htmlTemplate).find(".text-reply-count").text(clubBoardAllDto.clubBoardReplyCount);
					//카테고리
					$(htmlTemplate).find(".text-category").text(clubBoardAllDto.clubBoardCategory);
					
					$(htmlTemplate).click(function(e){
						var clubBoardNo = $(this).find(".rounded-circle").data("board-no");
						console.log(clubBoardNo);
                    	window.location.href = window.contextPath + "/clubBoard/detail?clubBoardNo=" + clubBoardNo;
                    });
					
                    $('.board-list').append(htmlTemplate);
                }
            },
        });          
 	}	
	
 	//날짜를 수정하는 코드
 	function formatDate(dateString) {
	    const options = {
	        month: 'long',
	        day: 'numeric',
	        hour: 'numeric',
	        minute: 'numeric',
	        hour12: false,  // 24시간 형식으로 표시
	        hourFormat: '2-digit',  // 시를 2자리로 표시
	        minuteFormat: '2-digit',  // 분을 2자리로 표시
	    };
	
	    // 날짜 형식을 월 일 시 분으로 변환
	    var formattedDate = new Date(dateString).toLocaleString('ko-KR', options);
	
	    // 분 뒤에 '분'을 추가
	    formattedDate = formattedDate.replace(':', '시 ');
	
	    return formattedDate;
	}
 	
 	//뒤에 추가목록을 로드
 	function loadMore(keyword, currentPage){
 		var scrollIndicator = $('#scroll-indicator');
        var scrollPercent = $('#scroll-percent');

        $(window).scroll(function() {
            var scrollTop = $(this).scrollTop();
            var windowHeight = $(window).height();
            var documentHeight = $(document).height();
        
           //스크롤 위치 계산
            var scrollPercentage = (scrollTop / (documentHeight - windowHeight)) * 100;
          
        	//콘솔에 스크롤 위치 출력
//             console.log('스크롤 위치:', scrollPercentage.toFixed(2) + '%');

            // 표시할 퍼센트 값을 업데이트
            scrollPercent.text(scrollPercentage.toFixed(2) + '%');
			
//         	var currentPage = parseInt($("#currentPage").val()) + 1;
	        var params = new URLSearchParams(location.search);
	        var clubNo = params.get("clubNo");
	        if(scrollPercentage.toFixed(2) >= 65 && !loading){
	        	currentPage ++;
	        	$(".go-upside").show();
	        	console.log('로딩 시작 - 현재 페이지 = ', currentPage);
	        	loading = true;
	            
	            $.ajax({
	                url: window.contextPath + "/rest/clubBoard/page",
	                method: "get",
	                data: {
	                    clubNo: clubNo,
	                    page: currentPage,
	                    keyword: keyword ? keyword : undefined 
	                },
	                success: function (response) {
	                    //currentPage = response.currentPage;
	                    console.log('로딩 성공', response);
						if(response.length == 0){
							$(window).off("scroll");
							console.log('스크롤 종료', response);
						}
						else{
	                    // 받아온 데이터를 현재 목록에 추가하는 로직
	                    for (var i = 0; i < response.length; i++) {
		                   	console.log(response);
	                        var clubBoardAllDto = response[i];
	                        
	                    	var template = $("#list-template").html();
	    					var htmlTemplate = $.parseHTML(template);
	    					
	    					//프로필 있는지 검토
	    					if(clubBoardAllDto.attachNoMp != null){
	    						var profile = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo="+clubBoardAllDto.attachNoMp)
	     						.addClass("rounded-circle").attr("width", 50).attr("height", 50).attr("data-board-no", response[i].clubBoardNo);
	     						$(htmlTemplate).find(".for-attach").html(profile);
	    					}
	    					else{
	    						var profile = $("<img>").attr("src",  window.contextPath + "/images/basic-profile.png")
	    						.addClass("rounded-circle").attr("width", 50).attr("height", 50).attr("data-board-no", response[i].clubBoardNo);
	    						$(htmlTemplate).find(".for-attach").html(profile);
	    					}
	    					//이름
	    					$(htmlTemplate).find(".text-name").text(clubBoardAllDto.clubBoardName);
	    					//시간
							const originalDate = response[i].clubBoardDate;
		 					const formattedDate = formatDate(originalDate);
							$(htmlTemplate).find(".text-date").text(formattedDate + "분");	
	    					//제목
	    					$(htmlTemplate).find(".text-title").text(clubBoardAllDto.clubBoardTitle);
	    					//내용
	    					$(htmlTemplate).find(".text-content").text(clubBoardAllDto.clubBoardContent);
	    					//사진이 어디에 있냐
	    					if(clubBoardAllDto.attachNoCbi != null){
	    						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi);
	    						$(htmlTemplate).find(".text-image").html(photo);
	    					}
	    					else if(clubBoardAllDto.attachNoCbi == null && clubBoardAllDto.attachNoCbi2 != null){
	    						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi2);
	    						$(htmlTemplate).find(".text-image").html(photo);
	    					}
	    					else if(clubBoardAllDto.attachNoCbi == null && clubBoardAllDto.attachNoCbi2 == null && clubBoardAllDto.attachNoCbi3 != null){
	    						var photo = $("<img>").attr("src", window.contextPath + "/clubBoard/download?attachNo=" + clubBoardAllDto.attachNoCbi3);
	    						$(htmlTemplate).find(".text-image").html(photo);
	    					}
	    					//좋아요 했는지를 표시하여 하트의 클래스를 변경
	    					if(response[i].liked == true){
	    						$(htmlTemplate).find(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
	    					}
	    					else{
	    						$(htmlTemplate).find(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
	    					}
	    					//좋아요 카운트
	    					$(htmlTemplate).find(".text-like-count").text(clubBoardAllDto.clubBoardLikecount);
	    					//댓글 수
	    					$(htmlTemplate).find(".text-reply-count").text(clubBoardAllDto.clubBoardReplyCount);
	    					//카테고리
	    					$(htmlTemplate).find(".text-category").text(clubBoardAllDto.clubBoardCategory);
	                        
	                        $('.board-list').append(htmlTemplate); // 새로운 행을 현재 목록에 추가
	                        
	                        $(htmlTemplate).click(function(e){
	    						var clubBoardNo = $(this).find(".rounded-circle").data("board-no");
	    						//console.log(clubBoardNo);
	                        	window.location.href = window.contextPath + "/clubBoard/detail?clubBoardNo=" + clubBoardNo;
	                        });
	                    }

	                    loading = false;
							
						}
	                },
	                error: function (error) {
	                    console.error('스크롤 종료', error);
	                    loading = false;
	                }
	            });       	
	        }
        });
 	}
 	
function pageReset(){
	currentPage = 1;
	keyword="";
}
</script>
<script id="list-template" type="text/template">
	<div class="col-12 clickable-item mt-2">
			<div class="row d-flex align-items-center">
				<div class="col-1 for-attach"></div>			
				<div class="col ms-2">
					<strong class="text-name"></strong>
					</div>
				<div class="col text-date text-end">아무날짜</div>
			</div>
			<div class="row mt-2">
				<div class="col">
<strong class="text-title"></strong>
</div>
			</div>
			<div class="row mt-2">
    <div class="col-12 text-content mb-2 text-truncate">아무내용</div>
    <div class="col-12 text-image">
        <!-- 이미지 내용 -->
    </div>
</div>

			<div class="row">
				<div class="col">
					<hr/>
				</div>
			</div>
			<div class="row">
				<div class="col text-heart">
					<i class="fa-regular fa-heart me-1" style="color: red"></i> 좋아요<span class="text-like-count ms-1">좋아요 수</span>
					<i class="fa-regular fa-message ms-3"></i><span class="text-reply-count ms-1">댓글 수</span>
				</div>
				<div class="col text-end">
<span class="badge bg-success text-category"></span>
</div>
			</div>
	</div>
</script>

<div class="row">
    <div class="col-3 pe-0">
        <a id="homeLink" href="${pageContext.request.contextPath}/club/detail?clubNo=${clubDto.clubNo}" class="btn btn-miso bg-miso w-100 active">홈</a>
    </div>
    <div class="col-3 pe-0">
        <a id="boardLink" href="${pageContext.request.contextPath}/clubBoard/list?clubNo=${clubDto.clubNo}" class="btn btn-miso bg-miso w-100">게시판</a>
    </div>
    <div class="col-3 pe-0">
        <a id="photoLink" href="${pageContext.request.contextPath}/photo/list?clubNo=${clubDto.clubNo}" class="btn btn-miso bg-miso w-100">사진첩</a>
    </div>
    <div class="col-3">
        <a id="chatLink" href="/chat/enterRoom/${clubDto.chatRoomNo}" class="btn btn-miso bg-miso w-100">채팅</a>
    </div>
</div>

<div class="row mt-3">

    <!-- 좌측 영역 -->
    <div class="col-9">
        <label class="badge rounded-pill bg-primary">
            전체
        </label>

        <label class="badge rounded-pill bg-gray">
            공지사항
        </label>

        <label class="badge rounded-pill bg-gray">
            가입인사
        </label>

        <label class="badge rounded-pill bg-gray">
            모임후기
        </label>

        <label class="badge rounded-pill bg-gray">
            관심사
        </label>

        <label class="badge rounded-pill bg-gray">
            자유
        </label>
    </div>
    
    <!-- 우측 영역 -->
    <div class="col-3">
        <h6 class="text-right">
            <a href="${pageContext.request.contextPath}/clubBoard/write?clubNo=${clubNo}" class="btn btn-outline-secondary w-100">글쓰기</a>
        </h6>
    </div>

</div>

<!-- 게시판 리스트 -->
<div class="row mt-4 board-list"></div>

<!-- 위로 가기 버튼 -->
<div class="row go-upside mt-3">
    <div class="col">
        <a href="#" class="btn btn-miso w-100">위로</a>
    </div>
</div>





<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>