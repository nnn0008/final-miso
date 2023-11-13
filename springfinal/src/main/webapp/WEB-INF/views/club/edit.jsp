<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
i want to go home

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
		
		console.log("zipNo:"+$(".newInput").val());
		console.log("zipNo:"+$(".search-input").data("no"));
		
		

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

	console.log("premium:"+$(".checkBox").val());
	console.log("clubName:"+$(".name").val());

	    if($(".checkBox").prop("checked")){
	        $(".checkBox").val('Y');
	        $(".checkBox").prop("name", "clubPremium");
	    } else {
	        $(".checkBox").val('N');
	        $(".checkBox").prop("name", "clubPremium");
	    }

	    console.log("premium:"+$(".checkBox").val());
	
})

</script>





<form class="form-control add" method="post" enctype="multipart/form-data">
<input type="hidden" value="${clubDto.clubNo}" name="clubNo">
	관심사 상위 카테고리 
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
	하위 카테고리 
	<select class="form-select select2" name="clubCategory">
	</select> 
	지역 <input class="form-control search-input" type="text"
		value="${zipDto.sigungu}" data-no="${zipDto.zipCodeNo}">
	<div class="row">
		<div class="col">
			<ul class="list-group addr-list">
			</ul>
		</div>
	</div>
	사진 업로드<input class="form-control" type="file" name="attach" accept="image/*">
	
	<div class="row mt-2">
	<div class="col">
	모임명
	</div>
	<div class="col-10">
	<input class="form-control name" value="${clubDto.clubName}" name="clubName">
	</div>
	</div>
	<div class="row mt-2">
	<div class="col">
	<textarea class="form-control" name="clubExplain">${clubDto.clubExplain}</textarea>
	</div>
	</div>
	<div class="row">
	<div class="col">
		정원<input type="number" name="clubPersonnel" class="form-control" value="${clubDto.clubPersonnel}">
	</div>
	</div>	
	<div class="row">
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
	
	
	<div class="row">
	<div class="col mt-2">
	<button class="btn btn-primary">수정</button>
	</div>
	</div>


</form>




<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>