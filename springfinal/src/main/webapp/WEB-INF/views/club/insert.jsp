<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
    <script>
 
    $(function(){
    	
    	var no = $(this).find(":selected").val()
		
    	console.log(no);
    		
    	$.ajax({
            url:"http://localhost:8080/rest/category",
            method:"get",
            data: {majorCategoryNo:no},
            success:function(response){
            	console.log(response)
            	
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
    		
    	console.log(no);
    		
    	$.ajax({
            url:"http://localhost:8080/rest/category",
            method:"get",
            data: {majorCategoryNo:no},
            success:function(response){
            	console.log(response)
            	
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
    		
    		console.log($(this).val());
    		
    	})

    });
    </script>
    
    	<script>
    	$(function () {
    	    // [1] 모든 .zip 엘리먼트 숨기기

    	    // [2] 검색어 입력 처리
    	    $(".search-input").on('input', function () {
    	        console.log("검색중");

    	        if (!/^[가-힣]/.test($(this).val())) {
    	            return;
    	        }

    	        var keyword = $(this).val();
    	        console.log(keyword);

    	        if (keyword.length === 0) {
    	            $(".zip").hide();
    	            return;
    	        }

    	        $.ajax({
    	            url: "http://localhost:8080/rest/zip",
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

    	                    console.log(text);

    	                    zipList.append($("<li>")
    	                        .addClass("list-group-item zip")
    	                        .val(response[i].zipCodeNo)
    	                        .text(text));
    	                }
    	   
    	            }
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
        	    			
        	    	
        	    	

        	        var selectedAddress = $(this).text();
        	        $(".search-input").val(selectedAddress);
        	        $(".zip").hide();
        	        
        	        //console.log($('.newInput').val())
        	    });
    	        
    	        
    	    });
    	    
    	   

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
                <div class="p-4 text-light bg-dark rounded">
                    <h1>자동완성 예제</h1>
                </div>

                <div class="row mt-4">
                    <div class="col">
                        <input type="search" class="form-control search-input"
                            placeholder="동,읍,면을 입력해주세요">
                    </div>                    
                </div>
                <div class="row">
                    <div class="col">
                        <ul class="list-group addr-list">
                        
                      <%--   <c:forEach var="zipList" items="${zipList}">
                            <li class="list-group-item zip">
                            ${zipCodeName}
                            </li>
                        </c:forEach> --%>
                        
                        	 <!-- <li class="list-group-item zip">서울시 서대문구 홍제동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제1동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제2동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제3동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제4동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제5동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제6동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제7동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제8동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제9동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제10동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제11동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제12동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제13동</li>
                            <li class="list-group-item zip">서울시 서대문구 홍제14동</li>
                            <li class="list-group-item zip">전혀관</li>  -->
                        
                        </ul>
                    </div>
                </div>

                <div class="row mt-4">
                    <div class="col">
                        <h1>다음내용</h1>
                    </div>
                </div>
            </div>
        </div>        
    </div>
  
    

    
    
    </form>
    
    
    
    
    </div>
    </div>
    
    
    
    
    <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
    
