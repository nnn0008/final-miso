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
             select2.append($("<option>").text(response[i].minorCategoryName));
                }    
            },
        });
    	})
    	
    	
             //[1] 다 숨겨
             $(".zip").hide();

             //[2] 검색하면 찾아서 보여줘
             $(".search-input").on("input", function(){
                 var keyword = $(this).val();
                 if(keyword.length == 0) {
                     $(".zip").hide();
                     return;
                 }
                 
                 console.log(keyword);

                 var count = 0;
                 $(".zip").each(function(idx, el){
                	 
                	 var presentEl=$(el);
                	
                     var text = $(el).text().trim();
                     //var index = text.indexOf(keyword);
                     //if(index >= 0) {
                     if(count < 5 && Hangul.search(text, keyword) >= 0) {
                    	 
                         $(el).show();
                         count++;
                    	 console.log(count)
                     }
                     else {
                         $(el).hide();
                     }
               
                 

             //[3] 목록 누르면 입력창에 넣어
             $(".addr-list").find(".zip").click(function(){
                 $(".search-input").val($(this).text());
                 $(".zip").hide();
             });
       
    	
    });
    
    });
    
    });
    	
    	
    	
    
    	
	    	
    	
    	
    	
    	
    	
    	
    
    

	</script>
    
    
    
    <h1>동호회 등록</h1>
    
    <div class="row mt-4">
          <div class="col">
    <form class="form-control form-control-lg" method="post" action="insert">
    	
    	상위 카테고리
    	<select class="form-select select1">
    		<c:forEach var="majorCategoryDto" items="${majorCategory}">
    		<option value="${majorCategoryDto.majorCategoryNo}">${majorCategoryDto.majorCategoryName}</option>
    		</c:forEach>
    	</select>
    	하위 카테고리
    	<select class="form-select select2">
    	</select>
    		
    	
    	
    	
    	
    	
    	<div class="row">
    		<div class="col">
    	모임 이름<input class="form-control" type="text" >
    	</div>
    	</div>
    	<div class="row">
    		<div class="col">
    	모임 설명<input class="form-control" type="text">
    	</div>
    	</div>
    	
    	<div class="row">
    		<div class="col">
    	정원<input class="form-control" type="number">
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
                            placeholder="검색할 주소 입력">
                    </div>                    
                </div>
                <div class="row">
                    <div class="col">
                        <ul class="list-group addr-list">
                        
                      <%--   <c:forEach var="zipList" items="${zipList}">
                            <li class="list-group-item zip">
                            #{zipCodeName}
                            </li>
                        </c:forEach> --%>
                        
                        <li class="list-group-item zip">서울시 서대문구 홍제동</li>
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
                            <li class="list-group-item zip">전혀관</li>
                        
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
    
