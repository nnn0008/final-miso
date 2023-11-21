<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<style>
.img-thumbnail:hover {
	cursor: pointer;
}
</style>
<script>
$(function(){
	//현재 이 화면에서 남은 작업
	//- 디자인
	//- 웹소켓을 이용하여 댓글, 좋아요 알림
	//- 프로필 사진 끌어오기
	loadList();
	
	//Modal에서 사진 미리보기
	$("[name=photo-image-selector]").change(function(e){
		if(this.files.length == 0) return;
		
		let reader = new FileReader();
		reader.onload = () => {
			$("<img>").attr("src", reader.result).addClass("attached-photo-image").appendTo(".preview-photo");
		};
		
		for(let i = 0; i < this.files.length; i++){
			$(".preview-photo").empty();
			reader.readAsDataURL(this.files[i]);
		}
		
	});
	
	//Modal에서 사진 등록하기
	$(".btn-photo-register").click(function(){
		var photoImage = $(".photo-image")[0].files[0];
		var params = new URLSearchParams(location.search);
   		var clubNo = params.get("clubNo");
		var formData = new FormData();
		formData.append("photoImage", photoImage);
		formData.append("clubNo", clubNo)
		//ajax
		$.ajax({
			url: window.contextPath + "/rest/photo/insert",
			method:"post",
			data: formData,
			contentType: false,
			processData: false,
			success: function(response){
				//파일 전송이 성공하면
				loadList(); //List화면을 갱신
				$("[name=photo-image-selector]").val("");//사진등록 화면 초기화
				$(".preview-photo").empty(); //미리보기 초기화
				//console.log("성공");
			},
			error: function(error){
				//console.error("실패");
			}
		});	
	});
	//사진을 등록하는 modal이 사라질 때 modal 안의 값을 초기화
	$("#exampleModal").on("hidden.bs.modal", function(){
		$("[name=photo-image-selector]").val("");//사진등록 화면 초기화
		$(".preview-photo").empty(); //미리보기 초기화
	});
	
	//화면 등록 후 화면을 갱신
	function loadList(){
		var params = new URLSearchParams(location.search);
   		var clubNo = params.get("clubNo");
   		
   		//이전에 등록된 이벤트 핸들러제거
   		$(".image-attach").off("click", ".img-thumbnail");
   		
   		$.ajax({
   			url: window.contextPath + "/rest/photo/list",
   			method: "post",
   			data: {
   				clubNo: clubNo,
   			},
   			success: function(response){
   				$(".image-attach").empty();
   				for(let i = 0; i < response.length; i++){
	   				//console.log(response[i]);
   					var wrapper = $("<div>").addClass("col-sm-6 col-md-4 col-lg-3 p-3")
   					.append($("<img>").addClass("attached-image img-thumbnail").attr("data-photo-no", response[i].photoNo)
   					.attr("src", window.contextPath + "/rest/photo/download/" + response[i].photoNo));
   					
   					//detail 모달을 열고
   					//$(".img-thumbnail").on("click", function(e){
   					//$(".image-attach").on("click", ".img-thumbnail", function(e){
   					//$(document).on("click", ".image-attach .img-thumbnail", function(e) {
   						$(".image-attach").off("click", ".img-thumbnail").on("click", ".img-thumbnail", function (e) {
	   						$("#exampleModal2").modal("show");
	   						var photoNo = $(this).data("photo-no");
	   						//console.log(photoNo);
	   						//Modal안에 정보가 들어있어야 한다
	   						$.ajax({
	   							url: window.contextPath + "/rest/photo/detail",
	   							method:"post",
	   							data:{
	   								photoNo: photoNo,
	   							},
	   							success: function(response){
	   								//console.log(response);
	   								$(".detail-image").attr("src", window.contextPath + "/rest/photo/download/" + photoNo);
	   								$(".photo-like-count").empty().append(response.photoDto.photoLikecount);
	   								$("#exampleModalLabel2").append(response.memberDto.memberName);
	   							},
	   							error: function(error){
	   								//console.error("에러");
	   								//console.error(error);
	   							}
	   						});
   						
	   						//삭제 버튼을 눌렀다면
	   						$(".btn-image-delete").off("click").on("click", function(){
	   							$.ajax({
	   								url: window.contextPath + "/rest/photo/delete",
	   								method: "post",
	   								data:{
	   									photoNo: photoNo,
	   								},
	   								success: function(response){
	   									loadList(); //삭제 성공 후 목록 정렬
	   								},
	   						 });
						});
   						
   						//좋아요와 관련된 처리
   				   		
   						 //좋아요 여부를 체크
   				   		$.ajax({
   				   			url: window.contextPath + "/rest/photo/check",
   				   			method: "post",
   				   			data: {
   				   				clubNo: clubNo,
   				   				photoNo, photoNo
   				   			},
   				   			success: function(response){
   				   				//console.log(response)
   				   				if(response.check){
   				   					$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
   				   				}
   				   				else{
   				   					$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
   				   				}	
   				   			},
   				   		});
   						
   						//하트 버튼을 클릭했을 때
   						$(".fa-heart").click(function(){
   							$.ajax({
   								url: window.contextPath + "/rest/photo/action",
   								method:"post",
   								data: {
   									photoNo: photoNo,
   									clubNo : clubNo,
   								},
   								success: function(response){
   									//console.log(response);
   									if(response.check){ //좋아요 상태라면
   										$(".fa-heart").removeClass("fa-solid fa-regular")
										.addClass("fa-solid");
   									}
   									else{
   										$(".fa-heart").removeClass("fa-solid fa-regular")
										.addClass("fa-regular");
   									}
   									$(".photo-like-count").empty().append(response.count);
   								}
   							});
   						});
   						
   					
   					}); 
   					
   					
   					
   					$(".image-attach").append(wrapper);
   				}
   			}
   			
   		});

		$("#exampleModal2").on("hidden.bs.modal", function(){
			$(".photo-like-count").empty(); //좋아요 수 초기화
			$("#exampleModalLabel2").empty();
		});
   		 			
   		}
});

</script>
<script>
	
	

</script>
<script id="reply-template" type="text/template">
 <div class="col-12 for-reply-edit mt-2">
	<div class="row">
		<div class="col">
			<h6 class="clubBoardReplyWriter">작성자</h6>
		</div>
		<div class="col">
			<span class="clubBoardReplyDate">MM-dd E HH:mm</span>
		</div>
		<div class="col edit-delete">
			<button type="button" class="btn btn-info btn-open-reply-edit">수정</button>
			<button type="button" class="btn btn-danger btn-reply-delete">삭제</button>
		</div>
	</div>
	<div class="row mt-2">
		<div class="col">
			<pre class="clubBoardReplyContent fs-6">내용</pre>
		</div>
	</div>
<hr>
	<div class="row mt-2 only-attach-reply">
		<div class="col">
			<button type="button" class="btn-subReply"><i class="fa-solid fa-pen-to-square"></i>답글 달기</button>
		</div>
	</div>
 </div>
</script>
<script id="reply-edit-template" type="text/template">
		<form class="reply-edit-form edit-container">
		<input type="hidden" name="clubBoardReplyNo" value="?">
		<div class="row flex-container">
			<div class="col">
				<input type="text" name="clubBoardReplyContent" class="form-control"></textarea>
			</div>
			<div class="col">
				<button type="submit" class="btn btn-success btn-reply-edit">
					<i class="fa-solid fa-check"></i>
					수정
				</button>
			</div>
			<div class="col">
				<button type="button" class="btn btn-danger btn-cancel">
					<i class="fa-solid fa-xmark"></i>
					취소
				</button>
			</div>
		</div>
		</form>
</script>
<script id="reReply-template" type="text/template">
	<form class="reReply-edit-form">
		<input type="hidden" name="clubBoardReplyNo" value="?">
		<div class="row flex-container">
			<div class="col-6">
				<input type="text" name="clubBoardReReplyContent" class="form-control"></textarea>
			</div>
			<div class="col">
				<button type="submit" class="btn btn-success btn-reReply-send">
					<i class="fa-solid fa-check"></i>
					작성
				</button>
			</div>
			<div class="col">
				<button type="button" class="btn btn-danger btn-reReply-cancel">
					<i class="fa-solid fa-xmark"></i>
					취소
				</button>
			</div>
		</div>
		</form>
</script>

<div class="container-fluid">

	<!-- 전체 페이지 폭 관리 -->
	<div class="col-me-10 offset-md-1">

		<!-- 제목 -->
		<div class="row mt-5">
			<div class="col-6 offset-3 text-center">
				<h1>사진첩</h1>
			</div>
		</div>

		<div class="row mt-5">
			<div class="col">
				<!-- insert Modal -->
				<button type="button" class="btn btn-primary w-100"
					data-bs-toggle="modal" data-bs-target="#exampleModal">
					사진등록하기</button>
			</div>
		</div>


		<hr>

		<!-- 이미지 -->
		<div class="row image-attach"></div>
	</div>
</div>

<!-- 사진 등록용 Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="exampleModalLabel">사진 등록</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">

				<div class="container-fluid">

					<div class="row">
						<div class="col">
							<input type="file" class="photo-image form-control"
								accept="image/*" name="photo-image-selector">
						</div>
					</div>
					<div class="row">
						<div class="col preview-photo"></div>
					</div>

				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-primary btn-photo-register"
					data-bs-dismiss="modal">등록</button>
			</div>
		</div>
	</div>
</div>

<!-- detail용 modal -->

<!-- Modal -->
<div class="modal fade" id="exampleModal2" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="exampleModalLabel2"></h1>
				<button type="button" class="btn btn-danger btn-image-delete"
					data-bs-dismiss="modal">사진 삭제</button>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">

				<div class="container-fluid">

					<div class="row">
						<div class="col">
							<img class="detail-image" src="">
						</div>
					</div>

					<div class="row">
						<div class="col">
							<i class="fa-regular fa-heart photo-like" style="color: red"></i>
							<p class="photo-like-count"></p>
						</div>
					</div>

					댓글 창

				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">닫기</button>
				<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
