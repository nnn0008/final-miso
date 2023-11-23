<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script>src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	<script>
	$(function(){
	    $("#attach-selector").change(function(){
	    	
	    	 $(".preview-wrapper1").empty();
	    	 
	        if(this.files.length == 0) {
	            return;
	        }

	            $("<img>").attr("src", URL.createObjectURL(this.files[0]))
	                            .css("max-width", "300px")
	                            .appendTo(".preview-wrapper1");
	    });
	});


</script>
	<form action="edit" method="post" enctype="multipart/form-data" autocomplete="off">
		<input type="hidden" name="oneNo" value="${OneDto.oneNo}">
	<div class="container">
	
	<div class="row mt-4">
                   <div class="col text-start d-flex align-items-center ms-3 mt-3">
                       <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                       <strong class="ms-2">게시글 수정</strong>
                   </div>
               </div>
               
		<div class="row mt-3">
			<div class="col">
						<select name="oneCategory" required class="form-select">
					    <option disabled hidden>종류를 선택해주세요.</option>
					    <option value="회원" ${OneDto.oneCategory == '회원' ? 'selected' : ''}>회원</option>
					    <option value="동호회" ${OneDto.oneCategory == '동호회' ? 'selected' : ''}>동호회</option>
					    <option value="신고" ${OneDto.oneCategory == '신고' ? 'selected' : ''}>신고</option>
					    <option value="고소" ${OneDto.oneCategory == '고소' ? 'selected' : ''}>고소</option>
					    <option value="결제" ${OneDto.oneCategory == '결제' ? 'selected' : ''}>결제</option>
					    <option value="기타문의" ${OneDto.oneCategory == '기타문의' ? 'selected' : ''}>기타문의</option>
						</select>		
		</div>
		</div>
		
	<div class="row mt-3">
			<div class="col">
					<input type="text" name="oneTitle" required class="form-control" value="${OneDto.oneTitle}">
	</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
			 
		<textarea name="oneContent" class="form-control"   placeholder="내용" rows="10" cols="80">${OneDto.oneContent}</textarea>
		</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<img src="image?oneNo=${OneDto.oneNo}" width="200" height="200">
			</div>
			<div class="col">
				<input type="file" name="attach" multiple id="attach-selector">    
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<label>
				    <div class="preview-wrapper1"></div>
				</label>
			</div>
		</div>
		
					<div class="row mt-3">
				<div class="col">
					<button type="submit" class="btn bg-miso w-100">
					<i class="fa-solid fa-eraser"></i>
					수정</button>
				</div>
			</div>
			
	</div>
	</form>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>