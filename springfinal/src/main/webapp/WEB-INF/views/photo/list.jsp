<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<style>
	.img-thumbnail:hover{
		cursor: pointer;
	}
</style>
<script>
$(function(){
	
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
   					$(document).on("click", ".img-thumbnail", function(e){
   						$("#exampleModal2").modal("show");
   						var photoNo = $(this).data("photo-no");
   						//Modal안에 정보가 들어있어야 한다
   						$.ajax({
   							url: window.contextPath + "/rest/photo/detail",
   							method:"post",
   							data:{
   								photoNo: photoNo,
   							},
   							success: function(response){
   								
   							}
   						});
   						
   					});
   					
   					
   					
   					$(".image-attach").append(wrapper);
   				}
   			},
   		});
   		
   		
   		
	}
	
});

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
				<button type="button" class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#exampleModal">
				  사진등록하기
				</button>			
			</div>
		</div>
		
		
        <hr>
        
        <!-- 이미지 -->
        <div class="row image-attach">

			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail attached-image"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
			<div class="col-sm-6 col-md-4 col-lg-3 p-3"><img src="https://dummyimage.com/200x200/000/fff" class="w-100 img-thumbnail"></div>
          
        </div>
        </div>
</div>

<!-- 사진 등록용 Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">사진 등록</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
     	
     	<div class="container-fluid">
			
			<div class="row">
				<div class="col">
					<input type="file" class="photo-image form-control" accept="image/*" name="photo-image-selector">
				</div>				
			</div>     	
			<div class="row">
				<div class="col preview-photo"></div>
			</div>

     	</div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary btn-photo-register" data-bs-dismiss="modal">등록</button>
      </div>
    </div>
  </div>
</div>

<!-- detail용 modal -->

<!-- Modal -->
<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">여기에 프로필사진과 이름</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      사진 크게..
      
      	<i class="fa-solid fa-heart" style="color: red"></i>누른 좋아요 -> 이거 누르면 빈 하트로 바뀌고 카운트 -1
      	<i class="fa-regular fa-heart" style="color: red"></i> 좋아요 -> 이거 누르면 찬 하트로 바뀌고 카운트 +1
      
      댓글 창
      
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
