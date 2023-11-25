<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<style>
.img-thumbnail:hover {
	cursor: pointer;
}
.attached-photo-image, .detail-image{
margin-top: 1em;
width: 445px;
border-radius: 1%;
}
.image-box {
    position: relative;
    width: 180px;
    height: 180px;
    overflow: hidden;
}
.attached-image {
    width: 100% !important;
    height: 100% !important;
    object-fit: cover !important; 
}
.img-thumbnail {
    border: none !important; 
}
.row .col .d-flex {
    display: flex;
    align-items: center;
}
.row .col .d-flex i {
    margin-right: 5px; 
}
.btn-outline-secondary{
width: 127px;
}

</style>
<script>
//댓글 관련 처리
$(function(){
	var replyInsertHtmlTemplate = $.parseHTML($("#reply-insert-template").html());
    var params = new URLSearchParams(location.search);
    var clubNo = params.get("clubNo");   
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
   					var wrapper = $("<div>").addClass("col-sm-6 col-md-4 col-lg-4 p-1 image-box")
   					.append($("<img>").addClass("attached-image img-thumbnail").attr("data-photo-no", response[i].photoNo)
   					.attr("src", window.contextPath + "/rest/photo/download/" + response[i].photoNo));
   					//detail 모달을 열고
   					//$(".img-thumbnail").on("click", function(e){
   					//$(".image-attach").on("click", ".img-thumbnail", function(e){
   					//$(document).on("click", ".image-attach .img-thumbnail", function(e) {
   						$(".image-attach").off("click", ".img-thumbnail").on("click", ".img-thumbnail", function (e) {
   							$("#exampleModal2").modal("show");
	   						var photoNo = $(this).data("photo-no");
	   						var memberId = "${sessionScope.name}";
	   						//console.log(photoNo);
	   						//Modal안에 정보가 들어있어야 한다
	   						$.ajax({
	   							url: window.contextPath + "/rest/photo/detail",
	   							method:"post",
	   							data:{
	   								photoNo: photoNo,
	   							},
	   							success: function(response){
	   								console.log(response);
	   								$(".detail-image").attr("src", window.contextPath + "/rest/photo/download/" + photoNo).attr("data-photo-no", photoNo);
	   								$(".photo-like-count").empty().append(response.photoDto.photoLikecount);
	   								$("#exampleModalLabel2").append(response.memberName);
	   								//사진이 보여질때 등록자와 로그인한 유저가 다르면 사진 삭제 버튼을 숨긴다
	   								if(memberId != response.memberId){
		   								$(".btn-outline-danger").hide();   									
	   								}
	   								//모달이 열릴 때, 댓글 목록 불러오기   							
	   	   							loadReplyList(photoNo);
	   								//모달이 열릴 때, 좋아요 여부를 체크
	   	    				   		isLikeCheck(photoNo, clubNo);
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
   				   		//isLikeCheck(photoNo, clubNo);
   						
   						//하트 버튼을 클릭했을 때
   						clickHeart(photoNo, clubNo);

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
   				
   		//게시글 관련		
   		$(".reply-insert-form").submit(function(e){
   	        e.preventDefault();

   	        var photoReplyContent = $(this).find(".reply-write").val();
   	        console.log(photoReplyContent);
   	       	//var photoNo = $(this).parents(".container-fluid").find(".detail-image").data("photo-no");
   	       	var photoNo = $("#exampleModal2 .detail-image").data("photo-no");
   	        console.log("photoNo = " + photoNo);
   	        
   	        if(photoReplyContent.length == 0) return;
   			
   	        $.ajax({
   	            url: window.contextPath + "/rest/reply/photo/insert",
   	            method: "post",
   	            data: {
   	            	photoReplyContent: photoReplyContent,
   	                clubNo: clubNo,
   	                photoNo: photoNo,
   	            },
   	            success: function(response){
   	                console.log("성공");
   	            	$(".reply-write").val("");
   	                loadReplyList(photoNo);
   			      },
   			    });
   		});//여기까지 댓글 insert
   		
	//댓글 목록 갱신
	function loadReplyList(photoNo){
		//var photoNo = $(".detail-image").data("photo-no");
		console.log("photoNo = " + photoNo);
		
		$.ajax({
			url: window.contextPath + "/rest/reply/photo/list",
			method: "post",
			data: {
				photoNo: photoNo,
				clubNo: clubNo,
			},
			success: function(response){
				$(".reply-list").empty();
				
				console.log(response);
				for(var i = 0; i < response.length; i++){
					var replyHtmlTemplate = $.parseHTML($("#reply-template").html());
					
					$(replyHtmlTemplate).find(".photoReplyWriter").text(response[i].photoReplyWriter);
					$(replyHtmlTemplate).find(".photoReplyDate").text(response[i].photoReplyDate);
					$(replyHtmlTemplate).find(".photoReplyContent").text(response[i].photoReplyContent);
					
					//내가 작성한 댓글인지 확인하기
					if(response[i].match == false){ //내가 작성한 댓글이 아니라면
						$(replyHtmlTemplate).find(".edit-delete").hide();
					}
					else{
						$(replyHtmlTemplate).find(".edit-delete").show();
					}
					//대댓글이라면 우측으로 살짝 밀어주기
					if(response[i].photoReplyParent != null){
						$(replyHtmlTemplate).addClass("ms-4");
						$(replyHtmlTemplate).find(".only-attach-reply").remove();
					}
					//댓글 내의 삭제 버튼을 눌렀을 때,
					$(replyHtmlTemplate).find(".btn-reply-delete").attr("data-reply-no", response[i].photoReplyNo).click(function(e){
						var photoReplyNo = $(this).attr("data-reply-no");
						$.ajax({
							url: window.contextPath + "/rest/reply/photo/delete",
							method:"post",
							data:{
								photoReplyNo: photoReplyNo
							},
							//삭제 성공하면
							success:function(response){
								loadReplyList(photoNo); //목록을 갱신 
							},
						});
					});
					//댓글 내의 수정 버튼을 누르면
					$(replyHtmlTemplate).find(".btn-open-reply-edit").attr("data-reply-no", response[i].photoReplyNo).click(function(e){
						var editHtmlTemplate = $.parseHTML($("#reply-edit-template").html());
						
						//기존 댓글 창 숨김
						$(".reply-insert-form").hide();
						
						var photoReplyNo = $(this).data("reply-no");
						var photoReplyContent = $(this).parents(".for-reply-edit").find(".photoReplyContent").text();
						
						$(editHtmlTemplate).find("[name=photoReplyNo]").val(photoReplyNo);
						$(editHtmlTemplate).find("[name=photoReplyContent]").val(photoReplyContent);
						//취소버튼 클릭시
						$(editHtmlTemplate).find(".btn-cancel").click(function(e){
							$(this).parents(".edit-container").prev(".for-reply-edit").show();
							$(this).parents(".edit-container").remove();
						});
						
						//수정 버튼 클릭(폼 제출시)
						$(editHtmlTemplate).submit(function(e){
							e.preventDefault();
							
							$.ajax({
								url: window.contextPath + "/rest/reply/photo/edit",
								method: "post",
								data: $(e.target).serialize(),
								success: function(response){
									loadReplyList(photoNo);
								},
							});
							
						});
						
						//화면 배치
						$(this).parents(".for-reply-edit").hide().after(editHtmlTemplate);S
					});
					
					
					$(".reply-list").append(replyHtmlTemplate);
				}
				
				
				
			},
			error: function(error){
				
			},
		}); //loadReplyList의 최초 ajax 위치
		
		
	}			
   				
   				
   				
});
//좋아요 여부를 체크
function isLikeCheck(photoNo, clubNo){
	$.ajax({
		url: window.contextPath + "/rest/photo/check",
		method: "post",
		data: {
			clubNo: clubNo,
			photoNo, photoNo
		},
		success: function(response){
			console.log(response)
			if(response.check){
				$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
			}
			else{
				$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
			}	
		},
	});   					
}
//좋아요 클릭을 했을 때,
function clickHeart(photoNo, clubNo){
	$(".fa-heart").off("click").on("click", function(){
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
}
</script>

<script id="reply-template" type="text/template">
 <div class="col-12 for-reply-edit mt-2">
	<div class="row">
		<div class="col">
			<h6 class="photoReplyWriter">작성자</h6>
		</div>
		<div class="col">
			<span class="photoReplyDate">MM-dd E HH:mm</span>
		</div>
		<div class="col edit-delete">
			<button type="button" class="btn btn-info btn-open-reply-edit">수정</button>
			<button type="button" class="btn btn-danger btn-reply-delete">삭제</button>
		</div>
	</div>
	<div class="row mt-2">
		<div class="col">
			<pre class="photoReplyContent fs-6">내용</pre>
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
		<input type="hidden" name="photoReplyNo" value="?">
		<div class="row flex-container">
			<div class="col">
				<textarea name="photoReplyContent" class="form-control" rows="3"></textarea>
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
<script id="reply-insert-template" type="text/template">
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

<!-- <div class="container-fluid"> -->

<!-- 	<!-- 전체 페이지 폭 관리 --> 
<!-- 	<div class="col-me-10 offset-md-1"> -->

<div class="row">
    <div class="col-3 pe-0">
        <a id="homeLink" href="${pageContext.request.contextPath}/club/detail?clubNo=${clubDto.clubNo}" class="btn btn-success bg-miso w-100 active">홈</a>
    </div>
    <div class="col-3 pe-0">
        <a id="boardLink" href="${pageContext.request.contextPath}/clubBoard/list?clubNo=${clubDto.clubNo}" class="btn btn-success bg-miso w-100">게시판</a>
    </div>
    <div class="col-3 pe-0">
        <a id="photoLink" href="${pageContext.request.contextPath}/photo/list?clubNo=${clubDto.clubNo}" class="btn btn-success bg-miso w-100">사진첩</a>
    </div>
    <div class="col-3">
        <a id="chatLink" href="/chat/enterRoom/${clubDto.chatRoomNo}" class="btn btn-success bg-miso w-100">채팅</a>
    </div>
</div>

		<!-- 제목 -->
<div class="row mt-3">
    <div class="col-6 text-start d-flex align-items-center">
        <img src="${pageContext.request.contextPath}/images/logo-door.png" width="10%">
        <strong class="ms-2">사진첩</strong>
    </div>
    <div class="col-6 text-end">
        <button type="button" class="btn btn-outline-secondary"
                data-bs-toggle="modal" data-bs-target="#exampleModal">
            사진 등록
        </button>
    </div>
</div>


<!-- 		<div class="row"> -->
<!-- 			<div class="col"> -->
<!-- 				insert Modal -->
<!-- 				<button type="button" class="btn btn-success bg-miso w-100" -->
<!-- 					data-bs-toggle="modal" data-bs-target="#exampleModal"> -->
<!-- 					사진 등록</button> -->
<!-- 			</div> -->
<!-- 		</div> -->


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
			<div class="row mt-2">
                            <div class="col text-start modal-title ms-2 d-flex align-items-center"" id="exampleModalLabel">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2">사진 등록</strong>
                            </div>
                        </div>
<!-- 				<h1 class="modal-title fs-5" id="exampleModalLabel">사진 등록</h1> -->
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
				<button type="button" class="btn btn-success bg-miso btn-photo-register"
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
			<div class="modal-header ms-2">
			<img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
				<h5 class="modal-title fs-5 ms-2" id="exampleModalLabel2"></h5>
<!-- 				<button type="button" class="btn btn-outline-danger btn-image-delete ms-2" -->
<!-- 					data-bs-dismiss="modal">사진 삭제</button> -->
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

					<div class="row mt-3">
    <div class="col">
        <div class="d-flex align-items-center">
            <i class="fa-regular fa-heart fa-xl photo-like" style="color: red"></i>
            <p class="photo-like-count ml-2">좋아요 카운트 숫자</p>
        </div>
    </div>
</div>

				<!-- 댓글 목록 -->
				<div class="row mt-2 reply-list"></div>
			
				<!-- 댓글 작성하는 곳 -->
				<div class="row mt-2">
					<form class="reply-insert-form">
<%-- 						<input type="hidden" name="clubBoardNo" value="${clubBoardDto.clubBoardNo}"> --%>
						<div class="row mt-5">
							<div class="col-10">
								<textarea type="text" class="form-control w-100 reply-write" rows="3" placeholder="댓글을 달아주세요"></textarea>
							</div>
							<div class="col">
								<button type="submit" class="btn btn-reply-send btn-success">전송</button>
							</div>
						</div>
					</form>
				</div>
				
				<div class="modal-footer">
				<button type="button" class="btn btn-outline-danger btn-image-delete ms-2"
						data-bs-dismiss="modal">사진 삭제</button>
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">닫기</button>
					<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
				</div>
			</div>
			</div>
		</div>
<!-- 	</div> -->
<!-- </div> -->

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
