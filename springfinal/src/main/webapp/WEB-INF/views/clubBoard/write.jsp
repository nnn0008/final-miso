<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<script>
$(function(){
	$(".fail-feedback").hide();
	 var status = {
			title: false,
			content: false,
			category: false,
			ok:function(){
				return this.title && this.content && this.category;
			},
	}; 
	
	$(".content").on("input", function(){
		var content = $(this).val();
		var isInvalid = content.length > 1300 || content.length == 0;
		
		if(isInvalid){
			$(".content-length").text(content.length).addClass("text-danger");
			$(this).addClass("is-invalid");
		}
		else{
			$(".content-length").text(content.length).removeClass("text-danger");
			$(this).removeClass("is-invalid");
		}
		status.content = !isInvalid;
	});
	
	$(".title").on("input", function(){
		var title = $(this).val();
		var isInvalid = title.length > 40 || title.length == 0;
		
		if(isInvalid){
			$(this).addClass("is-invalid");
			$(".fail-feedback").show();
		}
		else{
			$(this).removeClass("is-invalid");
			$(".fail-feedback").hide();
		}
		status.title = !isInvalid;
	});
	
	$(".form-select").change("select", function(){
		var isInvalid = $(this).val() == null;
		if(isInvalid) $(this).addClass("is-invalid");
		else $(this).removeClass("is-invalid");
		status.category = !isInvalid;
	});
	
	$(".write-form").submit(function(e){
		//console.table(status);
		$(".form-control form-select").blur();
		if(status.ok() == false){
			e.preventDefault();
		}
	});
	
	$(".board-fix").change(function(e){
		if($(this).is(":checked")){
			$(".board-fix").val("Y");
			console.log($(this).val());
		}
		else{
			$(".board-fix").val("N");
			console.log($(this).val());
		}
	}); 
	
	
});
	/* window.addEventListener("load", function(){
		document.querySelector("[name=clubBoardFix").addEventListener("change", function() {
		  if (this.checked) {
		    this.value = "Y";
		  } else {
		    this.value = "N";
		  }
		});	
	}); */


</script>

<form method="post" action="write" class="write-form" enctype="multipart/form-data" autocomplete="off"> 
	<input type="hidden" name="clubNo" value="${clubNo}">
	
	<div class="row m-2 mt-4">
		

		<div class="row">
			<div class="col">
				<select name="clubBoardCategory" class="form-select mt-2">
					<option value="">카테고리를 고르세요</option>
					<option value="자유">자유</option>
					<option value="관심사">관심사</option>
					<option value="모임후기">모임후기</option>
					<option value="가입인사">가입인사</option>
					<option value="공지사항">공지사항</option>
				</select>
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-12">
				<input type="text" class="form-control w-100 title" placeholder="제목(40자)" name="clubBoardTitle">
				<p class="fail-feedback text-end mt-1 text-danger fs-6">제목을 다시 정하세요(한글 40자, 영어 120자 이내)</p>
			</div>
		</div>
	
		<div class="row mt-2">
			<div class="col-12">
				<hr>
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-12">
				<textarea class="form-control w-100 content" placeholder="내용" rows="10"  name="clubBoardContent"></textarea>
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-6">
				<label>게시글 상위고정
				<input type="checkbox" class="text-end board-fix" name="clubBoardFix" value='N'>
				</label>
			</div>
			<div class="col-6 text-end">
				<label class="content-length">0</label> / 1300
			</div>
		</div>
		
		<div class="row mt-4">
			<div class="col-12">
				<input type="file" class="form-control" accept="image/*" name="attach">
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-12">
				<button type="submit" class="btn btn-success w-100">작성하기</button>
			</div>
		</div>
		
	
	</div>
</form> 

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>

