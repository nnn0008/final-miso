<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
    
    <style>
    .addr-list {
    max-height: 300px; /* 예시: 최대 높이 설정 */
    overflow: auto; /* 스크롤이 필요한 경우 스크롤 허용 */
}
 </style>   
    
    
    <script>
 
    $(function(){
    	
    	var no = $(this).find(":selected").val()
		
    		
    	$.ajax({
            url:"http://localhost:8080/rest/category",
            method:"get",
            data: {majorCategoryNo:no},
            success:function(response){
            	
            var select2 = $('.select2');
             select2.empty(); 
              
            for (var i = 0; i < response.length; i++) {
             select2
             .append($("<option>")
            		 .val(response[i].minorCategoryNo)
            		 .text(response[i].minorCategoryName));
                }    
            },
        });
    	
    	$(".select1").change(function(){
    		
    		var no = $(this).find(":selected").val()
    		
    		
    	$.ajax({
            url:"http://localhost:8080/rest/category",
            method:"get",
            data: {majorCategoryNo:no},
            success:function(response){
            	
            var select2 = $('.select2');
             select2.empty(); 
              
            for (var i = 0; i < response.length; i++) {
             select2
             .append($("<option>")
            		 .val(response[i].minorCategoryNo)
            		 .text(response[i].minorCategoryName));
                }    
            },
        });
    	});
    	
    	$(".select2").change(function(){
    		
    		var no = $(this).find(":selected").val();
    		
    		$(this).val(no);
    		
    		
    	})

    });
    </script>
    
    	<script>
    	$(function () {
    		var searchTimeout;

    		$(".search-input").on('input', function () {
    		    $(".addr-list").show();

    		    var keyword = $(this).val();
    		    console.log("검색 키워드:" + keyword);

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
    		                        (response[i].hdongName != null ? response[i].hdongName + ' ' : '');

    		                    zipList.append($("<li>")
    		                        .addClass("list-group-item zip")
    		                        .val(response[i].zipCodeNo)
    		                        .text(text)
    		                        .data("result", response[i].sigungu)
    		                    );
    		                }
    		            }
    		        });
    		    }, 300); // 300ms 딜레이
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
        	    			
        	    	
        	    	

        	        var selectedAddress = $(this).data("result");
        	        $(".search-input").val(selectedAddress);
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
    	                     (response[i].hdongName != null ? response[i].hdongName + ' ' : '');


    	                 zipList.append($("<li>")
    	                     .addClass("list-group-item zip")
    	                     .val(response[i].zipCodeNo)
    	                     .text(text)
    	                     .data("result", response[i].sigungu)
    	                 );
    	             }
    	         }
    	     });
    	 }


    	});


	</script>
    
    
    
    <h1>동호회 등록</h1>
    
    <div class="row mt-4">
          <div class="col">
    <form action="insert" class="form-control form-control-lg add" method="post">
    	
    	상위 카테고리
    	<select class="form-select select1">
    		<c:forEach var="majorCategoryDto" items="${majorCategory}">
    		<option value="${majorCategoryDto.majorCategoryNo}">${majorCategoryDto.majorCategoryName}</option>
    		</c:forEach>
    	</select>
    	하위 카테고리
    	<select class="form-select select2" name="clubCategory">
    	</select>
    		
    	
    	
    	
    	
    	
    	<div class="row">
    		<div class="col">
    	모임 이름<input class="form-control" type="text" name="clubName">
    	</div>
    	</div>
    	<div class="row">
    		<div class="col">
    	모임 설명<input class="form-control" type="text" name="clubExplain">
    	</div>
    	</div>
    	
    	<div class="row">
    		<div class="col">
    	정원<input class="form-control" type="number" name="clubPersonnel">
    	</div>
    	</div>
    	<div class="row mt-3">
    		<div class="col">
    	<button class="btn btn-primary" type="submit">모임 만들기</button>
    	</div>
    	</div>
    
   
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-10 offset-md-1">
                <div class="row mt-4">
                    <div class="col">
                       지역 <input type="search" class="form-control search-input"
                            placeholder="동,읍,면을 입력해주세요">
                    </div>                    
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
  
    

    
    
    </form>
    
    
    
    
    </div>
    </div>
    
    
    
    
    <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
    
