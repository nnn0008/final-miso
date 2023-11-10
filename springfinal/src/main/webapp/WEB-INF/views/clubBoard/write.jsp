<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<style>
	.attach-selected:hover{
		cursor:pointer;
	}
</style>
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
	
	$("[name=clubBoardContent]").blur(function(){
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
	
	$("[name=clubBoardTitle]").blur(function(){
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
	
	$("[name=clubBoardCategory]").change(function(){
		var isValid = $(this).val().length > 0;
		if(isValid) {
			$(this).removeClass("is-invalid");
		}
		else {
			$(this).addClass("is-invalid");
		}
		status.category = isValid;
	});
	
	$(".write-form").submit(function(e){
		console.table(status);
		$("[name=clubBoardTitle], [name=clubBoardContent]").blur();
		$("[name=clubBoardCategory]").change();
		if(status.ok() == false){
			e.preventDefault();
		}
		else{
			$(window).off("beforeunload");
		}
	});
	
	
	/* $("[name=clubBoardFix]").change(function(e){
		if($(this).is(":checked")){
			$(this).val("Y");
			console.log($("[name=clubBoardFix]").val());
		}
		else{
			$(this).val("N");
			console.log($("[name=clubBoardFix]").val());
		}
	}); */
		
	$(window).on("beforeunload", function(){
        return false; //새로고침(F5)을 누르면 할 것인지 물어봄
    });
	
	//사진을 등록했을 때 다음 파일첨부 input을 보여주는 기능
	$(".second-attach").hide();
	$(".third-attach").hide();
	$(".first-attach").on("input",function(){
		$(".second-attach").show();
	});
	$(".second-attach").on("input",function(){
		$(".third-attach").show();
	});
		
	//사진 미리보기
	$(".attach-selector").change(function(e){
		if(this.files.length == 0){
			return;
		}
		let reader = new FileReader();
		reader.onload = ()=>{
			$("<img>").attr("src", reader.result).css("width", 162.66).addClass("attach-selected").attr("data-bs-toggle", "modal").attr("data-bs-target", "#exampleModal")
			.appendTo($(e.target).next("div"));
		};
		
		for(let i = 0; i < this.files.length; i++){
			$(this).next("div").empty();
			reader.readAsDataURL(this.files[i]);
		}
	});
	
	//Modal로 사진을 볼 때(사진을 클릭하면 Modal을 띄우고 그 사진을 Modal에서 미리보기 할 수 있게)
	$(document).on("click", ".attach-selected", function(e){
		console.log(e);
		$(".attach-preview-zoomIn").empty();
		$("<img>").attr("src", $(e.currentTarget).attr("src")).css("max-width", "400px").appendTo(".attach-preview-zoomIn");
	});
	
});


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
				<input type="text" class="form-control w-100" placeholder="제목(40자)" name="clubBoardTitle">
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
				<textarea class="form-control w-100" placeholder="내용" rows="10"  name="clubBoardContent"></textarea>
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-12 text-end">
				<label class="content-length">0</label> / 1300
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-12 text-start">
				<p class="text-info fs-6">사진은 최대 3장까지 등록이 가능합니다</p>
			</div>
		</div>
		
		<div class="row mt-4">	
			<div class="col-4">
				<input type="file" class="form-control first-attach attach-selector" accept="image/*" name="attach">
				<div class="mt-2"></div>
			</div>

			<div class="col-4">
				<input type="file" class="form-control second-attach attach-selector" accept="image/*" name="attachSecond">
				<div class="mt-2"></div>
			</div>

			<div class="col-4">
				<input type="file" class="form-control third-attach attach-selector" accept="image/*" name="attachThird">
				<div class="mt-2"></div>
			</div>
		</div>
		
		<div class="row mt-2">
			<div class="col-12">
				<button type="submit" class="btn btn-success w-100 btn-send">작성하기</button>
			</div>
		</div>
		
		

	
	</div>
</form> 

		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">사진 미리보기</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		       <div class="attach-preview-zoomIn text-center"></div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
		      </div>
		    </div>
		  </div>
		</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>

