<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<script>
$(function(){
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
					<input type="file" class="photo-image" accept="image/*" name="photo-image-selector">
				</div>				
			</div>     	
			<div class="row">
				<div class="col preview-photo"></div>
			</div>

     	</div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
