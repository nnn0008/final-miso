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

		console.log(no);

		$.ajax({
			url : "http://localhost:8080/rest/category",
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

		$(".select1").change(
				function() {

					var no = $(this).find(":selected").val()

					console.log(no);

					$.ajax({
						url : "http://localhost:8080/rest/category",
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

			console.log($(this).val());

		})

	});
</script>

<script>
	$(function() {

		var form = $('.add');

		form.append(
		    $("<input>")
		        .addClass("newInput")
		        .prop("type", "hidden")
		        .attr("name", "zipCodeNo")
		        .val($(".search-input").data("no"))
		);
		
		
		

		// [2] 검색어 입력 처리
		$(".search-input").on('input',function() {
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
										url : "http://localhost:8080/rest/zip",
										method : "get",
										data : {
											keyword : keyword},
										success : function(response) {
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
							$(".addr-list")
									.on("click",".zip",function() {


														
											$(".newInput").val($(this).val());

												var selectedAddress = $(this).text();
												$(".search-input").val(selectedAddress);
												$(".zip").hide();

												//console.log($('.newInput').val())
											});

						});

	});
</script>
<script>
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

</script>




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
	<img src="/images/noimage.jpg" width="200" height="200" class="preview">
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
	</div>
	</div>
	<div class="row mt-2">
	<div class="col">
	<textarea class="form-control" name="clubExplain" rows="3">${clubDto.clubExplain}</textarea>
	</div>
	</div>
	<div class="row">
	<div class="col">
		<label class="mt-2">정원</label>
		<input type="number" name="clubPersonnel" class="form-control" value="${clubDto.clubPersonnel}">
	</div>
	</div>	
	<div class="row mt-3">
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
	</div>
	
	<div class="row">
	<div class="col">
	<label>
	모임 개설일 : 	
	${clubDto.clubDate}	
	</label>
	</div>
	</div>
	
	
	<div class="row mt-4 mb-2">
	<div class="col">
	<button class="btn btn-success btn-lg bg-miso w-100"><strong>수정하기</strong></button>
	</div>
	</div>


</form>




<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>