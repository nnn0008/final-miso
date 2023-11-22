<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<script>
	$(function () {
		$(".attach-selector").change(function(e){
		    if(this.files.length == 0){
		        return;
		    }
		    let reader = new FileReader();
		    reader.onload = ()=>{
		        $("<img>")
		            .attr("src", reader.result)
		            .css("width", 162.66)
		            .addClass("attach-selected")
		            .appendTo($(".image-preview")); // 이 부분을 원하는 <div> 선택자로 수정해주세요
		    };
		      
		    for(let i = 0; i < this.files.length; i++){
		        reader.readAsDataURL(this.files[i]);
		    }
		});
        $(".image-chooser").change(function () {
            var input = this;
            if (input.files.length == 0) {
                event.preventDefault(); // 폼 제출을 막음
                return;
            };

            var form = new FormData();
            form.append("attach", input.files[0]);

            // 파일을 서버로 전송
            $.ajax({
                url: window.contextPath + "/rest/one/upload",
                method: "post",
                processData: false,
                contentType: false,
                data: form,
                success: function (response) {
                    // 응답 형태 - {"attachNo" : 7}
                    $(".image").attr("src", "/rest/one/download?attachNo=" + response.attachNo);
                    // 미리보기 엘리먼트를 만들어 이미지를 추가
                    $("<img>").attr("src", "/rest/one/download?attachNo=" + response.attachNo)
                        .css("width", "162.66px")
                        .addClass("attach-selected")
                        .attr("data-bs-toggle", "modal")
                        .attr("data-bs-target", "#exampleModal")
                        .appendTo($(".image-preview"));
                },
                error: function () {
                    window.alert("통신 오류 발생\n잠시 후 다시 시도해주세요");
                },
            });
        });

        $(".image-upload").click(function (event) {
            event.preventDefault(); // 기존의 form 제출을 막음

            var form = $("form")[0];
            var formData = new FormData(form);

            // 파일을 서버로 전송
            $.ajax({
                url: window.contextPath + "/insert",
                method: "post",
                processData: false,
                contentType: false,
                data: formData,
                success: function (response) {
                    // 등록 성공 시 동작
                },
                error: function () {
                    window.alert("통신 오류 발생\n잠시 후 다시 시도해주세요");
                },
            });
        });

    });

</script>

	<form method="post" action="insert" autocomplete="off">
	<%-- 답글일 때만 추가 정보를 전송 --%>
	<c:if test="${isReply}">
	<input type="hidden" name="oneParent" value="${originDto.oneNo}">
	</c:if>
	<div class="container">
		<div class="row mt-4">
			<div class="col">
				<c:choose>
	            <c:when test="${isReply}">
					<div class="col text-start d-flex align-items-center ms-3 mt-3">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2">답글 작성</strong>
                        </div>
				</c:when>
				<c:otherwise>
                            <div class="col text-start d-flex align-items-center ms-3 mt-3">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2">게시글 작성</strong>
                        </div>
				</c:otherwise>
            </c:choose>
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<select name="oneCategory" required class="form-select">
					<option  disabled selected hidden>종류를 선택해주세요.</option>
					<option>회원</option>
					<option>동호회</option>
					<option>신고</option>
					<option>고소</option>
					<option>결제</option>
					<option>기타문의</option>
				</select>
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
			<c:choose>
				<c:when test="${isReply}">
				<input type="text" name="oneTitle" class="form-control" placeholder="제목" value="RE:${orginDto.oneTitle}">
				</c:when>
				<c:otherwise>
				<input type="text" name="oneTitle" class="form-control" placeholder="제목" >
				</c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<textarea name="oneContent" class="form-control" placeholder="내용" rows="10" cols="80"></textarea>
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<input type="file">
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<label>
					<input type="file" class="profile-chooser" accept="image/*" style="display:none;">
				<br>
					<i class="fa-regular fa-image blue fa-2x"></i>
				</label>
				<i class="fa-regular fa-trash-can red fa-2x profile-delete"></i>
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<button type="submit" class="btn  bg-miso w-100 mt-3">
				<i class= "fa-solid fa-pen"></i>
				등록
				</button>
			</div>
		</div>
		
		
		
		
		
		
	</div>
	</form>













<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>

