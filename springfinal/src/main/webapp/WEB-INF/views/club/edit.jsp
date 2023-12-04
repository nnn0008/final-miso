<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/hangul-js" type="text/javascript"></script>

<style>
.preview{
margin-top: 1em;
width: 550px;
height: 300px;
border-radius: 1%;
}

 .addr-list {
    position: absolute;
    z-index: 1000;
    max-height: 250px; /* 적절한 높이로 설정 */
    width: 545px;
    overflow: auto; /* 스크롤이 필요한 경우 스크롤 허용 */
    margin-top: 5px;
    }
</style>

 <script>
        $(function(){
            $(".attach-selector").change(function(){
            	
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
        });
    </script>

<script>
	$(function() {
		
		
		

		var no = $(this).find(":selected").val()
		var minorNo = ${clubDto.clubCategory}
		
		console.log(minorNo);

		$.ajax({
			url : window.contextPath+"/rest/category",
			method : "get",
			data : {
				majorCategoryNo : no
			},
			success : function(response) {

				var select2 = $('.select2');
				select2.empty();

				for (var i = 0; i < response.length; i++) {
					
					  var minor = response[i].minorCategoryNo;

			            var option = $("<option>").val(response[i].minorCategoryNo).text(response[i].minorCategoryName);

			            // 선택된 값이면 selected 속성을 추가
			            if (minor == minorNo) {
			                option.attr('selected', true);
			            }

			            select2.append(option);
					
				}
				
			},
		});

		$(".select1").change(
				function() {

					var no = $(this).find(":selected").val()


					$.ajax({
						url : window.contextPath+"/rest/category",
						method : "get",
						data : {
							majorCategoryNo : no
						},
						success : function(response) {
							console.log(response)

							var select2 = $('.select2');
							select2.empty();

							for (var i = 0; i < response.length; i++) {
								select2.append($("<option>").val(
										response[i].minorCategoryNo).text(
										response[i].minorCategoryName));
							}
						},
					});
				});

		$(".select2").change(function() {

			var no = $(this).find(":selected").val();

			$(this).val(no);


		})
		
		
		$("[name=editClub]").click(function(e){
   		
   		if($(".select2").val()==null){
   		e.preventDefault();
   			
   		
   		$(".select2").addClass("is-invalid");
   			
   		}
   		
   		
		if(($("[name=clubName]").val().length==0)||$("[name=clubName]").val().length>15){
   			
   			e.preventDefault();
   			$("[name=clubName]").addClass("is-invalid");
   			
   		}
   		
		if(($("[name=clubExplain]").val().length==0)||$("[name=clubExplain]").val().length>1300){
   			
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
    		$('.newInput').val(0);
    		$(this).data("pass","N");

    		
    		
    		
    	})
    	$(".select2").change(function(){
    		
    		$(this).removeClass("is-invalid");
    		

    		
    		
    		
    	})

	});
</script>

<script>
$(function () {
	

	var form = $('.add');

	form.append(
	    $("<input>")
	        .addClass("newInput")
	        .prop("type", "hidden")
	        .attr("name", "zipCodeNo")
	        .val($(".search-input").data("no"))
	);
	
	
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
	            url: window.contextPath+"/rest/zipPage",
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
	    	
	    	$(".newInput").val($(this).val());
	    			
	    	
	    	
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
         url: window.contextPath+"/rest/zipPage",
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
<!-- <script>
$(function(){
	
	var form=$(".add")
	
	var check = $("<input>");
	check.attr("name","clubPremium")
		.prop("type","hidden");
	
	    if($(".checkBox").prop("checked")){
	        $("[name=clubPremium]").val('Y');
	    } else {
	        $("[name=clubPremium]").val('N');
	    }

	$(".checkBox").change(function(){
		
		  if($(this).prop("checked")){
		        $("[name=clubPremium]").val('Y');
		    } else {
		        $("[name=clubPremium]").val('N');
		    }
		
	});
	
	form.append(check);
	


	
})

</script> -->




 <div class="row">
                            <div class="col text-start d-flex align-items-center"">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2">모임 수정</strong>
                            </div>
                        </div>

<form class="form-control add mt-4" method="post" enctype="multipart/form-data">
<input type="hidden" value="${clubDto.clubNo}" name="clubNo">
	<label>관심사 선택</label>
	<select class="form-select select1">
		<c:forEach var="major" items="${majorList}">
			<c:choose>
				<c:when
					test="${major.majorCategoryName eq majorDto.majorCategoryName}">
					<option selected value="${major.majorCategoryNo}">${majorDto.majorCategoryName}</option>
				</c:when>
				<c:otherwise>
					<option value="${major.majorCategoryNo}">
						${major.majorCategoryName}</option>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</select> 
	<label class="mt-2">하위 카테고리</label>
	<select class="form-select select2" name="clubCategory">
	</select> 
	<label class="mt-2">지역</label>
	<input class="form-control search-input" type="text"
		value="${zipDto.sigungu}" data-no="${zipDto.zipCodeNo}">
		<div class="invalid-feedback">
      동호회 지역을 선택해주세요
    		</div>
	<div class="row">
		<div class="col">
			<ul class="list-group addr-list">
			</ul>
		</div>
	</div>
	<label class="mt-2">사진 업로드</label>
	<input class="form-control attach-selector" type="file" name="attach" accept="image/*">
	
	<div class="preview-wrapper2">
	<c:choose>
	<c:when test="${clubDto.attachNo!=0}">
	<img src="${pageContext.request.contextPath}/club/image?clubNo=${clubDto.clubNo}" width="200" class="preview">
	</c:when>
	<c:otherwise>
	<img src="${pageContext.request.contextPath}/images/noimage.jpg" width="200" height="200" class="preview">
	</c:otherwise>
	</c:choose>
	</div>
	
	<div class="row mt-2">
	<div class="col">
	<label class="mt-2 d-flex align-items-center">
	<img src="${pageContext.request.contextPath}/images/logo-door.png" width="25%" class="me-1">
	모임명</label>
	</div>
	<div class="col-10	">
	<input class="form-control name" value="${clubDto.clubName}" name="clubName">
	<div class="invalid-feedback">
      동호회 이름을 1-15자 이내로 설정해주세요
    		</div>
	</div>
	</div>
	<div class="row mt-2">
	<div class="col">
	<textarea class="form-control" name="clubExplain" rows="4">${clubDto.clubExplain}</textarea>
	<div class="invalid-feedback">
      동호회 설명을 1-1300자 이내로 설정해주세요
    		</div>
	</div>
	</div>
	<div class="row">
	<div class="col">
		<label class="mt-2">정원 (2~${clubDto.clubMaxPersonnel})</label>
		<input type="number" name="clubPersonnel" class="form-control" 
		max="${clubDto.clubMaxPersonnel}" value="${clubDto.clubPersonnel}" min="2">
	<div class="invalid-feedback">
      		동호회 인원을 선택해주세요
    		</div>
	</div>
	</div>	
<%-- 	<div class="row mt-3">
	<div class="col">
	<c:choose>
	<c:when test="${clubDto.clubPremium=='Y'}">
	<label class="form-check-label">
	프리미엄 사용 여부 : 
	</label>
	<input class="form-check-input checkBox" type="checkBox" checked> 
	</c:when>
	<c:otherwise>
	<label class="form-check-label">
	프리미엄 사용 여부 : 
	</label>
	 <input class="form-check-input checkBox" type="checkBox">
	</c:otherwise>
	</c:choose>
	</div>
	</div> --%>
	
<%-- 	<div class="row">
	<div class="col">
	<label>
	모임 개설일 : 	
	${clubDto.clubDate}	
	</label>
	</div>
	</div> --%>
	
	
	<div class="row mt-4 mb-2">
	<div class="col">
	<button class="btn btn-miso btn-lg bg-miso w-100" name="editClub"><strong>수정하기</strong></button>
	</div>
	</div>


</form>




<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>