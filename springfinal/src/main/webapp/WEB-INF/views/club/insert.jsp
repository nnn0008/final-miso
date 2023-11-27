<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
    
  <style>

 .addr-list {
    position: absolute;
    z-index: 1000;
    max-height: 250px; /* 적절한 높이로 설정 */
    width: 545px;
    overflow: auto; /* 스크롤이 필요한 경우 스크롤 허용 */
    margin-top: 5px;
    }

/* 입력창의 상단에 위치하도록 설정 */
.position-relative {
    position: relative;
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

   	$("[name=createClub]").click(function(e){
   		
   		if($(".select2").val()==null){
   		e.preventDefault();
   			
   		
   		$(".select2").addClass("is-invalid");
   			
   		}
   		
   		
   		if($("[name=clubName]").val().length==0){
   			
   			e.preventDefault();
   			$("[name=clubName]").addClass("is-invalid");
   			
   		}
   		
		if($("[name=clubExplain]").val().length==0){
   			
   			e.preventDefault();
   			$("[name=clubExplain]").addClass("is-invalid");
   			
   		}
	if($("[name=clubPersonnel]").val().length==0){
   			
   			e.preventDefault();
   			$("[name=clubPersonnel]").addClass("is-invalid");
   			
   		}
		
	if($(".search-input").data("pass")=='N'){
   			
   			e.preventDefault();
   			$(".search-input").addClass("is-invalid");
   			
   		}
   	});
    	
    	
    	
    	
    	$("[name=clubName]").on('input',function(){
    		
    		$(this).removeClass("is-invalid");
    		
    		
    		
    	})
    	$("[name=clubExplain]").on('input',function(){
    		
    		$(this).removeClass("is-invalid");
    		
    		
    		
    	})
    	$("[name=clubPersonnel]").on('input',function(){
    		
    		$(this).removeClass("is-invalid");
    		
    		
    		
    	})
    	$(".search-input").on('input',function(){
    		
    		$(this).removeClass("is-invalid");
    		
    		//newInput 제거
    		$('.newInput').remove();
    		$(this).data("pass","N");

    		
    		
    		
    	})
    	$(".select2").change(function(){
    		
    		$(this).removeClass("is-invalid");
    		

    		
    		
    		
    	})
    
    	
    	
   	
   	
   	
   	
   	
    });
    
    
    
   	
    
    
    
    
    </script>
    
    	<script>
    	$(function () {
    		var searchTimeout;

    		$(".search-input").on('input', function () {
    		    $(".addr-list").show();

    		    var keyword = $(this).val();

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
        	        $(".search-input").data("pass","Y");
        	        
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
    
    
    
    <div class="row">
                            <div class="col text-start d-flex align-items-center"">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2">모임 만들기</strong>
                            </div>
                        </div>
    
    <div class="row mt-4">
          <div class="col">
    <form action="insert" class="form-control add" method="post">
    	
    	<label>관심사 선택</label>
    	<select class="form-select select1">
    		<c:forEach var="majorCategoryDto" items="${majorCategory}">
    		<option value="${majorCategoryDto.majorCategoryNo}">${majorCategoryDto.majorCategoryName}</option>
    		</c:forEach>
    	</select>
    	<label class="mt-2">하위 카테고리</label>
    	
    	<select class="form-select select2" name="clubCategory">
    	</select>
    	   <div class="invalid-feedback">
      카테고리를 선택해주세요
    		</div>
  		
    	
    	
    	
    	<div class="row">
    		<div class="col">
    	<label class="mt-2">모임 이름</label>
    	<input class="form-control" type="text" name="clubName">
    	<div class="invalid-feedback">
      동호회 이름을 추가해주세요
    		</div>
    	</div>
    	</div>
    	<div class="row">
    		<div class="col">
    	<label class="mt-2">모임 설명</label>
    	<input class="form-control" type="text" name="clubExplain">
    	<div class="invalid-feedback">
      동호회 설명을 추가해주세요
    		</div>
    	</div>
    	</div>
    	
    	<div class="row">
    		<div class="col">
    	<label class="mt-2">정원</label>
    	<input class="form-control" type="number" name="clubPersonnel" min="2">
    	<div class="invalid-feedback">
      		동호회 인원을 선택해주세요
    		</div>
    	</div>
    	</div>
    	
    	<div class="row">
                    <div class="col">
                       <label class="mt-2">지역</label>
                       <input type="search" class="form-control search-input"
                            placeholder="동,읍,면을 입력해주세요" data-pass="N">
                            <div class="invalid-feedback">
      동호회 지역을 선택해주세요
    		</div>
                    </div>                    
                </div>
                <div class="row">
                    <div class="col">
                        <ul class="list-group addr-list">
                        </ul>
                    </div>
                </div>


    	
    	<div class="row mt-4 mb-2">
    		<div class="col">
    	<button class="btn btn-miso btn-lg bg-miso w-100" type="submit" name="createClub">
    	<strong>모임 만들기</strong>
    	</button>
    	</div>
    	
    	</div>
    
   
<!--     <div class="container-fluid"> -->
<!--         <div class="row"> -->
<!--             <div class="col-md-10 offset-md-1"> -->
<!--                 <div class="row mt-4"> -->
<!--                     <div class="col"> -->
<!--                        지역 <input type="search" class="form-control search-input" -->
<!--                             placeholder="동,읍,면을 입력해주세요"> -->
<!--                     </div>                     -->
<!--                 </div> -->
<!--                 <div class="row"> -->
<!--                     <div class="col"> -->
<!--                         <ul class="list-group addr-list"> -->
<!--                         </ul> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div>         -->
<!--     </div> -->
  
    

    
    
    </form>
    
    
    
    
    </div>
    </div>
    
    
    
    
    <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
    
